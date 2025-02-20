// Generated from src/JCLParser.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link JCLParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface JCLParserVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link JCLParser#startRule}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStartRule(JCLParser.StartRuleContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jcl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJcl(JCLParser.JclContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execJCL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecJCL(JCLParser.ExecJCLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#procJCL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcJCL(JCLParser.ProcJCLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#procStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcStatement(JCLParser.ProcStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#defineSymbolicParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefineSymbolicParameter(JCLParser.DefineSymbolicParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#definedSymbolicParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefinedSymbolicParameters(JCLParser.DefinedSymbolicParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#commentStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCommentStatement(JCLParser.CommentStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#inlineComment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInlineComment(JCLParser.InlineCommentContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#stepName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStepName(JCLParser.StepNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#procName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcName(JCLParser.ProcNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jclStep}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJclStep(JCLParser.JclStepContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#keywordOrSymbolic}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKeywordOrSymbolic(JCLParser.KeywordOrSymbolicContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#datasetName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDatasetName(JCLParser.DatasetNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecStatement(JCLParser.ExecStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execPgmStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecPgmStatement(JCLParser.ExecPgmStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execProcStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecProcStatement(JCLParser.ExecProcStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execProcParm}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecProcParm(JCLParser.ExecProcParmContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParameter(JCLParser.ExecParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParameterOverrides}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParameterOverrides(JCLParser.ExecParameterOverridesContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmACCT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmACCT(JCLParser.ExecParmACCTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmADDRSPC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmADDRSPC(JCLParser.ExecParmADDRSPCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmCCSID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmCCSID(JCLParser.ExecParmCCSIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmCOND}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmCOND(JCLParser.ExecParmCONDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmDYNAMNBR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmDYNAMNBR(JCLParser.ExecParmDYNAMNBRContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmMEMLIMIT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmMEMLIMIT(JCLParser.ExecParmMEMLIMITContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmPARM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmPARM(JCLParser.ExecParmPARMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmPARMDD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmPARMDD(JCLParser.ExecParmPARMDDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmPERFORM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmPERFORM(JCLParser.ExecParmPERFORMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmRD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmRD(JCLParser.ExecParmRDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmREGION}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmREGION(JCLParser.ExecParmREGIONContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmREGIONX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmREGIONX(JCLParser.ExecParmREGIONXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmRLSTMOUT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmRLSTMOUT(JCLParser.ExecParmRLSTMOUTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmTIME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmTIME(JCLParser.ExecParmTIMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmTVSMSG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmTVSMSG(JCLParser.ExecParmTVSMSGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#execParmTVSAMCOM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExecParmTVSAMCOM(JCLParser.ExecParmTVSAMCOMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdStatement(JCLParser.DdStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddStatementConcatenation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdStatementConcatenation(JCLParser.DdStatementConcatenationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddStatementAmalgamation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdStatementAmalgamation(JCLParser.DdStatementAmalgamationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdName(JCLParser.DdNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParameter(JCLParser.DdParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmACCODE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmACCODE(JCLParser.DdParmACCODEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmAMP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmAMP(JCLParser.DdParmAMPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmASTERISK}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmASTERISK(JCLParser.DdParmASTERISKContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmASTERISK_DATA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmASTERISK_DATA(JCLParser.DdParmASTERISK_DATAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmAVGREC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmAVGREC(JCLParser.DdParmAVGRECContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBFALN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBFALN(JCLParser.DdParmBFALNContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBFTEK}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBFTEK(JCLParser.DdParmBFTEKContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBLKSIZE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBLKSIZE(JCLParser.DdParmBLKSIZEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBLKSZLIM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBLKSZLIM(JCLParser.DdParmBLKSZLIMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFIN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFIN(JCLParser.DdParmBUFINContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFL(JCLParser.DdParmBUFLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFMAX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFMAX(JCLParser.DdParmBUFMAXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFNO}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFNO(JCLParser.DdParmBUFNOContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFOFF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFOFF(JCLParser.DdParmBUFOFFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFOUT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFOUT(JCLParser.DdParmBUFOUTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBUFSIZE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBUFSIZE(JCLParser.DdParmBUFSIZEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmBURST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmBURST(JCLParser.DdParmBURSTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCCSID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCCSID(JCLParser.DdParmCCSIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCHARS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCHARS(JCLParser.DdParmCHARSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCHKPT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCHKPT(JCLParser.DdParmCHKPTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCNTL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCNTL(JCLParser.DdParmCNTLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCOPIES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCOPIES(JCLParser.DdParmCOPIESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCPRI}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCPRI(JCLParser.DdParmCPRIContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmCYLOFL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmCYLOFL(JCLParser.DdParmCYLOFLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDATA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDATA(JCLParser.DdParmDATAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDATACLAS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDATACLAS(JCLParser.DdParmDATACLASContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDCB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDCB(JCLParser.DdParmDCBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDCB_Parameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDCB_Parameter(JCLParser.DdParmDCB_ParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDDNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDDNAME(JCLParser.DdParmDDNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDEN(JCLParser.DdParmDENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDEST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDEST(JCLParser.DdParmDESTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDIAGNS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDIAGNS(JCLParser.DdParmDIAGNSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDISP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDISP(JCLParser.DdParmDISPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDLM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDLM(JCLParser.DdParmDLMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDSID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDSID(JCLParser.DdParmDSIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDSKEYLBL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDSKEYLBL(JCLParser.DdParmDSKEYLBLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDSNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDSNAME(JCLParser.DdParmDSNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDSNTYPE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDSNTYPE(JCLParser.DdParmDSNTYPEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDSORG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDSORG(JCLParser.DdParmDSORGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDUMMY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDUMMY(JCLParser.DdParmDUMMYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmDYNAM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmDYNAM(JCLParser.DdParmDYNAMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmEATTR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmEATTR(JCLParser.DdParmEATTRContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmEROPT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmEROPT(JCLParser.DdParmEROPTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmEXPDT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmEXPDT(JCLParser.DdParmEXPDTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFCB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFCB(JCLParser.DdParmFCBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFILEDATA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFILEDATA(JCLParser.DdParmFILEDATAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFLASH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFLASH(JCLParser.DdParmFLASHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFREE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFREE(JCLParser.DdParmFREEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFREEVOL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFREEVOL(JCLParser.DdParmFREEVOLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmFUNC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmFUNC(JCLParser.DdParmFUNCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmGDGORDER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmGDGORDER(JCLParser.DdParmGDGORDERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmGNCP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmGNCP(JCLParser.DdParmGNCPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmHOLD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmHOLD(JCLParser.DdParmHOLDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmINTVL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmINTVL(JCLParser.DdParmINTVLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmIPLTXID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmIPLTXID(JCLParser.DdParmIPLTXIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYLABL1}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYLABL1(JCLParser.DdParmKEYLABL1Context ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYLABL2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYLABL2(JCLParser.DdParmKEYLABL2Context ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYENCD1}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYENCD1(JCLParser.DdParmKEYENCD1Context ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYENCD2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYENCD2(JCLParser.DdParmKEYENCD2Context ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYLEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYLEN(JCLParser.DdParmKEYLENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmKEYOFF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmKEYOFF(JCLParser.DdParmKEYOFFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmLABEL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmLABEL(JCLParser.DdParmLABELContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmLGSTREAM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmLGSTREAM(JCLParser.DdParmLGSTREAMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmLIKE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmLIKE(JCLParser.DdParmLIKEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmLIMCT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmLIMCT(JCLParser.DdParmLIMCTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmLRECL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmLRECL(JCLParser.DdParmLRECLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmMAXGENS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmMAXGENS(JCLParser.DdParmMAXGENSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmMGMTCLAS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmMGMTCLAS(JCLParser.DdParmMGMTCLASContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmMODE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmMODE(JCLParser.DdParmMODEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmMODIFY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmMODIFY(JCLParser.DdParmMODIFYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmNCP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmNCP(JCLParser.DdParmNCPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmNTM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmNTM(JCLParser.DdParmNTMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmNULLOVRD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmNULLOVRD(JCLParser.DdParmNULLOVRDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmOPTCD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmOPTCD(JCLParser.DdParmOPTCDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmOUTLIM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmOUTLIM(JCLParser.DdParmOUTLIMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmOUTPUT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmOUTPUT(JCLParser.DdParmOUTPUTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPATH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPATH(JCLParser.DdParmPATHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPATHDISP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPATHDISP(JCLParser.DdParmPATHDISPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPATHMODE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPATHMODE(JCLParser.DdParmPATHMODEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPATHOPTS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPATHOPTS(JCLParser.DdParmPATHOPTSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPCI}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPCI(JCLParser.DdParmPCIContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPROTECT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPROTECT(JCLParser.DdParmPROTECTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmPRTSP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmPRTSP(JCLParser.DdParmPRTSPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRECFM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRECFM(JCLParser.DdParmRECFMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRECORG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRECORG(JCLParser.DdParmRECORGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmREFDD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmREFDD(JCLParser.DdParmREFDDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRESERVE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRESERVE(JCLParser.DdParmRESERVEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRETPD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRETPD(JCLParser.DdParmRETPDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRKP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRKP(JCLParser.DdParmRKPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmRLS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmRLS(JCLParser.DdParmRLSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmROACCESS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmROACCESS(JCLParser.DdParmROACCESSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSECMODEL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSECMODEL(JCLParser.DdParmSECMODELContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSEGMENT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSEGMENT(JCLParser.DdParmSEGMENTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSEP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSEP(JCLParser.DdParmSEPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSPACE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSPACE(JCLParser.DdParmSPACEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSPIN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSPIN(JCLParser.DdParmSPINContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSTACK}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSTACK(JCLParser.DdParmSTACKContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSTORCLAS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSTORCLAS(JCLParser.DdParmSTORCLASContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSUBSYS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSUBSYS(JCLParser.DdParmSUBSYSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSYMBOLS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSYMBOLS(JCLParser.DdParmSYMBOLSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSYMLIST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSYMLIST(JCLParser.DdParmSYMLISTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmSYSOUT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmSYSOUT(JCLParser.DdParmSYSOUTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmTERM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmTERM(JCLParser.DdParmTERMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmTHRESH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmTHRESH(JCLParser.DdParmTHRESHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmTRTCH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmTRTCH(JCLParser.DdParmTRTCHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmUCS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmUCS(JCLParser.DdParmUCSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmUNIT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmUNIT(JCLParser.DdParmUNITContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ddParmVOLUME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDdParmVOLUME(JCLParser.DdParmVOLUMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#joblibStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJoblibStatement(JCLParser.JoblibStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#joblibConcatenation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJoblibConcatenation(JCLParser.JoblibConcatenationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#joblibAmalgamation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJoblibAmalgamation(JCLParser.JoblibAmalgamationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#joblibParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJoblibParameter(JCLParser.JoblibParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#syschkStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSyschkStatement(JCLParser.SyschkStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#syschkConcatenation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSyschkConcatenation(JCLParser.SyschkConcatenationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#syschkAmalgamation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSyschkAmalgamation(JCLParser.SyschkAmalgamationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#syschkParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSyschkParameter(JCLParser.SyschkParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobCard}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobCard(JCLParser.JobCardContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobName(JCLParser.JobNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobAccountingInformation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobAccountingInformation(JCLParser.JobAccountingInformationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobProgrammerName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobProgrammerName(JCLParser.JobProgrammerNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobKeywordParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobKeywordParameter(JCLParser.JobKeywordParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmBYTES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmBYTES(JCLParser.JobParmBYTESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmCARDS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmCARDS(JCLParser.JobParmCARDSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmLINES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmLINES(JCLParser.JobParmLINESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmPAGES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmPAGES(JCLParser.JobParmPAGESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmADDRSPC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmADDRSPC(JCLParser.JobParmADDRSPCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmCCSID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmCCSID(JCLParser.JobParmCCSIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmCLASS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmCLASS(JCLParser.JobParmCLASSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmCOND}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmCOND(JCLParser.JobParmCONDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmDSENQSHR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmDSENQSHR(JCLParser.JobParmDSENQSHRContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmEMAIL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmEMAIL(JCLParser.JobParmEMAILContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmGDGBIAS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmGDGBIAS(JCLParser.JobParmGDGBIASContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmGROUP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmGROUP(JCLParser.JobParmGROUPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmJESLOG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmJESLOG(JCLParser.JobParmJESLOGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmJOBRC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmJOBRC(JCLParser.JobParmJOBRCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmMEMLIMIT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmMEMLIMIT(JCLParser.JobParmMEMLIMITContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmMSGCLASS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmMSGCLASS(JCLParser.JobParmMSGCLASSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmMSGLEVEL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmMSGLEVEL(JCLParser.JobParmMSGLEVELContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmNOTIFY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmNOTIFY(JCLParser.JobParmNOTIFYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#nameOrSymbolic}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNameOrSymbolic(JCLParser.NameOrSymbolicContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmPASSWORD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmPASSWORD(JCLParser.JobParmPASSWORDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmPERFORM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmPERFORM(JCLParser.JobParmPERFORMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmPRTY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmPRTY(JCLParser.JobParmPRTYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmRD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmRD(JCLParser.JobParmRDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmREGION}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmREGION(JCLParser.JobParmREGIONContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmREGIONX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmREGIONX(JCLParser.JobParmREGIONXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmRESTART}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmRESTART(JCLParser.JobParmRESTARTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmSECLABEL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmSECLABEL(JCLParser.JobParmSECLABELContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmSCHENV}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmSCHENV(JCLParser.JobParmSCHENVContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmSYSAFF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmSYSAFF(JCLParser.JobParmSYSAFFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmSYSTEM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmSYSTEM(JCLParser.JobParmSYSTEMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmTIME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmTIME(JCLParser.JobParmTIMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmTYPRUN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmTYPRUN(JCLParser.JobParmTYPRUNContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmUJOBCORR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmUJOBCORR(JCLParser.JobParmUJOBCORRContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobParmUSER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobParmUSER(JCLParser.JobParmUSERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#commandStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCommandStatement(JCLParser.CommandStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jclCommandStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJclCommandStatement(JCLParser.JclCommandStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#cntlStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCntlStatement(JCLParser.CntlStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#endcntlStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEndcntlStatement(JCLParser.EndcntlStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#cntlStatementAmalgamation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCntlStatementAmalgamation(JCLParser.CntlStatementAmalgamationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#exportStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExportStatement(JCLParser.ExportStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ifStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfStatement(JCLParser.IfStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ifRelOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfRelOp(JCLParser.IfRelOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ifKeyword}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfKeyword(JCLParser.IfKeywordContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#ifTest}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfTest(JCLParser.IfTestContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#elseStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElseStatement(JCLParser.ElseStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#endifStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEndifStatement(JCLParser.EndifStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#includeStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncludeStatement(JCLParser.IncludeStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jcllibStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJcllibStatement(JCLParser.JcllibStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyStatement(JCLParser.NotifyStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyParms}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyParms(JCLParser.NotifyParmsContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyEMAIL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyEMAIL(JCLParser.NotifyEMAILContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyUSER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyUSER(JCLParser.NotifyUSERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyTYPE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyTYPE(JCLParser.NotifyTYPEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#notifyWHEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotifyWHEN(JCLParser.NotifyWHENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatement(JCLParser.OutputStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementParameter(JCLParser.OutputStatementParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementADDRESS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementADDRESS(JCLParser.OutputStatementADDRESSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementAFPPARMS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementAFPPARMS(JCLParser.OutputStatementAFPPARMSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementAFPSTATS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementAFPSTATS(JCLParser.OutputStatementAFPSTATSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementBUILDING}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementBUILDING(JCLParser.OutputStatementBUILDINGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementBURST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementBURST(JCLParser.OutputStatementBURSTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCHARS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCHARS(JCLParser.OutputStatementCHARSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCKPTLINE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCKPTLINE(JCLParser.OutputStatementCKPTLINEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCKPTPAGE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCKPTPAGE(JCLParser.OutputStatementCKPTPAGEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCKPTSEC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCKPTSEC(JCLParser.OutputStatementCKPTSECContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCLASS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCLASS(JCLParser.OutputStatementCLASSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCOLORMAP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCOLORMAP(JCLParser.OutputStatementCOLORMAPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCOMPACT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCOMPACT(JCLParser.OutputStatementCOMPACTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCOMSETUP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCOMSETUP(JCLParser.OutputStatementCOMSETUPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCONTROL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCONTROL(JCLParser.OutputStatementCONTROLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCOPIES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCOPIES(JCLParser.OutputStatementCOPIESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementCOPYCNT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementCOPYCNT(JCLParser.OutputStatementCOPYCNTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDATACK}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDATACK(JCLParser.OutputStatementDATACKContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDDNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDDNAME(JCLParser.OutputStatementDDNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDEFAULT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDEFAULT(JCLParser.OutputStatementDEFAULTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDEPT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDEPT(JCLParser.OutputStatementDEPTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDEST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDEST(JCLParser.OutputStatementDESTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDPAGELBL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDPAGELBL(JCLParser.OutputStatementDPAGELBLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementDUPLEX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementDUPLEX(JCLParser.OutputStatementDUPLEXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFCB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFCB(JCLParser.OutputStatementFCBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFLASH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFLASH(JCLParser.OutputStatementFLASHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFORMDEF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFORMDEF(JCLParser.OutputStatementFORMDEFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFORMLEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFORMLEN(JCLParser.OutputStatementFORMLENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFORMS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFORMS(JCLParser.OutputStatementFORMSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementFSSDATA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementFSSDATA(JCLParser.OutputStatementFSSDATAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementGROUPID}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementGROUPID(JCLParser.OutputStatementGROUPIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementINDEX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementINDEX(JCLParser.OutputStatementINDEXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementINTRAY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementINTRAY(JCLParser.OutputStatementINTRAYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementJESDS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementJESDS(JCLParser.OutputStatementJESDSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementLINDEX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementLINDEX(JCLParser.OutputStatementLINDEXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementLINECT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementLINECT(JCLParser.OutputStatementLINECTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMAILBCC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMAILBCC(JCLParser.OutputStatementMAILBCCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMAILCC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMAILCC(JCLParser.OutputStatementMAILCCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMAILFILE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMAILFILE(JCLParser.OutputStatementMAILFILEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMAILFROM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMAILFROM(JCLParser.OutputStatementMAILFROMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMAILTO}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMAILTO(JCLParser.OutputStatementMAILTOContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMERGE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMERGE(JCLParser.OutputStatementMERGEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementMODIFY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementMODIFY(JCLParser.OutputStatementMODIFYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementNAME(JCLParser.OutputStatementNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementNOTIFY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementNOTIFY(JCLParser.OutputStatementNOTIFYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOFFSETXB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOFFSETXB(JCLParser.OutputStatementOFFSETXBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOFFSETXF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOFFSETXF(JCLParser.OutputStatementOFFSETXFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOFFSETYB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOFFSETYB(JCLParser.OutputStatementOFFSETYBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOFFSETYF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOFFSETYF(JCLParser.OutputStatementOFFSETYFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOUTBIN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOUTBIN(JCLParser.OutputStatementOUTBINContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOUTDISP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOUTDISP(JCLParser.OutputStatementOUTDISPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOVERLAYB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOVERLAYB(JCLParser.OutputStatementOVERLAYBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOVERLAYF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOVERLAYF(JCLParser.OutputStatementOVERLAYFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementOVFL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementOVFL(JCLParser.OutputStatementOVFLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPAGEDEF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPAGEDEF(JCLParser.OutputStatementPAGEDEFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPIMSG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPIMSG(JCLParser.OutputStatementPIMSGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPORTNO}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPORTNO(JCLParser.OutputStatementPORTNOContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRMODE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRMODE(JCLParser.OutputStatementPRMODEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRTATTRS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRTATTRS(JCLParser.OutputStatementPRTATTRSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRTERROR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRTERROR(JCLParser.OutputStatementPRTERRORContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRTOPTNS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRTOPTNS(JCLParser.OutputStatementPRTOPTNSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRTQUEUE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRTQUEUE(JCLParser.OutputStatementPRTQUEUEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementPRTY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementPRTY(JCLParser.OutputStatementPRTYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementREPLYTO}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementREPLYTO(JCLParser.OutputStatementREPLYTOContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementRESFMT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementRESFMT(JCLParser.OutputStatementRESFMTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementRETAINS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementRETAINS(JCLParser.OutputStatementRETAINSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementRETAINF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementRETAINF(JCLParser.OutputStatementRETAINFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementRETRYL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementRETRYL(JCLParser.OutputStatementRETRYLContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementRETRYT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementRETRYT(JCLParser.OutputStatementRETRYTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementROOM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementROOM(JCLParser.OutputStatementROOMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementSYSAREA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementSYSAREA(JCLParser.OutputStatementSYSAREAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementTHRESHLD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementTHRESHLD(JCLParser.OutputStatementTHRESHLDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementTITLE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementTITLE(JCLParser.OutputStatementTITLEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementTRC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementTRC(JCLParser.OutputStatementTRCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementUCS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementUCS(JCLParser.OutputStatementUCSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementUSERDATA}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementUSERDATA(JCLParser.OutputStatementUSERDATAContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementUSERLIB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementUSERLIB(JCLParser.OutputStatementUSERLIBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementUSERPATH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementUSERPATH(JCLParser.OutputStatementUSERPATHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#outputStatementWRITER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOutputStatementWRITER(JCLParser.OutputStatementWRITERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#pendStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPendStatement(JCLParser.PendStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleStatement(JCLParser.ScheduleStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParameters(JCLParser.ScheduleParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmAFTER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmAFTER(JCLParser.ScheduleParmAFTERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmBEFORE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmBEFORE(JCLParser.ScheduleParmBEFOREContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmDELAY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmDELAY(JCLParser.ScheduleParmDELAYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmHOLDUNTIL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmHOLDUNTIL(JCLParser.ScheduleParmHOLDUNTILContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmJOBGROUP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmJOBGROUP(JCLParser.ScheduleParmJOBGROUPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmSTARTBY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmSTARTBY(JCLParser.ScheduleParmSTARTBYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#scheduleParmWITH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitScheduleParmWITH(JCLParser.ScheduleParmWITHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#setStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetStatement(JCLParser.SetStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#setOperation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetOperation(JCLParser.SetOperationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#xmitStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitXmitStatement(JCLParser.XmitStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#xmitParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitXmitParameters(JCLParser.XmitParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#xmitParmDEST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitXmitParmDEST(JCLParser.XmitParmDESTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#xmitParmDLM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitXmitParmDLM(JCLParser.XmitParmDLMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#xmitParmSUBCHARS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitXmitParmSUBCHARS(JCLParser.XmitParmSUBCHARSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jesExecutionControlStatements}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJesExecutionControlStatements(JCLParser.JesExecutionControlStatementsContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupStatement(JCLParser.JobGroupStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupAccountingString}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupAccountingString(JCLParser.JobGroupAccountingStringContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupAccountingInformation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupAccountingInformation(JCLParser.JobGroupAccountingInformationContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupAccountingInformationSimple}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupAccountingInformationSimple(JCLParser.JobGroupAccountingInformationSimpleContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupAccountingInformationMultiLine}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupAccountingInformationMultiLine(JCLParser.JobGroupAccountingInformationMultiLineContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupProgrammerName}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupProgrammerName(JCLParser.JobGroupProgrammerNameContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupParameters(JCLParser.JobGroupParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupEMAIL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupEMAIL(JCLParser.JobGroupEMAILContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupOWNER}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupOWNER(JCLParser.JobGroupOWNERContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupGROUP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupGROUP(JCLParser.JobGroupGROUPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupPASSWORD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupPASSWORD(JCLParser.JobGroupPASSWORDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupSECLABEL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupSECLABEL(JCLParser.JobGroupSECLABELContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupTYPE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupTYPE(JCLParser.JobGroupTYPEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupHOLD}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupHOLD(JCLParser.JobGroupHOLDContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupERROR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupERROR(JCLParser.JobGroupERRORContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupCondition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupCondition(JCLParser.JobGroupConditionContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupERROR_RelOp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupERROR_RelOp(JCLParser.JobGroupERROR_RelOpContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupERROR_Keyword}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupERROR_Keyword(JCLParser.JobGroupERROR_KeywordContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupERROR_Test}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupERROR_Test(JCLParser.JobGroupERROR_TestContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupONERROR}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupONERROR(JCLParser.JobGroupONERRORContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupSYSAFF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupSYSAFF(JCLParser.JobGroupSYSAFFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupSYSTEM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupSYSTEM(JCLParser.JobGroupSYSTEMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobGroupSCHENV}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobGroupSCHENV(JCLParser.JobGroupSCHENVContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#gJobStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGJobStatement(JCLParser.GJobStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#gJobParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGJobParameters(JCLParser.GJobParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#gJobFLUSHTYP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGJobFLUSHTYP(JCLParser.GJobFLUSHTYPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobSetStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobSetStatement(JCLParser.JobSetStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobSetParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobSetParameters(JCLParser.JobSetParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jobSetFLUSHTYP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJobSetFLUSHTYP(JCLParser.JobSetFLUSHTYPContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#sJobStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSJobStatement(JCLParser.SJobStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#endSetStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEndSetStatement(JCLParser.EndSetStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#endGroupStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEndGroupStatement(JCLParser.EndGroupStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterStatement(JCLParser.AfterStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterParameters(JCLParser.AfterParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterNAME(JCLParser.AfterNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterACTION}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterACTION(JCLParser.AfterACTIONContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterOTHERWISE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterOTHERWISE(JCLParser.AfterOTHERWISEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#afterWHEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAfterWHEN(JCLParser.AfterWHENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeStatement(JCLParser.BeforeStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeParameters(JCLParser.BeforeParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeNAME(JCLParser.BeforeNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeACTION}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeACTION(JCLParser.BeforeACTIONContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeOTHERWISE}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeOTHERWISE(JCLParser.BeforeOTHERWISEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#beforeWHEN}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBeforeWHEN(JCLParser.BeforeWHENContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#concurrentStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConcurrentStatement(JCLParser.ConcurrentStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#concurrentParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConcurrentParameters(JCLParser.ConcurrentParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#concurrentNAME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConcurrentNAME(JCLParser.ConcurrentNAMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#singleOrMultipleValue}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSingleOrMultipleValue(JCLParser.SingleOrMultipleValueContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#parenList}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParenList(JCLParser.ParenListContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#embeddedEquality}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEmbeddedEquality(JCLParser.EmbeddedEqualityContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2CntlStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2CntlStatement(JCLParser.Jes2CntlStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmStatement(JCLParser.Jes2JobParmStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmParameters(JCLParser.Jes2JobParmParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmBURST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmBURST(JCLParser.Jes2JobParmBURSTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmBYTES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmBYTES(JCLParser.Jes2JobParmBYTESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmCARDS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmCARDS(JCLParser.Jes2JobParmCARDSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmCOPIES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmCOPIES(JCLParser.Jes2JobParmCOPIESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmFORMS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmFORMS(JCLParser.Jes2JobParmFORMSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmLINECT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmLINECT(JCLParser.Jes2JobParmLINECTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmLINES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmLINES(JCLParser.Jes2JobParmLINESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmNOLOG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmNOLOG(JCLParser.Jes2JobParmNOLOGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmPAGES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmPAGES(JCLParser.Jes2JobParmPAGESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmPROCLIB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmPROCLIB(JCLParser.Jes2JobParmPROCLIBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmRESTART}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmRESTART(JCLParser.Jes2JobParmRESTARTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmROOM}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmROOM(JCLParser.Jes2JobParmROOMContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmSYSAFF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmSYSAFF(JCLParser.Jes2JobParmSYSAFFContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2JobParmTIME}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2JobParmTIME(JCLParser.Jes2JobParmTIMEContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2MessageStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2MessageStatement(JCLParser.Jes2MessageStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2MessageParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2MessageParameter(JCLParser.Jes2MessageParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2NetAcctStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2NetAcctStatement(JCLParser.Jes2NetAcctStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2NetAcctParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2NetAcctParameter(JCLParser.Jes2NetAcctParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2NotifyStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2NotifyStatement(JCLParser.Jes2NotifyStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2NotifyParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2NotifyParameter(JCLParser.Jes2NotifyParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputStatement(JCLParser.Jes2OutputStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputParameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputParameters(JCLParser.Jes2OutputParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCONTINUATION}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCONTINUATION(JCLParser.Jes2OutputCONTINUATIONContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputBURST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputBURST(JCLParser.Jes2OutputBURSTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCHARS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCHARS(JCLParser.Jes2OutputCHARSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCKPTLNS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCKPTLNS(JCLParser.Jes2OutputCKPTLNSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCKPTPGS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCKPTPGS(JCLParser.Jes2OutputCKPTPGSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCOMPACT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCOMPACT(JCLParser.Jes2OutputCOMPACTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCOPIES}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCOPIES(JCLParser.Jes2OutputCOPIESContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputCOPYG}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputCOPYG(JCLParser.Jes2OutputCOPYGContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputDEST}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputDEST(JCLParser.Jes2OutputDESTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputFCB}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputFCB(JCLParser.Jes2OutputFCBContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputFLASH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputFLASH(JCLParser.Jes2OutputFLASHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputFLASHC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputFLASHC(JCLParser.Jes2OutputFLASHCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputFORMS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputFORMS(JCLParser.Jes2OutputFORMSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputINDEX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputINDEX(JCLParser.Jes2OutputINDEXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputLINDEX}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputLINDEX(JCLParser.Jes2OutputLINDEXContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputLINECT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputLINECT(JCLParser.Jes2OutputLINECTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputMODIFY}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputMODIFY(JCLParser.Jes2OutputMODIFYContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputMODTRC}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputMODTRC(JCLParser.Jes2OutputMODTRCContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2OutputUCS}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2OutputUCS(JCLParser.Jes2OutputUCSContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2PriorityStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2PriorityStatement(JCLParser.Jes2PriorityStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2PriorityParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2PriorityParameter(JCLParser.Jes2PriorityParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2RouteStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2RouteStatement(JCLParser.Jes2RouteStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2RouteParameter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2RouteParameter(JCLParser.Jes2RouteParameterContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2RoutePRINT}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2RoutePRINT(JCLParser.Jes2RoutePRINTContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2RoutePUNCH}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2RoutePUNCH(JCLParser.Jes2RoutePUNCHContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2RouteXEQ}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2RouteXEQ(JCLParser.Jes2RouteXEQContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2SetupStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2SetupStatement(JCLParser.Jes2SetupStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2SignoffStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2SignoffStatement(JCLParser.Jes2SignoffStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2SignonStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2SignonStatement(JCLParser.Jes2SignonStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2XEQStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2XEQStatement(JCLParser.Jes2XEQStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#jes2XMITStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJes2XMITStatement(JCLParser.Jes2XMITStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#nullStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNullStatement(JCLParser.NullStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link JCLParser#delimiterStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDelimiterStatement(JCLParser.DelimiterStatementContext ctx);
}