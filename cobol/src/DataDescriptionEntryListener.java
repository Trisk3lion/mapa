
import java.util.*;
import java.util.logging.Logger;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class DataDescriptionEntryListener extends CobolParserBaseListener {
	public ArrayList<CobolProgram> programs = null;
	public CobolProgram currProgram = null;
	public Logger LOGGER = null;
	public DDNode parent = null;
	public DDNode prev = null;
	public DataLocation locn = null;

	public DataDescriptionEntryListener(
			ArrayList<CobolProgram> programs
			, Logger LOGGER
			) {
		super();
		this.programs = programs;
		this.LOGGER = LOGGER;
	}

	public void enterEveryRule(ParserRuleContext ctx) {  //see CobolBaseListener for allowed functions
		//TestIntegration.LOGGER.finest("enterEveryRule: " + ctx.getClass().getName() + " @line " + ctx.start.getLine() + ": " + ctx.getText());      //code that executes per rule
	}

	public void enterProgramName(CobolParser.ProgramNameContext ctx) { 
		String newProgramName = ctx.getText();
		this.currProgram = null;

		for (CobolProgram pgm: this.programs) {
			if (pgm.hasThisProgramName(newProgramName)) {
				this.currProgram = pgm;
				break;
			}
			CobolProgram newPgm = pgm.nestedProgramNamed(newProgramName);
			if (newPgm != null) {
				this.currProgram = newPgm;
				break;
			}
		}

		if (this.currProgram == null) {
			throw new IllegalArgumentException(
				"program "
				+ newProgramName
				+ " not found in "
				+ this.programs);
		}
	}

	public void enterFileDescriptionEntry(CobolParser.FileDescriptionEntryContext ctx) {
		this.locn = DataLocation.FILEDESCRIPTION;
	}

	public void enterWorkingStorageSection(CobolParser.WorkingStorageSectionContext ctx) {
		this.locn = DataLocation.WORKINGSTORAGE;
	}

	public void enterLocalStorageSection(CobolParser.LocalStorageSectionContext ctx) {
		this.locn = DataLocation.LOCALSTORAGE;
	}

	public void enterLinkageSection(CobolParser.LinkageSectionContext ctx) {
		this.locn = DataLocation.LINKAGE;
	}

	public void enterDataDescriptionEntry(CobolParser.DataDescriptionEntryContext ctx) {
		/**
		*/
		String callingModuleName = this.currProgram.getProgramName();
		DDNode node = null;

		if (ctx.dataDescriptionEntryExecSql() == null) {
			node = new DDNode(this.currProgram, ctx, locn);
		} else {
			return;
		}

		TestIntegration.LOGGER.finest(callingModuleName + " " + node);

		if (node.hasNoParent()) {
			TestIntegration.LOGGER.finest(node + "node.hasNoParent() == true");
			if (node.isNewRoot()) {
				TestIntegration.LOGGER.finest(node + "node.isNewRoot() == true");
				prev = node;
			} else {
				TestIntegration.LOGGER.finest(node + "node.isNewRoot() == false");
				// a 77 level
			}
		} else if (prev == null) {
				TestIntegration.LOGGER.finest(callingModuleName + " " + node + "prev == " + prev);
		} else if (node.level == null) {
				TestIntegration.LOGGER.finest(callingModuleName + " " + node + "node.level == " + node.level);
		} else if (prev.level == null) {
				TestIntegration.LOGGER.finest(callingModuleName + " " + prev);
		} else if (node.level.compareTo(prev.level) == 0) {
				prev.parent.adopt(node);
				node.parent = prev.parent;
				prev = node;
		} else {
				while (node.level.compareTo(prev.level) <= 0) {
					prev = prev.parent;
				}
				prev.adopt(node);
				node.parent = prev;
				if (!node.isSpecialLevel()) {
					prev = node;
				}
		}

		this.currProgram.addDDNode(node);
	}

}
