/*
Copyright (C) 2021 Craig Schneiderwent.  All rights reserved.  I accept
no liability for damages of any kind resulting from the use of this 
software.  Use at your own risk.

This software may be modified and distributed under the terms
of the MIT license. See the LICENSE file for details.

Rules for Db2 for z/OS SQL statements that can be embedded in an
application program are included here.  Version 12 documentation
served as source material.

The ALTER FUNCTION variations (external), (inlined SQL scalar), and
(SQL table) are all variations on each other and are contained in
the alterFunctionStatement rule.

The rule signalStatement is not a full implementation of the syntax
of the SIGNAL statement, but a subset that is possible to embed in
an application program.

The rule trustedContextOptionList does not strictly match its
syntax diagram, for reasons documented with the rule.

The rule executeImmediateStatement only partially implements the
syntax of the EXECUTE IMMEDIATE	statement in order to avoid
implementing a grammar for the entire PL/I language here.  The same
is true of the prepareStatement rule.

This grammar does not include SQL/PL or the following SQL statements.

ALTER FUNCTION (compiled SQL scalar)
ALTER PROCEDURE (SQL - external)
ALTER PROCEDURE (SQL - native)
ALTER TRIGGER (advanced)
CREATE FUNCTION (compiled SQL scalar)
CREATE PROCEDURE (SQL - native)
CREATE TRIGGER (advanced)

*/


parser grammar DB2zSQLParser;

options {tokenVocab=DB2zSQLLexer;}

startRule : sqlStatement* | EOF ;

/*
The order of the releaseSavepointStatement and
releaseConnectionStatement rules is significant. In order
for savepoints to be recognized correctly the former
must come before the latter.
*/
sqlStatement
	: EXEC_SQL?
	(
	query
	| allocateCursorStatement
	| alterDatabaseStatement
	| alterFunctionStatement
	| alterIndexStatement
	| alterMaskStatement
	| alterPermissionStatement
	| alterProcedureStatement
	| alterSequenceStatement
	| alterStogroupStatement
	| alterTableStatement
	| alterTablespaceStatement
	| alterTriggerStatement
	| alterTrustedContextStatement
	| alterViewStatement
	| associateLocatorsStatement
	| beginDeclareSectionStatement
	| callStatement
	| closeStatement
	| commitStatement
	| commentStatement
	| connectStatement
	| createAliasStatement
	| createAuxiliaryTableStatement
	| createDatabaseStatement
	| createFunctionStatement
	| createGlobalTemporaryTableStatement
	| createIndexStatement
	| createLobTablespaceStatement
	| createMaskStatement
	| createPermissionStatement
	| createProcedureStatement
	| createRoleStatement
	| createSequenceStatement
	| createStogroupStatement
	| createTableStatement
	| createTablespaceStatement
	| createTriggerStatement
	| createTrustedContextStatement
	| createTypeArrayStatement
	| createTypeDistinctStatement
	| createVariableStatement
	| createViewStatement
	| declareCursorStatement
	| declareGlobalTemporaryTableStatement
	| declareTableStatement
	| declareVariableStatement
	| declareStatementStatement
	| deleteStatement
	| describeStatement
	| dropStatement
	| endDeclareSectionStatement
	| exchangeStatement
	| executeStatement
	| executeImmediateStatement
	| explainStatement
	| fetchStatement
	| freeLocatorStatement
	| getDiagnosticsStatement
	| grantStatement
	| holdLocatorStatement
	| includeStatement
	| insertStatement
	| labelStatement
	| lockTableStatement
	| mergeStatement
	| openStatement
	| prepareStatement
	| refreshTableStatement
	| releaseSavepointStatement
	| releaseConnectionStatement
	| renameStatement
	| revokeStatement
	| rollbackStatement
	| savepointStatement
	| setConnectionStatement
	| setEncryptionPasswordStatement
	| setPathStatement
	| setSchemaStatement
	| setSessionTimezoneStatement
	| setSpecialRegisterStatement
	| setAssignmentStatement
	| signalStatement
	| transferOwnershipStatement
	| truncateStatement
	| updateStatement
	| valuesIntoStatement
	| wheneverStatement
	)
	(SEMICOLON | (END_EXEC DOT?) | EOF)
	;

query
	: (
	subSelect
	| fullSelect
	| selectStatement
	| selectIntoStatement
	)
	;

cursorName
	: identifier
	;

statementName
	: identifier
	;

descriptorName
	: hostVariable
	;

holdability
	: ((WITHOUT HOLD) | (WITH HOLD))
	;

returnability
	: ((WITHOUT RETURN) | (WITH RETURN ((TO CALLER) | (TO CLIENT))?))
	;

rowsetPositioning
	: ((WITHOUT ROWSET POSITIONING) | (WITH ROWSET POSITIONING))
	;

notNullPhrase
	: ((NOT NULL) | (NOT NULL WITH DEFAULT))
	;

allocateCursorStatement
	: (ALLOCATE cursorName CURSOR FOR RESULT SET rsLocatorVariable)
	;

rsLocatorVariable
	: hostVariable
	;

alterDatabaseStatement
	: (
	ALTER DATABASE databaseName
	(bufferpoolOption
	| (INDEXBP bpName)
	| (STOGROUP stogroupName)
	| (CCSID ccsidValue))+
	)
	;

alterFunctionStatement
	: (
	ALTER 
		((FUNCTION functionName (LPAREN functionParameterType (COMMA functionParameterType)* RPAREN)?) 
		| (SPECIFIC FUNCTION specificName))
	RESTRICT?
	functionOptionList+
	)
	;

alterIndexStatement
	: (
	ALTER INDEX indexName regenerateClause?
	alterIndexOptions*
	(alterIndexPartitionOptions (COMMA alterIndexPartitionOptions)*)?
	)
	;

alterMaskStatement
	: (
	ALTER MASK maskName (ENABLE | DISABLE | regenerateClause)
	)
	;

alterPermissionStatement
	: (
	ALTER PERMISSION permissionName (ENABLE | DISABLE | regenerateClause)
	)
	;

alterProcedureStatement
	: (
	ALTER PROCEDURE procedureName procedureOptionList+
	)
	;

alterSequenceStatement
	: (
	ALTER SEQUENCE sequenceName alterSequenceOptionList+
	)
	;

alterStogroupStatement
	: (
	ALTER STOGROUP stogroupName alterStogroupOptionList+
	)
	;

alterTableStatement
	: (
	ALTER TABLE alterTableName alterTableOptionList+
	)
	;

alterTablespaceStatement
	: (
	ALTER TABLESPACE (databaseName DOT)? tablespaceName 
	alterTablespaceOptionList* 
	alterPartitionClause?
	moveTableClause?
	)
	;

alterTriggerStatement
	: (
	ALTER TRIGGER (schemaName DOT) triggerName NOT? SECURED
	)
	;

alterTrustedContextStatement
	: (
	ALTER TRUSTED CONTEXT contextName trustedContextOptionList+
	)
	;

alterViewStatement
	: (
	ALTER VIEW viewName REGENERATE
	(USING APPLICATION COMPATIBILITY applCompatValue)?
	)
	;

associateLocatorsStatement
	: (
	ASSOCIATE (RESULT SET)? (LOCATOR | LOCATORS) 
	LPAREN rsLocatorVariable (COMMA rsLocatorVariable)* RPAREN
	WITH PROCEDURE (procedureName | hostVariable)
	)
	;

beginDeclareSectionStatement
	: (BEGIN DECLARE SECTION)
	;

callStatement
	: (
	CALL (procedureName | hostVariable)
	(LPAREN (
		((expression | NULL | (TABLE tableName)) (COMMA (expression | NULL | (TABLE tableName)))*)
		| (USING DESCRIPTOR hostVariable)
	) RPAREN)?
	)
	;

closeStatement
	: (CLOSE cursorName)
	;

commentStatement
	: (
	COMMENT ON ((
	(aliasDesignator
	| (COLUMN tableName DOT columnName)
	| (functionDesignator ((ACTIVE VERSION) | (VERSION routineVersionID))?)
	| (INDEX indexName)
	| (PACKAGE packageDesignator)
	| (PLAN planName)
	| (PROCEDURE procedureName ((ACTIVE VERSION) | (VERSION routineVersionID))?)
	| (ROLE roleName)
	| (SEQUENCE sequenceName)
	| (TABLE tableName)
	| (TRIGGER triggerName ((ACTIVE VERSION) | (VERSION routineVersionID))?)
	| (TRUSTED CONTEXT contextName)
	| (TYPE typeName)
	| (MASK maskName)
	| (PERMISSION permissionName)
	| (VARIABLE variableName))
	IS NONNUMERICLITERAL)
	| multipleColumnList)
	)
	;

commitStatement
	: (COMMIT WORK?)
	;

connectStatement
	: (
	CONNECT (
	(TO (locationName | hostVariable) authorization?)
	| RESET
	| authorization)?
	)
	;

createAliasStatement
	: (
	CREATE PUBLIC? ALIAS (sequenceAlias | tableAlias)
	)
	;

createAuxiliaryTableStatement
	: (
	CREATE (AUX | AUXILIARY) TABLE auxTableName IN databaseName? tablespaceName
	STORES tableName appendClause? COLUMN columnName PART INTEGERLITERAL
	)
	;

createDatabaseStatement
	: (
	CREATE DATABASE databaseName databaseOptionList*
	)
	;

createFunctionStatement
	: (
	createFunctionStatementExternalScalar
	| createFunctionStatementExternalTable
	| createFunctionStatementSourced
	| createFunctionStatementInlineSqlScalar
	)
	;

createFunctionStatementExternalScalar
	: (
	CREATE FUNCTION functionName
	LPAREN (parameterDeclaration1 (COMMA parameterDeclaration1)*)? RPAREN
	createFunctionStatementExternalScalarOptions+
	)
	;

createFunctionStatementExternalTable
	: (
	CREATE FUNCTION functionName
	LPAREN (parameterDeclaration1 (COMMA parameterDeclaration1)*)? RPAREN
	createFunctionStatementExternalTableOptions+
	)
	;

createFunctionStatementSourced
	: (
	CREATE FUNCTION functionName
	LPAREN (parameterDeclaration1 (COMMA parameterDeclaration1)*)? RPAREN
	createFunctionStatementSourcedOptions+
	)
	;

createFunctionStatementInlineSqlScalar
	: (
	CREATE FUNCTION functionName
	LPAREN ((parameterDeclaration2 (COMMA parameterDeclaration2)*)?) RPAREN
	createFunctionStatementInlineSqlScalarOptions+
	)
	;

createGlobalTemporaryTableStatement
	: (
	CREATE GLOBAL TEMPORARY TABLE tableName
	((LPAREN createGlobalTemporaryTableColumnDefinition (COMMA createGlobalTemporaryTableColumnDefinition)* RPAREN)
	| (LIKE tableName))
	ccsidClause1?
	)
	;

createIndexStatement
	: (
	CREATE (UNIQUE (WHERE NOT NULL)?)? INDEX indexName ON
		((tableName LPAREN 
		(columnName | keyExpression) (ASC | DESC | RANDOM)?
		(COMMA (columnName | keyExpression) (ASC | DESC | RANDOM)?)*
		(COMMA BUSINESS_TIME (WITH | WITHOUT) OVERLAPS)?
		RPAREN)
		| (auxTableName))
	createIndexOptionList*
	)
	;

createLobTablespaceStatement
	: (
	CREATE LOB TABLESPACE tablespaceName createLobTablespaceOptionList*
	)
	;

createMaskStatement
	: (
	CREATE MASK maskName ON tableName (AS? correlationName)?
	FOR COLUMN columnName RETURN caseExpression enableDisableOption?
	)
	;

createPermissionStatement
	: (
	CREATE PERMISSION permissionName ON tableName (AS? correlationName)?
	FOR ROWS WHERE searchCondition ENFORCED FOR ALL ACCESS enableDisableOption?
	)
	;

createProcedureStatement
	: (
	CREATE (OR REPLACE)? PROCEDURE procedureName
	(LPAREN parameterDeclaration3 (COMMA parameterDeclaration3)* RPAREN)?
	createProcedureOptionList+
	)
	;

createRoleStatement
	: (
	CREATE ROLE roleName
	)
	;

createSequenceStatement
	: (
	CREATE SEQUENCE sequenceName createSequenceOptionList+
	)
	;

createStogroupStatement
	: (
	CREATE STOGROUP stogroupName
	(VOLUMES 
		(LPAREN (volumeID | NONNUMERICLITERAL | SPLAT) 
		(COMMA (volumeID | NONNUMERICLITERAL | SPLAT))* 
		RPAREN))?
	VCAT catalogName
	dataclasOption?
	mgmtclasOption?
	storclasOption?
	keyLabelOption?
	)
	;

createTableStatement
	: (
	CREATE TABLE tableName
		(
			(LPAREN
				(createTableColumnDefinition
				| periodDefinition
				| uniqueConstraint
				| referentialConstraint
				| checkConstraint)
				(COMMA
				(createTableColumnDefinition
				| periodDefinition
				| uniqueConstraint
				| referentialConstraint
				| checkConstraint))*
			RPAREN)
			| (LIKE tableName copyOptions?)
			| (asResultTable copyOptions?)
			| createTableMaterializedQueryDefinition
		)
	createTableInClause?
	partitioningClause?
	organizationClause?
	editprocClause?
	validprocClause?
	auditClause?
	obidClause?
	dataCaptureClause?
	restrictOnDropClause?
	ccsidClause1?
	cardinalityClause?
	loggedOption?
	compressOption?
	appendClause?
	dssizeOption?
	bufferpoolOption?
	memberClause?
	trackmodClause?
	pagenumClause?
	keyLabelOption?
	)
	;

createTablespaceStatement
	: (
	CREATE TABLESPACE tablespaceName 
	createTablespaceOptionList* 
	)
	;

/*
The syntax accepts WRAPPED obfuscatedStatementText, but not
in a static SQL context so it is not supported here.
*/
createTriggerStatement
	: (
	CREATE TRIGGER triggerName triggerDefinition
	)
	;

createTrustedContextStatement
	: (
	CREATE TRUSTED CONTEXT contextName
	BASED UPON CONNECTION USING SYSTEM AUTHID authorizationName
	(trustedContextDefaultRoleClause
	| trustedContextEnableDisableClause
	| trustedContextDefaultSecurityLabelClause
	| trustedContextAttributesClause
	| trustedContextWithUseForClause)+
	)
	;

createTypeArrayStatement
	: (
	CREATE TYPE arrayTypeName AS createTypeArrayBuiltinType 
	ARRAY OPENSQBRACKET (INTEGERLITERAL | createTypeArrayBuiltinType2) CLOSESQBRACKET
	)
	;

createTypeDistinctStatement
	: (
	CREATE TYPE distinctTypeName AS sourceDataType (INLINE LENGTH INTEGERLITERAL)?
	)
	;

createVariableStatement
	: (
	CREATE VARIABLE variableName 
	(createVariableBuiltInType | arrayTypeName) 
	(DEFAULT (NULL | INTEGERLITERAL | NONNUMERICLITERAL | specialRegister))?
	)
	;

createViewStatement
	: (
	CREATE VIEW viewName 
	LPAREN columnName (COMMA columnName)* RPAREN AS
	(WITH commonTableExpression (COMMA commonTableExpression)*)?
	fullSelect
	createViewCheckOptionClause?
	)
	;

declareCursorStatement
	: (
	DECLARE cursorName
	((NO SCROLL) | ((ASENSITIVE | INSENSITIVE | (SENSITIVE (DYNAMIC | STATIC))) SCROLL))?
	CURSOR (holdability | returnability | rowsetPositioning)* FOR (selectStatement | statementName)
	)
	;

declareGlobalTemporaryTableStatement
	: (
	DECLARE GLOBAL TEMPORARY TABLE tableName
		((LPAREN declareGlobalTemporaryTableColumnDefinition 
			(COMMA declareGlobalTemporaryTableColumnDefinition)* RPAREN)
		| declareGlobalTemporaryTableLikeClause
		| declareGlobalTemporaryTableAsResultTable)
		(ccsidClause1
		| onCommitClause
		| loggedWithRollbackClause)*
	)
	;

declareTableStatement
	: (
	DECLARE tableName TABLE LPAREN
	(columnName dataType notNullPhrase?)
	(COMMA columnName dataType notNullPhrase?)*
	RPAREN
	)
	;

declareStatementStatement
	: (DECLARE statementName (COMMA statementName)* STATEMENT)
	;

declareVariableStatement
	: (
	DECLARE hostVariable (COMMA hostVariable)* VARIABLE
	((ccsidClause1 forDataQualifier) | ccsidClause1 | forDataQualifier | ccsidClause2)?
	)
	;

deleteStatement
	: (searchedDelete | positionedDelete)
	;

describeStatement
	: (
	describeCursorStatement
	| describeInputStatement
	| describeOutputStatement
	| describeProcedureStatement
	| describeTableStatement
	)
	;

describeCursorStatement
	: (
	DESCRIBE CURSOR (cursorName | hostVariable) INTO descriptorName
	)
	;

describeInputStatement
	: (
	DESCRIBE INPUT statementName INTO descriptorName
	)
	;

describeOutputStatement
	: (
	DESCRIBE OUTPUT? statementName INTO descriptorName describeUsingOption?
	)
	;

describeProcedureStatement
	: (
	DESCRIBE PROCEDURE (procedureName | hostVariable) INTO descriptorName
	)
	;

describeTableStatement
	: (
	DESCRIBE TABLE hostVariable INTO descriptorName describeUsingOption?
	)
	;

dropStatement
	: (
	DROP
		(aliasDesignation
		| dropDatabaseClause
		| dropFunctionClause
		| dropIndexClause
		| dropMaskClause
		| dropPackageClause
		| dropPermissionClause
		| dropProcedureClause
		| dropRoleClause
		| dropSequenceClause
		| dropStogroupClause
		| dropSynonymClause
		| dropTableClause
		| dropTablespaceClause
		| dropTriggerClause
		| dropTrustedContextClause
		| dropTypeClause
		| dropVariableClause
		| dropViewClause)
	)
	;

endDeclareSectionStatement
	: (END DECLARE SECTION)
	;

exchangeStatement
	: (EXCHANGE DATA BETWEEN TABLE tableName AND tableName)
	;

executeStatement
	: (
	EXECUTE statementName 
		((USING (variable | arrayElementSpecification) (COMMA (variable | arrayElementSpecification))*)
		| (USING DESCRIPTOR descriptorName)
		| sourceRowData)
	)
	;

/*
This rule _almost_ covers the syntax.  The NONNUMERICLITERAL 
token corresponds to what the documentation refers to as 
string-expression, which "is any PL/I expression that yields 
a string."  I'm not going to implement a grammar for the 
entire PL/I language here.

*/
executeImmediateStatement
	: (EXECUTE IMMEDIATE (variable | NONNUMERICLITERAL))
	;

explainStatement
	: (
	EXPLAIN
		(explainPlanClause
		| explainStmtcacheClause
		| explainPackageClause
		| explainStabilizedDynamicQueryClause)
	)
	;

/*
The syntax diagram in the documentation lists fetchOrientation
as required.  It is optional here because one of its variants is 
optional.
*/
fetchStatement
	: (
	FETCH (INSENSITIVE | SENSITIVE)? (WITH CONTINUE)? 
	fetchOrientation? FROM? cursorName
	(singleRowFetch | multipleRowFetch)?
	)
	;

freeLocatorStatement
	: (FREE LOCATOR hostVariable (COMMA hostVariable)*)
	;

getDiagnosticsStatement
	: (
	GET (CURRENT | STACKED)? DIAGNOSTICS
	(statementInformation | conditionInformation | combinedInformation)
	)
	;

grantStatement
	: (
	grantCollectionStatement
	| grantDatabaseStatement
	| grantFunctionOrProcedureStatement	
	| grantPackageStatement
	| grantPlanStatement
	| grantSchemaStatement
	| grantSequenceStatement
	| grantSystemStatement
	| grantTableStatement
	| grantTypeOrJarStatement
	| grantVariableStatement
	| grantUseOfStatement
	)
	;

holdLocatorStatement
	: (HOLD LOCATOR hostVariable (COMMA hostVariable)*)
	;

includeStatement
	: (INCLUDE memberName)
	;

insertStatement
	: (
	INSERT INTO tableName (LPAREN columnName (COMMA columnName)* RPAREN)?
	includeColumns?
	(OVERRIDING USER VALUE)?
	((VALUES (valuesList1 |
		(LPAREN valuesList1 (COMMA valuesList1)* RPAREN)))
	| ((WITH commonTableExpression (COMMA commonTableExpression)*)?
		fullSelect isolationClause? querynoClause?)
	| multipleRowInsert)
	)
	;

labelStatement
	: (
	LABEL ON
	((((TABLE tableName)
	| (ALIAS aliasName)
	| (COLUMN tableName DOT columnName))
	IS NONNUMERICLITERAL)
	| (tableName LPAREN 
		columnName IS NONNUMERICLITERAL 
		(COMMA columnName IS NONNUMERICLITERAL)* 
		RPAREN))
	)
	;

lockTableStatement
	: (
	LOCK TABLE tableName ((PARTITION | PART) INTEGERLITERAL)? IN (SHARE | EXCLUSIVE) MODE_
	)
	;

mergeStatement
	: (
	MERGE INTO tableName correlationClause? includeColumns?
	USING ((LPAREN* tableReference RPAREN*) | sourceValues) ON searchCondition
	(WHEN matchingCondition THEN (modificationOperation | signalStatement))+ (ELSE IGNORE)?
	notAtomicPhrase?
	querynoClause?
	)
	;

openStatement
	: (
	OPEN cursorName 
	((USING variable (COMMA variable)*)
	| (USING DESCRIPTOR descriptorName))?
	)
	;

/*
This is incomplete, as the FROM string-expression phrase is
not implemented because it is specific to PL/I, string-expression
can be any valid PL/I string expression, and I'm not going to 
implement the entirety of the PL/I language here.
*/
prepareStatement
	: (
	PREPARE statementName 
	(INTO descriptorName (USING (NAMES | LABELS | ANY | BOTH))?)?
	(ATTRIBUTES hostVariable)? FROM variable
	)
	;

refreshTableStatement
	: (
	REFRESH TABLE tableName (QUERYNO INTEGERLITERAL)?
	)
	;

releaseConnectionStatement
	: (
	RELEASE (CURRENT | (ALL SQL?) | locationName | hostVariable)
	)
	;

releaseSavepointStatement
	: (RELEASE TO? SAVEPOINT savepointName)
	;

renameStatement
	: (
	RENAME ((TABLE? tableName TO tableName) | (INDEX indexName TO indexName))
	)
	;

revokeStatement
	: (
	revokeCollectionStatement
	| revokeDatabaseStatement
	| revokeFunctionOrProcedureStatement	
	| revokePackageStatement
	| revokePlanStatement
	| revokeSchemaStatement
	| revokeSequenceStatement
	| revokeSystemStatement
	| revokeTableStatement
	| revokeTypeOrJarStatement
	| revokeVariableStatement
	| revokeUseOfStatement
	)
	;

rollbackStatement
	: (ROLLBACK WORK? (TO SAVEPOINT savepointName?)?)
	;

savepointStatement
	: (
	SAVEPOINT savepointName UNIQUE?
	((ON ROLLBACK RETAIN CURSORS) | (ON ROLLBACK RETAIN LOCKS))+
	)
	;

setAssignmentStatement
	: (
	SET setAssignmentClause
	)
	;

setConnectionStatement
	: (SET CONNECTION (locationName | hostVariable))
	;

/*
The SET statement for this particular special register does not
conform to the pattern set by all the others.  There's always one.
*/
setEncryptionPasswordStatement
	: (
	SET ENCRYPTION_PASSWORD EQ? (NONNUMERICLITERAL | variable)
	(WITH HINT EQ? (NONNUMERICLITERAL | variable))?
	)
	;

/*
PATH is a token.  CURRENT PATH is a token.  Sometimes the former
is a synonym for the latter.  And sometimes not.
*/
setPathStatement
	: (SET (PATH | CURRENT_PATH) EQ? expression (COMMA? expression)*)
	;

/*
SCHEMA is a token.  CURRENT SCHEMA is a token, as is CURRENT_SCHEMA which
is considered equivalent.  Sometimes the former is a synonym for either of
the latter.  And sometimes not.
*/
setSchemaStatement
	: (SET (SCHEMA | CURRENT_SCHEMA) EQ? expression)
	;

/*
SESSIONTIMEZONE, SESSION TIME ZONE, SESSION TIMEZONE, TIME ZONE,
and TIMEZONE are all synonyms for each other in this context.
Changing the lexer rule for SESSION_TIME_ZONE to match all of
the above broke other things that expect TIME and ZONE to be
separate tokens.  So here we are.
*/
setSessionTimezoneStatement
	: (SET (SESSION_TIME_ZONE | (TIME ZONE) | TIMEZONE) EQ? (variable | NONNUMERICLITERAL))
	;

setSpecialRegisterStatement
	: (SET specialRegister EQ? (expression | NULL) (COMMA? expression)*)
	;

signalStatement
	: (
	SIGNAL SQLSTATE VALUE? NONNUMERICLITERAL signalInformation?
	)
	;

transferOwnershipStatement
	: (
	TRANSFER OWNERSHIP OF ownedObject TO newOwner REVOKE PRIVILEGES
	)
	;

truncateStatement
	: (
	TRUNCATE TABLE? tableName ((DROP | REUSE) STORAGE)?
	((IGNORE | (RESTRICT WHEN)) DELETE TRIGGERS)?
	IMMEDIATE?
	)
	;

updateStatement
	: (searchedUpdate | positionedUpdate)
	;

valuesStatement
	: (
	VALUES (expression | (LPAREN expression (COMMA expression)* RPAREN))
	)
	;

valuesIntoStatement
	: (
	VALUES 
	(expression | NULL | (LPAREN (expression | NULL) (COMMA (expression | NULL))* RPAREN))
	INTO ((valuesIntoTargetVariable (COMMA valuesIntoTargetVariable)*) | arrayElementSpecification)
	)
	;

wheneverStatement
	: (
	WHENEVER ((NOT FOUND) | SQLERROR | SQLWARNING)
	(CONTINUE | ((GOTO | (GO TO)) COLON? hostLabel))
	)
	;

/*
These happen to be the same right now.  Taking advantage of that,
but insulating myself against future changes too.
*/
valuesIntoTargetVariable
	: (setAssignmentTargetVariable)
	;

ownedObject
	: (
	(DATABASE databaseName)
	| (INDEX indexName)
	| (STOGROUP stogroupName)
	| (TABLE tableName)
	| (TABLESPACE (databaseName DOT)? tablespaceName)
	| (VIEW viewName)
	)
	;

newOwner
	: (
	(ROLE roleName)
	| (USER authorizationName)
	| (SESSION_USER)
	)
	;

grantCollectionStatement
	: (
	GRANT (CREATE | PACKADM) (ON | IN) COLLECTION
	((collectionID (COMMA collectionID)*) | SPLAT) TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantDatabaseStatement
	: (
	GRANT grantDatabaseAuthority (COMMA grantDatabaseAuthority)*
	ON DATABASE databaseName (COMMA databaseName)* TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantFunctionOrProcedureStatement
	: (
	GRANT EXECUTE ON
		((FUNCTION functionSpecification (COMMA functionSpecification)*)
		| (FUNCTION SPLAT)
		| (SPECIFIC FUNCTION specificName (COMMA specificName)*)
		| (PROCEDURE ((procedureName (COMMA procedureName)*) | SPLAT)))
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantPackageStatement
	: (
	GRANT (ALL | (grantPackageAuthority (COMMA grantPackageAuthority)*))
	ON PACKAGE packageSpecification (COMMA packageSpecification)*
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantPlanStatement
	: (
	GRANT grantPlanAuthority (COMMA grantPlanAuthority)*
	ON PLAN planName (COMMA planName)*
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantSchemaStatement
	: (
	GRANT grantSchemaAuthority (COMMA grantSchemaAuthority)*
	ON SCHEMA (SPLAT | (schemaName (COMMA schemaName)*))
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantSequenceStatement
	: (
	GRANT grantSequenceAuthority (COMMA grantSequenceAuthority)*
	ON SEQUENCE sequenceName (COMMA sequenceName)*
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantSystemStatement
	: (
	GRANT grantSystemAuthority (COMMA grantSystemAuthority)*
	(ON SYSTEM)?
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantTableStatement
	: (
	GRANT grantTableAuthority (COMMA grantTableAuthority)*
	ON TABLE? tableName
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantTypeOrJarStatement
	: (
	GRANT USAGE ON
	(((DATA | DISTINCT)? TYPE typeName (COMMA typeName)*)
	| (JAR jarName (COMMA jarName)*))
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantVariableStatement
	: (
	GRANT grantVariableAuthority (COMMA grantVariableAuthority)*
	ON VARIABLE variableName (COMMA variableName)*
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

grantUseOfStatement
	: (
	GRANT USE OF grantUseOfTarget
	TO
	grantee (COMMA grantee)*
	withGrantOption?
	)
	;

revokeCollectionStatement
	: (
	REVOKE (CREATE | PACKADM) (ON | IN) COLLECTION
	((collectionID (COMMA collectionID)*) | SPLAT) FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeDatabaseStatement
	: (
	REVOKE grantDatabaseAuthority (COMMA grantDatabaseAuthority)*
	ON DATABASE databaseName (COMMA databaseName)* FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeFunctionOrProcedureStatement
	: (
	REVOKE EXECUTE ON
		((FUNCTION functionSpecification (COMMA functionSpecification)*)
		| (FUNCTION SPLAT)
		| (SPECIFIC FUNCTION specificName (COMMA specificName)*)
		| (PROCEDURE ((procedureName (COMMA procedureName)*) | SPLAT)))
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	RESTRICT?
	)
	;

revokePackageStatement
	: (
	REVOKE (ALL | (grantPackageAuthority (COMMA grantPackageAuthority)*))
	ON PACKAGE packageSpecification (COMMA packageSpecification)*
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokePlanStatement
	: (
	REVOKE grantPlanAuthority (COMMA grantPlanAuthority)*
	ON PLAN planName (COMMA planName)*
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeSchemaStatement
	: (
	REVOKE grantSchemaAuthority (COMMA grantSchemaAuthority)*
	ON SCHEMA (SPLAT | (schemaName (COMMA schemaName)*))
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeSequenceStatement
	: (
	REVOKE grantSequenceAuthority (COMMA grantSequenceAuthority)*
	ON SEQUENCE sequenceName (COMMA sequenceName)*
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	RESTRICT?
	)
	;

revokeSystemStatement
	: (
	REVOKE grantSystemAuthority (COMMA grantSystemAuthority)*
	(ON SYSTEM)?
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeTableStatement
	: (
	REVOKE grantTableAuthority (COMMA grantTableAuthority)*
	ON TABLE? tableName
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

revokeTypeOrJarStatement
	: (
	REVOKE USAGE ON
	(((DATA | DISTINCT)? TYPE typeName (COMMA typeName)*)
	| (JAR jarName (COMMA jarName)*))
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	RESTRICT?
	)
	;

/*
The syntax diagram in the documentation says the RESTRICT option 
comes before the revokeDependentPrivilegesOption in this
particular case.
*/
revokeVariableStatement
	: (
	REVOKE grantVariableAuthority (COMMA grantVariableAuthority)*
	ON VARIABLE variableName (COMMA variableName)*
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	RESTRICT?
	revokeDependentPrivilegesOption?
	)
	;

revokeUseOfStatement
	: (
	REVOKE USE OF grantUseOfTarget
	FROM
	grantee (COMMA grantee)*
	revokeByOption?
	revokeDependentPrivilegesOption?
	)
	;

grantUseOfTarget
	: (
	(BUFFERPOOL bpName (COMMA bpName)*)
	| (ALL BUFFERPOOLS)
	| (STOGROUP stogroupName (COMMA stogroupName)*)
	| (TABLESPACE (databaseName DOT)? tablespaceName (COMMA (databaseName DOT)? tablespaceName)*)
	)
	;

grantVariableAuthority
	: (
	(ALL PRIVILEGES?)
	| READ
	| WRITE
	)
	;

grantTableAuthority
	: (
	(ALL PRIVILEGES?)
	| ALTER
	| DELETE
	| INDEX
	| INSERT
	| (REFERENCES (LPAREN columnName (COMMA columnName)* RPAREN)?)
	| SELECT
	| TRIGGER
	| UNLOAD
	| (UPDATE (LPAREN columnName (COMMA columnName)* RPAREN)?)
	)
	;

grantSystemAuthority
	: (
	ACCESSCTRL
	| ARCHIVE
	| BINDADD
	| BINDAGENT
	| BSDS
	| CREATEALIAS
	| CREATEDBA
	| CREATEDBC
	| CREATESG
	| CREATETMTAB
	| CREATE_SECURE_OBJECT
	| DATAACCESS
	| (DBADM ((WITH | WITHOUT) ACCESSCTRL)? ((WITH | WITHOUT) DATAACCESS)?)
	| DEBUGSESSION
	| DISPLAY
	| EXPLAIN
	| MONITOR1
	| MONITOR2
	| RECOVER
	| SQLADM
	| STOPALL
	| STOSPACE
	| SYSADM
	| SYSCTRL
	| SYSOPR
	| TRACE
	)
	;

grantSequenceAuthority
	: (
	ALTER
	| USAGE
	)
	;

grantSchemaAuthority
	: (
	ALTERIN
	| CREATEIN
	| DROPIN
	)
	;

grantPlanAuthority
	: (
	BIND
	| EXECUTE
	)
	;

grantPackageAuthority
	: (
	BIND
	| COPY
	| EXECUTE
	| RUN
	)
	;

packageSpecification
	: (collectionID DOT (packageName | SPLAT))
	;

functionSpecification
	: (
	functionName (LPAREN functionParameterType (COMMA functionParameterType)* RPAREN)?
	)
	;

grantee
	: (authorizationName | (ROLE roleName) | PUBLIC)
	;

withGrantOption
	: (WITH GRANT OPTION)
	;

revokeByOption
	: (
	BY 
		(ALL 
		| ((authorizationName | (ROLE roleName)) 
			(COMMA (authorizationName | (ROLE roleName)))*))
	)
	;

revokeDependentPrivilegesOption
	: (NOT? INCLUDING DEPENDENT PRIVILEGES)
	;

grantDatabaseAuthority
	: (
	DBADM
	| DBCTRL
	| DBMAINT
	| CREATETAB
	| CREATETS
	| DISPLAYDB
	| DROP
	| IMAGCOPY
	| LOAD
	| RECOVERDB
	| REORG
	| REPAIR
	| STARTDB
	| STATS
	| STOPDB
	)
	;

statementInformation
	: (
	(statementInformationVariableEquate (COMMA statementInformationVariableEquate)*)
	| (variable EQ DB2_GET_DIAGNOSTICS_DIAGNOSTICS)
	| (variable EQ DB2_SQL_NESTING_LEVEL)
	)
	;

statementInformationVariableEquate
	: (variable EQ statementInformationItemName)
	;

statementInformationItemName
	: (
	DB2_LAST_ROW
	| DB2_NUMBER_PARAMETER_MARKERS
	| DB2_NUMBER_RESULT_SETS
	| DB2_NUMBER_ROWS
	| DB2_RETURN_STATUS
	| DB2_SQL_ATTR_CURSOR_HOLD
	| DB2_SQL_ATTR_CURSOR_ROWSET
	| DB2_SQL_ATTR_CURSOR_SCROLLABLE
	| DB2_SQL_ATTR_CURSOR_SENSITIVITY
	| DB2_SQL_ATTR_CURSOR_TYPE
	| MORE_
	| NUMBER
	| ROW_COUNT
	)
	;

conditionInformation
	: (
	CONDITION (variable | INTEGERLITERAL) 
	conditionInformationVariableEquate (COMMA conditionInformationVariableEquate)*
	)
	;

conditionInformationVariableEquate
	: (variable EQ (conditionInformationItemName | connectionInformationItemName))
	;

conditionInformationItemName
	: (
	CATALOG_NAME
	| CONDITION_NUMBER
	| CURSOR_NAME
	| DB2_ERROR_CODE1
	| DB2_ERROR_CODE2
	| DB2_ERROR_CODE3
	| DB2_ERROR_CODE4
	| DB2_INTERNAL_ERROR_POINTER
	| DB2_LINE_NUMBER
	| DB2_MESSAGE_ID
	| DB2_MODULE_DETECTING_ERROR
	| DB2_ORDINAL_TOKEN_n
	| DB2_REASON_CODE
	| DB2_RETURNED_SQLCODE
	| DB2_ROW_NUMBER
	| DB2_SQLERRD_SET
	| DB2_SQLERRD1
	| DB2_SQLERRD2
	| DB2_SQLERRD3
	| DB2_SQLERRD4
	| DB2_SQLERRD5
	| DB2_SQLERRD6
	| DB2_TOKEN_COUNT
	| MESSAGE_TEXT
	| RETURNED_SQLSTATE
	| SERVER_NAME
	)
	;

connectionInformationItemName
	: (
	DB2_AUTHENTICATION_TYPE
	| DB2_AUTHORIZATION_ID
	| DB2_CONNECTION_STATE
	| DB2_CONNECTION_STATUS
	| DB2_ENCRYPTION_TYPE
	| DB2_SERVER_CLASS_NAME
	| DB2_PRODUCT_ID
	)
	;

combinedInformation
	: (
	variable EQ ALL
	combinedInformationOption (COMMA combinedInformationOption)*
	)
	;

combinedInformationOption
	: (
	STATEMENT
	| ((CONDITION | CONNECTION) (variable | INTEGERLITERAL)?)
	)
	;

fetchOrientation
	: (BEFORE | AFTER | rowPositioned | rowsetPositioned)
	;

rowPositioned
	: (
	NEXT
	| PRIOR
	| FIRST
	| LAST
	| (CURRENT CONTINUE?)
	| (ABSOLUTE (hostVariable | INTEGERLITERAL))
	| (RELATIVE (hostVariable | INTEGERLITERAL))
	)
	;

rowsetPositioned
	: (
	(NEXT ROWSET)
	| (PRIOR ROWSET)
	| (FIRST ROWSET)
	| (LAST ROWSET)
	| (CURRENT  ROWSET)
	| (ROWSET STARTING AT (ABSOLUTE | RELATIVE) (hostVariable | INTEGERLITERAL))
	)
	;

singleRowFetch
	: (
	(INTO ((fetchTargetVariable (COMMA fetchTargetVariable)*) | arrayElementSpecification))
	| ((INTO | USING) DESCRIPTOR descriptorName)
	)
	;
/*
The target variable in this clause could be any of {global-variable-name,
host-variable-name, SQL-parameter-name, SQL-variable-name, 
transition-variable-name} all of which conform to the variableName rule
save for host-variable-name; thus we confine the rule to just those two.
*/

fetchTargetVariable
	: (variable | hostVariable)
	;

/*
The syntax diagram in the documentation shows that both of these
clauses are optional.  In ANTLR terms, this means an error of the
form "rule can match the empty string."  So my interpretation is
to have a rule that allows one, the other, or both, and then the
entire rule is optional in the fetchStatement rule. 
*/
multipleRowFetch
	: (
	(multipleRowFetchForClause? multipleRowFetchIntoClause)
	| (multipleRowFetchForClause multipleRowFetchIntoClause?)
	| (multipleRowFetchForClause multipleRowFetchIntoClause)
	)
	;

multipleRowFetchForClause
	: (FOR (hostVariable | INTEGERLITERAL) ROWS)
	;

multipleRowFetchIntoClause
	: ((INTO hostVariable (COMMA hostVariable)*) | ((INTO | USING) DESCRIPTOR descriptorName))
	;

explainPlanClause
	: (
	(PLAN | ALL) (SET QUERYNO EQ INTEGERLITERAL)? FOR
	(query | insertStatement | mergeStatement | searchedDelete | searchedUpdate)
	)
	;

explainStmtcacheClause
	: (
	STMTCACHE
		(ALL
		| (STMTID (hostVariable | INTEGERLITERAL))
		| (STMTTOKEN (hostVariable | NONNUMERICLITERAL)))
	)
	;

explainPackageClause
	: (
	PACKAGE packageScopeSpecification
	)
	;

explainStabilizedDynamicQueryClause
	: (
	STABILIZED DYNAMIC QUERY STMTID
	(hostVariable | INTEGERLITERAL)
	(COPY NONNUMERICLITERAL)?
	)
	;

packageScopeSpecification
	: (
	COLLECTION collectionName
	PACKAGE packageScopePackageName
	(VERSION versionName)?
	(COPY NONNUMERICLITERAL)?
	)
	;

collectionName
	: (:hostVariable | NONNUMERICLITERAL)
	;

packageScopePackageName
	: (:hostVariable | NONNUMERICLITERAL)
	;

versionName
	: (:hostVariable | NONNUMERICLITERAL)
	;


/*
For purposes of this grammar there is no difference between a
host-variable and a host-variable-array.  The first option in
the sourceRowData rule allows either, but only for former is 
coded as its rule will also match the latter.
*/
sourceRowData
	: (
	((USING hostVariable (COMMA hostVariable)*)
	| (USING DESCRIPTOR descriptorName))
	(FOR (INTEGERLITERAL | hostVariable) ROWS)?
	)
	;

aliasDesignation
	: (PUBLIC? ALIAS aliasName (FOR (TABLE | SEQUENCE))?)
	;

dropDatabaseClause
	: (DATABASE databaseName)
	;

dropFunctionClause
	: (
		(FUNCTION functionName
			(LPAREN functionParameterType (COMMA functionParameterType)* RPAREN)?
			RESTRICT?)
		| (SPECIFIC FUNCTION specificName RESTRICT?)
	)
	;

dropIndexClause
	: (INDEX indexName)
	;

dropMaskClause
	: (MASK maskName)
	;

dropPackageClause
	: (PACKAGE packageDesignator)
	;

dropPermissionClause
	: (PERMISSION permissionName)
	;

dropProcedureClause
	: (PROCEDURE procedureName RESTRICT?)
	;

dropRoleClause
	: (ROLE roleName RESTRICT?)
	;

dropSequenceClause
	: (SEQUENCE sequenceName RESTRICT?)
	;

dropStogroupClause
	: (STOGROUP stogroupName)
	;

dropSynonymClause
	: (SYNONYM synonym)
	;

dropTableClause
	: (TABLE tableName)
	;

dropTablespaceClause
	: (TABLESPACE (databaseName DOT)? tablespaceName)
	;

dropTriggerClause
	: (TRIGGER triggerName)
	;

dropTrustedContextClause
	: (TRUSTED CONTEXT contextName)
	;

dropTypeClause
	: (TYPE typeName RESTRICT?)
	;

dropVariableClause
	: (VARIABLE variableName RESTRICT?)
	;

dropViewClause
	: (VIEW viewName)
	;

packageDesignator
	: (collectionID DOT packageName (VERSION? versionID)?)
	;

describeUsingOption
	: (USING (NAMES | LABELS | ANY | BOTH))
	;

declareGlobalTemporaryTableLikeClause
	: (LIKE tableName copyOptions?)
	;

onCommitClause
	: (ON COMMIT ((DELETE ROWS) | (PRESERVE ROWS) | (DROP TABLE)))
	;

loggedWithRollbackClause
	: (
	LOGGED
	| (NOT LOGGED (ON ROLLBACK (DELETE | PRESERVE) ROWS)?)
	)
	;

createViewCheckOptionClause
	: (WITH (CASCADED | LOCAL)? CHECK OPTION)
	;

trustedContextDefaultRoleClause
	: (
	(NO DEFAULT ROLE)
	| (DEFAULT ROLE roleName ((WITHOUT ROLE AS OBJECT OWNER) | (WITH ROLE AS OBJECT OWNER AND QUALIFIER))?)
	)
	;

trustedContextEnableDisableClause
	: (DISABLE | ENABLE)
	;

trustedContextDefaultSecurityLabelClause
	: ((NO DEFAULT SECURITY LABEL) | (DEFAULT SECURITY LABEL seclabelName))
	;

trustedContextAttributesClause
	: (
	ATTRIBUTES 
	LPAREN 
	((trustedContextAttribute1 (COMMA trustedContextAttribute1)*)
	| (trustedContextAttribute2 (COMMA trustedContextAttribute2)*))
	RPAREN
	)
	;

trustedContextWithUseForClause
	: (WITH USE FOR trustedContextUseFor (COMMA trustedContextUseFor)*)
	;

trustedContextAttribute1
	: (
	(ADDRESS addressValue)
	| (ENCRYPTION encryptionValue)
	| (SERVAUTH servauthValue)
	)
	;

trustedContextAttribute2
	: (
	(JOBNAME jobnameValue)
	)
	;

trustedContextUseFor
	: (
	(authorizationName userOptions*)
	| (EXTERNAL SECURITY PROFILE profileName userOptions*)
	| (PUBLIC (WITH | WITHOUT) AUTHENTICATION)
	)
	;

userOptions
	: (
	(ROLE roleName)
	| (SECURITY LABEL seclabelName)
	| ((WITH | WITHOUT) AUTHENTICATION)
	)
	;

triggerDefinition
	: (
	triggerActivationTime triggerEvent ON tableName
	(REFERENCING
		((OLD | NEW | OLD_TABLE | NEW_TABLE | (OLD TABLE) | (NEW TABLE)) AS? correlationName)+)?
	triggerGranularity MODE_ DB2SQL triggerDefinitionOption? triggeredAction
	)
	;

triggerActivationTime
	: (
	(NO CASCADE BEFORE)
	| AFTER
	| (INSTEAD OF)
	)
	;

triggerEvent
	: (
	INSERT
	| DELETE
	| (UPDATE (OF columnName (COMMA columnName)*)?)
	)
	;

triggerGranularity
	: (
	(FOR EACH STATEMENT)
	| (FOR EACH ROW)
	)
	;

triggeredAction
	: (
	(WHEN LPAREN searchCondition RPAREN)? sqlTriggerBody
	)
	;

sqlTriggerBody
	: (
	triggeredSqlStatement
	| (BEGIN ATOMIC (triggeredSqlStatement SEMICOLON)+ END)
	)
	;

triggeredSqlStatement
	: (
	callStatement
	| searchedDelete
	| ((commonTableExpression)? fullSelect)
	| insertStatement
	| mergeStatement
	| refreshTableStatement
	| setAssignmentStatement
	| signalStatement
	| truncateStatement
	| searchedUpdate
	| valuesStatement
	)
	;

triggerDefinitionOption
	: (
	(NOT SECURED)
	| SECURED
	)
	;

createTableInClause
	: (
	(IN databaseName? tablespaceName)
	| (IN DATABASE databaseName)
	| (IN ACCELERATOR acceleratorName)
	)
	;

createTableColumnDefinition
	: (
	columnName dataType?
	(NOT NULL)?
	generatedClause?
	createTableColumnConstraint?
	defaultClause?
	fieldprocClause?
	asSecurityLabelClause?
	implicitlyHiddenClause?
	inlineLengthClause?
	)
	;

editprocClause
	: (EDITPROC programName ((WITH | WITHOUT) ROW ATTRIBUTES)?)
	;

/*
NULL is only valid for ALTER TABLE.
*/
validprocClause
	: (VALIDPROC (programName | NULL))
	;

auditClause
	: (AUDIT (NONE | CHANGES | ALL))
	;

obidClause
	: (OBID INTEGERLITERAL)
	;

dataCaptureClause
	: (DATA CAPTURE (NONE | CHANGES))
	;

restrictOnDropClause
	: (WITH RESTRICT ON DROP)
	;

ccsidClause1
	: (CCSID (ASCII | EBCDIC | UNICODE))
	;

ccsidClause2
	: (CCSID INTEGERLITERAL)
	;

cardinalityClause
	: (NOT? VOLATILE CARDINALITY?)
	;

appendClause
	: (APPEND (YES | NO))
	;

memberClause
	: (MEMBER CLUSTER)
	;

trackmodClause
	: (TRACKMOD (YES | NO))
	;

pagenumClause
	: (PAGENUM (RELATIVE | ABSOLUTE))
	;

fieldprocClause
	: (FIELDPROC programName LPAREN literal (COMMA literal)* RPAREN)
	;

asSecurityLabelClause
	: (AS SECURITY LABEL)
	;

implicitlyHiddenClause
	: (IMPLICITLY HIDDEN_)
	;

inlineLengthClause
	: (INLINE LENGTH INTEGERLITERAL)
	;

copyOptions
	: (
		(
		copyOptionIdentity
		| copyOptionRowChangeTimestamp
		| copyOptionColumnDefaults
		| copyOptionXmlTypeModifiers
		)+
	)
	;

copyOptionIdentity
	: ((EXCLUDING | INCLUDING) IDENTITY (COLUMN ATTRIBUTES)?)
	;

copyOptionRowChangeTimestamp
	: ((EXCLUDING | INCLUDING) ROW CHANGE TIMESTAMP (COLUMN ATTRIBUTES)?)
	;

copyOptionColumnDefaults
	: (
		((EXCLUDING | INCLUDING) COLUMN? DEFAULTS)
		| (USING TYPE DEFAULTS)
	)
	;

copyOptionXmlTypeModifiers
	: (EXCLUDING XML TYPE MODIFIERS)
	;

asResultTable
	: (
	LPAREN (columnName (COMMA columnName)*)? RPAREN AS
	LPAREN fullSelect RPAREN
	WITH NO DATA
	)
	;

declareGlobalTemporaryTableAsResultTable
	: (
	AS LPAREN fullSelect RPAREN
	WITH NO DATA
	)
	;

createTableMaterializedQueryDefinition
	: (
	(LPAREN columnName (COMMA columnName)* RPAREN)? 
	AS materializedQueryDefinition
	)
	;

createTableColumnConstraint
	: (
	(CONSTRAINT constraintName)?
		(
			(PRIMARY KEY)
			| UNIQUE
			| referencesClause
			| (CHECK LPAREN checkCondition RPAREN)
		)
	)
	;

/*
Deprecated as of Db2 12.
*/
organizationClause
	: (
	ORGANIZE BY HASH UNIQUE
	LPAREN columnName (COMMA columnName)* RPAREN
	(HASH SPACE SQLIDENTIFIER)?
	)
	;

createGlobalTemporaryTableColumnDefinition
	: (
	columnName dataType (NOT NULL)?
	)
	;

declareGlobalTemporaryTableColumnDefinition
	: (
	columnName dataType 
	(defaultClause1
	| generatedClause2
	| (NOT NULL))* 
	)
	;

parameterDeclaration1
	: (
	parameterName? ((functionDataType (AS LOCATOR)?) | (TABLE LIKE tableName (AS LOCATOR)?))
	)
	;

parameterDeclaration2
	: (
	parameterName functionDataType
	)
	;

parameterDeclaration3
	: (
	(IN | OUT | INOUT)? parameterName? procedureDataType (AS LOCATOR)?
	)
	;

createFunctionStatementExternalScalarOptions
	: (
	(RETURNS 
		((dataType (AS LOCATOR)?)
		| (dataType CAST FROM dataType (AS LOCATOR)?)))
	| externalNameOption1
	| languageOption3
	| parameterStyleOption2
	| deterministicOption
	| fencedOption
	| nullInputOption1
	| sqlDataOption3
	| externalActionOption
	| packagePathOption
	| scratchpadOption
	| finalCallOption
	| parallelOption2
	| dbinfoOption
	| cardinalityOption
	| collectionIdOption
	| wlmEnvironmentOption1
	| asuTimeOption
	| stayResidentOption
	| programTypeOption
	| securityOption
	| stopAfterFailureOption
	| runOptionsOption
	| specialRegistersOption
	| dispatchOption
	| securedOption
	| specificNameOption1
	| parameterOption1
	)
	;

//
externalNameOption1
	: (EXTERNAL (NAME (externalProgramName | identifier))?)
	;

externalNameOption2
	: (EXTERNAL NAME (externalProgramName | identifier))
	;

dynamicResultSetOption
	: (DYNAMIC? RESULT (SET |SETS) INTEGERLITERAL)
	;

languageOption1
	: (LANGUAGE SQL)
	;

languageOption2
	: (LANGUAGE (ASSEMBLE | C_ | COBOL | PLI))
	;

languageOption3
	: (LANGUAGE (ASSEMBLE | C_ | COBOL | JAVA | PLI))
	;

languageOption4
	: (LANGUAGE (ASSEMBLE | C_ | COBOL | JAVA | PLI | SQL))
	;

languageOption5
	: (LANGUAGE (ASSEMBLE | C_ | COBOL | JAVA | PLI | REXX))
	;

parameterStyleOption1
	: (PARAMETER STYLE SQL)
	;

parameterStyleOption2
	: (PARAMETER STYLE (SQL | JAVA))
	;

parameterStyleOption3
	: (PARAMETER STYLE (SQL | DB2SQL | (STANDARD CALL) | GENERAL | (SIMPLE CALL) | ((GENERAL | (SIMPLE CALL)) WITH NULLS) | JAVA))
	;

deterministicOption
	: ((NOT? DETERMINISTIC) | (NOT? VARIANT))
	;

fencedOption
	: (FENCED)
	;

nullInputOption1
	: ((RETURNS NULL ON NULL INPUT) | (CALLED ON NULL INPUT) | (NULL CALL))
	;

nullInputOption2
	: ((CALLED ON NULL INPUT) | (NULL CALL))
	;

debugOption
	: ((DISALLOW | ALLOW | DISABLE) DEBUG MODE_)
	;

sqlDataOption1
	: ((READS SQL DATA) | (CONTAINS SQL))
	;

sqlDataOption2
	: ((READS SQL DATA) | (CONTAINS SQL) | (NO SQL))
	;

sqlDataOption3
	: ((MODIFIES SQL DATA) | (READS SQL DATA) | (CONTAINS SQL) | (NO SQL))
	;

externalActionOption
	: (NO? EXTERNAL ACTION)
	;

packagePathOption
	: ((PACKAGE PATH packagePath) | (NO PACKAGE PATH))
	;

scratchpadOption
	: ((NO SCRATCHPAD) | (SCRATCHPAD INTEGERLITERAL))
	;

finalCallOption
	: (NO? FINAL CALL)
	;

parallelOption1
	: (DISALLOW PARALLEL)
	;

parallelOption2
	: ((ALLOW | DISALLOW) PARALLEL)
	;

dbinfoOption
	: (NO? DBINFO)
	;

cardinalityOption
	: (CARDINALITY INTEGERLITERAL)
	;

collectionIdOption
	: ((NO COLLID) | (COLLID collectionID))
	;

wlmEnvironmentOption1
	: (WLM ENVIRONMENT (identifier | (LPAREN identifier RPAREN)))
	;

wlmEnvironmentOption2
	: (WLM ENVIRONMENT (identifier | (LPAREN identifier COMMA SPLAT RPAREN)))
	;

asuTimeOption
	: (ASUTIME ((NO LIMIT) | (LIMIT INTEGERLITERAL)))
	;

stayResidentOption
	: (STAY RESIDENT (NO | YES))
	;

programTypeOption
	: (PROGRAM TYPE (SUB | MAIN))
	;

securityOption
	: (SECURITY (DB2 | USER | DEFINER))
	;

stopAfterFailureOption
	: ((STOP AFTER SYSTEM DEFAULT FAILURES) | (STOP AFTER INTEGERLITERAL FAILURES) | (CONTINUE AFTER FAILURE))
	;

runOptionsOption
	: (RUN OPTIONS runTimeOptions)
	;

commitOnReturnOption
	: (COMMIT ON RETURN (YES | NO))
	;

specialRegistersOption
	: ((INHERIT | DEFAULT) SPECIAL REGISTERS)
	;

dispatchOption
	: (STATIC DISPATCH)
	;

securedOption
	: (NOT? SECURED)
	;

specificNameOption1
	: (SPECIFIC specificName?)
	;

specificNameOption2
	: (SPECIFIC specificName)
	;

parameterOption1
	: (PARAMETER 
		(ccsidClause1
		| (VARCHAR (NULTERM | STRUCTURE)))+)
	;

parameterOption2
	: (PARAMETER ccsidClause1)
	;

//

createFunctionStatementExternalTableOptions
	: (
	(RETURNS 
		((TABLE LPAREN columnName functionDataType (AS LOCATOR)? (COMMA columnName functionDataType (AS LOCATOR)?)* RPAREN)
		| (GENERIC TABLE)))
	| externalNameOption1
	| languageOption2
	| parameterStyleOption1
	| deterministicOption
	| fencedOption
	| nullInputOption1
	| sqlDataOption2
	| externalActionOption
	| packagePathOption
	| scratchpadOption
	| finalCallOption
	| parallelOption1
	| dbinfoOption
	| cardinalityOption
	| collectionIdOption
	| wlmEnvironmentOption1
	| asuTimeOption
	| stayResidentOption
	| programTypeOption
	| securityOption
	| stopAfterFailureOption
	| runOptionsOption
	| specialRegistersOption
	| dispatchOption
	| securedOption
	| specificNameOption1
	| parameterOption1
	)
	;

createFunctionStatementSourcedOptions
	: (
	(RETURNS functionDataType (AS LOCATOR)?)
	| specificNameOption2
	| parameterOption2
	| (SOURCE 
		((functionName LPAREN parameterType (COMMA parameterType)* RPAREN)
		| specificNameOption2))
	)
	;

createFunctionStatementInlineSqlScalarOptions
	: (
	(RETURNS functionDataType languageOption1?)
	| (RETURN (expression | NULL | fullSelect))
	| deterministicOption
	| nullInputOption1
	| sqlDataOption1
	| externalActionOption
	| dispatchOption
	| securedOption
	| specificNameOption1
	| parameterOption2
	)
	;

sequenceAlias
	: (
	aliasName FOR SEQUENCE sequenceName
	)
	;

tableAlias
	: (
	aliasName FOR TABLE? tableName
	)
	;

authorization
	: (USER hostVariable USING hostVariable)
	;

searchedDelete
	: (
	DELETE FROM tableName periodClause? AS? correlationName? includeColumns?
	(SET assignmentClause)? (WHERE searchCondition) fetchClause?
	(isolationClause | skipLockedDataClause)* querynoClause?
	)
	;

positionedDelete
	: (
	DELETE FROM tableName AS? correlationName? WHERE CURRENT OF cursorName
	(FOR ROW (hostVariable | INTEGERLITERAL) OF ROWSET)?
	)
	;

searchedUpdate
	: (
	UPDATE tableName periodClause? AS? correlationName? includeColumns?
	SET assignmentClause (WHERE searchCondition)? 
	(isolationClause | skipLockedDataClause)* querynoClause?
	)
	;

positionedUpdate
	: (
	UPDATE tableName AS? correlationName? 
	SET assignmentClause
	WHERE CURRENT OF cursorName
	(FOR ROW (hostVariable | INTEGERLITERAL) OF ROWSET)?
	)
	;

sourceValues
	: (
	LPAREN VALUES 
	(valuesSingleRow | valuesMultipleRow) 
	RPAREN 
	AS? correlationName 
	LPAREN columnName (COMMA columnName)* RPAREN
	)
	;

valuesSingleRow
	: (
	valuesList3 | (LPAREN valuesList3 (COMMA valuesList3)* RPAREN)
	)
	;

valuesMultipleRow
	: (
	valuesList4 | (LPAREN valuesList4 (COMMA valuesList4)* RPAREN)
	FOR (hostVariable | INTEGERLITERAL) ROWS
	)
	;

matchingCondition
	: (
	NOT? MATCHED (AND searchCondition)?
	)
	;

modificationOperation
	: (updateOperation | deleteOperation | insertOperation)
	;

assignmentClause
	: (
	(columnName EQ valuesList1 (COMMA columnName EQ valuesList1)*)
	| (LPAREN columnName (COMMA columnName)* 
		RPAREN EQ 
		LPAREN ((valuesList1 (COMMA valuesList1)*) | fullSelect)
		RPAREN)
	)
	;

setAssignmentClause
	: (
	(arrayElementSpecification EQ (expression | NULL))
	| (setAssignmentTargetVariable EQ valuesList1 (COMMA setAssignmentTargetVariable EQ valuesList1)*)
	| (LPAREN setAssignmentTargetVariable (COMMA setAssignmentTargetVariable)* 
		RPAREN EQ 
		LPAREN 
			(((valuesList1 (COMMA valuesList1)*) | fullSelect)
			| subSelect
			| (VALUES valuesList1)
			| (VALUES LPAREN valuesList1 (COMMA valuesList1)* RPAREN))
		RPAREN)
	)
	;

setAssignmentTargetVariable
	: (
	globalVariableName
	| hostVariable
	| sqlParameterName
	| sqlVariableName
	| transitionVariableName
	)
	;

updateOperation
	: (
	UPDATE SET assignmentClause (COMMA assignmentClause)*
	)
	;

deleteOperation
	: (DELETE)
	;

insertOperation
	: (
	INSERT LPAREN columnName (COMMA columnName)* RPAREN
	VALUES (valuesList1 |
		(LPAREN valuesList1 (COMMA valuesList1)* RPAREN))
	)
	;

signalInformation
	: (
	(SET MESSAGE_TEXT EQ expression (operator expression)*)
	| (LPAREN NONNUMERICLITERAL RPAREN)
	)
	;

valuesList1
	: ((expression (operator expression)*) | DEFAULT | NULL)
	;

valuesList2
	: (expression | hostVariable | DEFAULT | NULL)
	;

valuesList3
	: (expression | NULL)
	;

valuesList4
	: (expression | hostVariable | NULL)
	;

includeColumns
	: (INCLUDE LPAREN columnName dataType (COMMA columnName dataType)* RPAREN)
	;

multipleRowInsert
	: (
	VALUES (valuesList2 | (LPAREN valuesList2 (COMMA valuesList2)* RPAREN))
	(FOR (hostVariable | INTEGERLITERAL) ROWS)?
	(ATOMIC | notAtomicPhrase)
	)
	;

regenerateClause
	: (REGENERATE (USING APPLICATION COMPATIBILITY applCompatValue)?)
	;

alterIndexOptions
	:(
	bufferpoolOption
	| closeOption
	| copyOption
	| dssizeOption
	| piecesizeOption
	| usingSpecification1
	| freeSpecification
	| gbpcacheSpecification
	| clusterOption
	| paddedOption
	| compressOption
	| (ADD
		((COLUMN
		LPAREN
		columnName (ASC | DESC | RANDOM)?
		RPAREN)
		| (INCLUDE COLUMN LPAREN columnName RPAREN))
	  )
	)
	;

//
bufferpoolOption
	: (BUFFERPOOL bpName)
	;

closeOption
	: (CLOSE (YES | NO))
	;

copyOption
	: (COPY (YES | NO))
	;

dssizeOption
	: (DSSIZE SQLIDENTIFIER)
	;

piecesizeOption
	: (PIECESIZE SQLIDENTIFIER)
	;

clusterOption
	: (NOT? CLUSTER)
	;

paddedOption
	: (NOT? PADDED)
	;

compressOption
	: (COMPRESS ((YES (FIXEDLENGTH | HUFFMAN)?) | NO))
	;

defineOption
	: (DEFINE (YES | NO))
	;

locksizeOption
	: (LOCKSIZE (ANY | TABLESPACE | TABLE | PAGE | ROW | LOB))
	;

lockmaxOption
	: (LOCKMAX (SYSTEM | INTEGERLITERAL))
	;

enableDisableOption
	: (ENABLE | DISABLE)
	;

/*
Although the latter two options are "supported as alternatives,
they are not the preferred syntax."
*/
loggedOption
	: ((NOT? LOGGED) | (LOG NO) | (LOG YES))
	;

notAtomicPhrase
	: (NOT ATOMIC CONTINUE ON SQLEXCEPTION)
	;

//

alterIndexPartitionOptions
	: (
	ALTER partitionElement
		(usingSpecification1+
		| freeSpecification+
		| gbpcacheSpecification
		| dssizeOption)*
	)
	;

usingSpecification1
	: (
	(USING ((VCAT catalogName) | (STOGROUP stogroupName)))
	| (PRIQTY INTEGERLITERAL)
	| (SECQTY INTEGERLITERAL)
	| (ERASE (YES | NO))
	)
	;

freeSpecification
	: (
	(FREEPAGE INTEGERLITERAL)
	| (PCTFREE INTEGERLITERAL)
	)
	;

gbpcacheSpecification
	: (
	GBPCACHE (CHANGED | ALL | SYSTEM | NONE)
	)
	;

partitionElement
	: (
	PARTITION INTEGERLITERAL
	(ENDING AT? LPAREN 
		(literal | MAXVALUE | MINVALUE) (COMMA (literal | MAXVALUE | MINVALUE))* 
	RPAREN INCLUSIVE?)?
	)
	;

applCompatValue
	: (functionLevel)
	;

functionLevel
	: SQLIDENTIFIER
	;

functionParameterType
	: (functionDataType (AS LOCATOR)?)
	;

functionDataType
	: (functionBuiltInType | distinctTypeName)
	;

functionBuiltInType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) (length | (LPAREN RPAREN))? ccsidClause1? forDataQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) (length | (LPAREN RPAREN))? ccsidClause1? forDataQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidClause1?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) (LPAREN (INTEGERLITERAL SQLIDENTIFIER) RPAREN)?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE))
	| ROWID
	| XML
	)
	;

procedureBuiltinType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) (length | (LPAREN RPAREN))? ccsidClause1? forDataQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) (length | (LPAREN RPAREN))? ccsidClause1? forDataQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidClause1?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) length?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE)?)
	| ROWID
	)
	;

createTypeArrayBuiltinType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) length? ccsidClause1? forDataQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) length? ccsidClause1? forDataQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidClause1?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) length?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE)?)
	)
	;

createTypeArrayBuiltinType2
	: (
	INTEGER
	| INT
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) length? ccsidClause1? forDataQualifier?)
	)
	;

createVariableBuiltInType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) length? forDataQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) length? forDataQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) length?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) length?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE)?)
	)
	;

sourceDataType
	: procedureBuiltinType
	;

functionOptionList
	: (
	externalNameOption2
	| languageOption4
	| parameterStyleOption2
	| deterministicOption
	| nullInputOption1
	| sqlDataOption3
	| externalActionOption
	| packagePathOption
	| scratchpadOption
	| finalCallOption
	| parallelOption2
	| dbinfoOption
	| cardinalityOption
	| collectionIdOption
	| wlmEnvironmentOption2
	| asuTimeOption
	| stayResidentOption
	| programTypeOption
	| securityOption
	| stopAfterFailureOption
	| runOptionsOption
	| specialRegistersOption
	| dispatchOption
	| securedOption
	| SPECIFIC
	| (PARAMETER CCSID)
	)
	;

procedureOptionList
	: (
	dynamicResultSetOption
	| parameterOption1
	| externalNameOption2
	| languageOption5
	| parameterStyleOption3
	| deterministicOption
	| packagePathOption
	| sqlDataOption3
	| dbinfoOption
	| collectionIdOption
	| wlmEnvironmentOption2
	| asuTimeOption
	| stayResidentOption
	| programTypeOption
	| securityOption
	| runOptionsOption
	| (COMMIT ON RETURN (NO | YES))
	| specialRegistersOption
	| (CALLED ON NULL INPUT)
	| (NULL CALL)
	| stopAfterFailureOption
	| ((DISALLOW | ALLOW | DISABLE) DEBUG MODE_)
	)
	;

createProcedureOptionList
	: (
	specificNameOption2
	| dynamicResultSetOption
	| parameterOption1
	| externalNameOption1
	| languageOption5
	| sqlDataOption3
	| parameterStyleOption3
	| deterministicOption
	| packagePathOption
	| fencedOption
	| dbinfoOption
	| collectionIdOption
	| wlmEnvironmentOption2
	| asuTimeOption
	| stayResidentOption
	| programTypeOption
	| securityOption
	| runOptionsOption
	| commitOnReturnOption
	| specialRegistersOption
	| nullInputOption2
	| stopAfterFailureOption
	| debugOption
	)
	;

procedureDataType
	: (procedureBuiltinType | distinctTypeName)
	;

alterSequenceOptionList
	: (
	restartOption
	| incrementOption
	| minvalueOption
	| maxvalueOption
	| cycleOption
	| cacheOption
	| orderOption
	)
	;

createSequenceOptionList
	: (
	asTypeOption
	| startOption
	| incrementOption
	| minvalueOption
	| maxvalueOption
	| cycleOption
	| cacheOption
	| orderOption
	)
	;

//
asTypeOption
	: (AS sequenceDataType)
	;

startOption
	: (START WITH INTEGERLITERAL)
	;

restartOption
	: (RESTART (WITH INTEGERLITERAL)?)
	;

incrementOption
	: (INCREMENT BY INTEGERLITERAL)
	;

minvalueOption
	: ((NO MINVALUE) | (MINVALUE INTEGERLITERAL))
	;

maxvalueOption
	: ((NO MAXVALUE) | (MAXVALUE INTEGERLITERAL))
	;

cycleOption
	: (NO? CYCLE)
	;

cacheOption
	: ((NO CACHE) | (CACHE INTEGERLITERAL))
	;

orderOption
	: (NO? ORDER)
	;

keyLabelOption
	: ((NO KEY LABEL) | (KEY LABEL keyLabelName))
	;

dataclasOption
	: (DATACLAS dcName)
	;

mgmtclasOption
	: (MGMTCLAS mcName)
	;

storclasOption
	: (STORCLAS scName)
	;

//

alterStogroupOptionList
	: (
	(ADD VOLUMES LPAREN volumeID (COMMA volumeID)* RPAREN)
	| (ADD VOLUMES LPAREN NONNUMERICLITERAL (COMMA NONNUMERICLITERAL)* RPAREN)
	| (REMOVE VOLUMES LPAREN volumeID (COMMA volumeID)* RPAREN)
	| (REMOVE VOLUMES LPAREN NONNUMERICLITERAL (COMMA NONNUMERICLITERAL)* RPAREN)
	| keyLabelOption
	| dataclasOption
	| mgmtclasOption
	| storclasOption
	)
	;

alterTableOptionList
	: (
	(ADD COLUMN? alterTableColumnDefinition)
	| (ALTER COLUMN? columnAlteration)
	| (RENAME COLUMN sourceColumnName TO targetColumnName)
	| (DROP COLUMN? columnName RESTRICT)
	| (ADD periodDefinition)
	| (ADD (uniqueConstraint | referentialConstraint | checkConstraint))
	| (DROP ((PRIMARY KEY) | ((UNIQUE | (FOREIGN KEY) | CHECK | CONSTRAINT) constraintName)))
	| (ADD partitioningClause)
	| (ADD PARTITION partitionClause)
	| (ALTER PARTITION INTEGERLITERAL partitionClause)
	| (ROTATE PARTITION (FIRST | INTEGERLITERAL) TO LAST rotatePartitionClause)
	| (DROP ORGANIZATION)
	| (alterHashOrganization)
	| (ADD SYSTEM? VERSIONING USE HISTORY TABLE historyTableName extraRowOption?)
	| (DROP SYSTEM? VERSIONING)
	| (ADD ((MATERIALIZED QUERY) | QUERY)? materializedQueryDefinition)
	| (ALTER MATERIALIZED? QUERY materializedQueryAlteration)
	| (DROP MATERIALIZED? QUERY)
	| dataCaptureClause
	| cardinalityClause
	| (ADD CLONE cloneTableName)
	| (DROP CLONE)
	| (ADD RESTRICT ON DROP)
	| (DROP RESTRICT ON DROP)
	| ((ACTIVATE | DEACTIVATE) ROW ACCESS CONTROL)
	| ((ACTIVATE | DEACTIVATE) COLUMN ACCESS CONTROL)
	| appendClause
	| auditClause
	| validprocClause
	| (ENABLE ARCHIVE USE archiveTableName)
	| (DISABLE ARCHIVE)
	| (NO KEY LABEL)
	| (KEY LABEL keyLabelName)
	)
	;

alterTablespaceOptionList
	: (
	bufferpoolOption
	| ccsidClause2
	| closeOption
	| compressOption
	| (DROP PENDING CHANGES)
	| dssizeOption
	| insertAlgorithmOption
	| lockmaxOption
	| locksizeOption
	| loggedOption
	| maxrowsOption
	| maxpartitionsOption
	| (MEMBER CLUSTER (YES | NO))
	| segsizeOption
	| trackmodClause
	| (usingBlock)
	| (freeBlock)
	| (gbpcacheBlock)
	| (PAGENUM RELATIVE)
	)
	;

createTablespaceOptionList
	: (
	inDatabaseOption
	| bufferpoolOption
	| partitionByGrowthSpecification
	| partitionByRangeSpecification
	| segsizeOption
	| ccsidClause1
	| closeOption
	| compressOption
	| defineOption
	| freeBlock
	| gbpcacheBlock
	| insertAlgorithmOption
	| lockmaxOption
	| locksizeOption
	| loggedOption
	| maxrowsOption
	| maxpartitionsOption
	| memberClause
	| trackmodClause
	| usingBlock
	)
	;

/*
This rule does not strictly follow the syntax diagram, as the diagram
is at odds with at least one example and arguably with the narrative.

More specifically, it is unclear where the ALTER keyword is required,
and so this rule makes it optional where its use seems to me to be
ambiguously documented.
*/
trustedContextOptionList
	: (
	(ALTER SYSTEM AUTHID authorizationName)
	| (ALTER NO DEFAULT ROLE)
	| (ALTER DEFAULT ROLE roleName 
		((WITHOUT ROLE AS OBJECT OWNER) | (WITH ROLE AS OBJECT OWNER AND QUALIFIER))?)
	| (ALTER? ENABLE)
	| (ALTER? DISABLE)
	| (ALTER? NO DEFAULT SECURITY LABEL)
	| (ALTER? DEFAULT SECURITY LABEL seclabelName)
	| (ALTER ATTRIBUTES LPAREN alterAttributesOptions (COMMA alterAttributesOptions)* RPAREN)
	| (ADD ATTRIBUTES LPAREN addAttributesOptions (COMMA addAttributesOptions)* RPAREN)
	| (DROP ATTRIBUTES LPAREN dropAttributesOptions (COMMA dropAttributesOptions)* RPAREN)
	| userClause
	)
	;

databaseOptionList
	: (
	bufferpoolOption
	| (INDEXBP bpName)
	| (AS WORKFILE (FOR memberName)?)
	| (STOGROUP ( SYSDEFLT | stogroupName)?)
	| ccsidClause1
	)
	;

createIndexOptionList
	: (
	(xmlIndexSpecification)
	| includeColumnPhrase
	| clusterOption
	| (PARTITIONED)
	| paddedOption
	| compressOption
	| usingSpecification2
	| freeSpecification
	| gbpcacheSpecification
	| defineOption
	| ((INCLUDE | EXCLUDE) NULL KEYS)
	| (PARTITION BY RANGE? LPAREN
		partitionElement (usingSpecification2 | freeSpecification | gbpcacheSpecification | dssizeOption)*
		(COMMA partitionElement (usingSpecification2 | freeSpecification | gbpcacheSpecification | dssizeOption)*)* RPAREN)
	| bufferpoolOption
	| closeOption
	| (DEFER (NO | YES))
	| dssizeOption
	| piecesizeOption
	| copyOption
	)
	;

createLobTablespaceOptionList
	: (
	inDatabaseOption
	| bufferpoolOption
	| closeOption
	| compressOption
	| defineOption
	| dssizeOption
	| gbpcacheSpecification
	| lockmaxOption
	| locksizeOption
	| loggedOption
	| usingSpecification2
	)
	;

inDatabaseOption
	: (IN databaseName)
	;

segsizeOption
	: (SEGSIZE INTEGERLITERAL)
	;

numpartsOption
	: (NUMPARTS INTEGERLITERAL)
	;

partitionByGrowthSpecification
	: (
	(maxpartitionsOption numpartsOption?)
	| dssizeOption
	)
	;

partitionByRangeSpecification
	: (
	numpartsOption
		(
			(LPAREN 
			(partitionByRangePartitionPhrase (COMMA partitionByRangePartitionPhrase)*)*
			RPAREN)
		|	pagenumClause
		|	dssizeOption
		)*
	)
	;

partitionByRangePartitionPhrase
	: (
	(PARTITION | PART) INTEGERLITERAL
		(
		usingBlock
		| freeBlock
		| gbpcacheBlock
		| compressOption
		| trackmodClause
		| dssizeOption
		)*
	)
	;

insertAlgorithmOption
	: (INSERT ALGORITHM INTEGERLITERAL)
	;

maxrowsOption
	: (MAXROWS INTEGERLITERAL)
	;

maxpartitionsOption
	: (MAXPARTITIONS INTEGERLITERAL)
	;

usingSpecification2
	: (
	USING
		((STOGROUP stogroupName
			((PRIQTY INTEGERLITERAL)
			| (SECQTY INTEGERLITERAL)
			| (ERASE (NO | YES)))*)
		| (VCAT catalogName))
	)
	;

xmlIndexSpecification
	: (
	GENERATE (KEY | KEYS) USING XMLPATTERN xmlPatternClause AS SQL sqlDataType
	)
	;

/*
An xmlPatternClause has nontrivial syntax, but for purposes of this
grammar it is simply a quoted string.  It probably warrants a grammar
of its own.
*/
xmlPatternClause
	: NONNUMERICLITERAL
	;

alterAttributesOptions
	: (
	(ADDRESS addressValue)
	| (ENCRYPTION encryptionValue)
	| (SERVAUTH servauthValue)
	| (JOBNAME jobnameValue)
	)
	;

addAttributesOptions
	: (
	(ADDRESS addressValue)
	| (SERVAUTH servauthValue)
	| (JOBNAME jobnameValue)
	)
	;

dropAttributesOptions
	: (
	(ADDRESS addressValue?)
	| (SERVAUTH servauthValue?)
	| (JOBNAME jobnameValue?)
	)
	;

includeColumnPhrase
	: (INCLUDE LPAREN columnName (COMMA columnName)* RPAREN)
	;

userClause
	: (
	(ADD USE FOR userClauseAddOptions (COMMA userClauseAddOptions)*)
	| (REPLACE USE FOR userClauseReplaceOptions (COMMA userClauseReplaceOptions)*)
	| (DROP USE FOR userClauseDropOptions (COMMA userClauseDropOptions)*)
	)
	;

userClauseAddOptions
	: (
	(authorizationName useOptions?)
	| (EXTERNAL SECURITY PROFILE profileName useOptions?)
	| (PUBLIC (WITH | WITHOUT) AUTHENTICATION)
	)
	;

userClauseReplaceOptions
	: (userClauseAddOptions)
	;

userClauseDropOptions
	: (
	(authorizationName)
	| (EXTERNAL SECURITY PROFILE profileName)
	| (PUBLIC)
	)
	;

useOptions
	: (
	(ROLE roleName)? (SECURITY LABEL seclabelName)? (WITH | WITHOUT) AUTHENTICATION
	)
	;

alterPartitionClause
	: (
	((ALTER? PARTITION) | PART) INTEGERLITERAL
		( (usingBlock)
		| (freeBlock)
		| (gbpcacheBlock)
		| compressOption
		| dssizeOption
		| trackmodClause
		)+
	)
	;

usingBlock
	: (
	usingSpecification1+
	)
	;

freeBlock
	: (
	((FREEPAGE INTEGERLITERAL)
	| (PCTFREE INTEGERLITERAL)
	| (PCTFREE (INTEGERLITERAL? FOR UPDATE INTEGERLITERAL)?)
	)+
	)
	;

moveTableClause
	: (
	MOVE TABLE tableName TO TABLESPACE (databaseName DOT)? tablespaceName
	)
	;

gbpcacheBlock
	: (
	GBPCACHE (CHANGED | ALL | SYSTEM | NONE)
	)
	;

aliasDesignator
	: (
	PUBLIC? ALIAS aliasName FOR (TABLE | SEQUENCE)
	)
	;

multipleColumnList
	: (
	tableName LPAREN
	columnName IS NONNUMERICLITERAL
	(COMMA columnName IS NONNUMERICLITERAL)*
	RPAREN
	)
	;

functionDesignator
	: (
	(FUNCTION functionName (LPAREN (parameterType (COMMA parameterType)*)? RPAREN)?)
	| (SPECIFIC FUNCTION specificName)
	)
	;

parameterType
	: (dataType (AS LOCATOR)?)
	;

alterTableColumnDefinitionOptionList1
	: (
	(defaultClause1)
	| (NOT NULL)
	| (columnConstraint)
	| (generatedClause)
	| implicitlyHiddenClause
	| asSecurityLabelClause
	| fieldprocClause
	| inlineLengthClause
	)
	;

alterTableColumnDefinitionOptionList2
	: (
	(defaultClause2)
	| (NOT NULL)
	| (columnConstraint)
	| (generatedClause)
	| implicitlyHiddenClause
	| asSecurityLabelClause
	| fieldprocClause
	| inlineLengthClause
	)
	;

columnConstraint
	: (referencesClause | checkConstraint)
	;

generatedClause
	: (
	(GENERATED (ALWAYS | (BY DEFAULT))? (asIdentityClause | asRowChangeTimestampClause))
	| (GENERATED ALWAYS?
		(asRowTransactionStartIDClause 
		| asRowTransactionTimestampClause 
		| asGeneratedExpressionClause))
	)
	;

generatedClause2
	: (GENERATED (ALWAYS | (BY DEFAULT)) asIdentityClause?)
	;

asIdentityClause
	: (
	AS IDENTITY (LPAREN 
	asIdentityClauseOptionList (COMMA? asIdentityClauseOptionList)* 
	RPAREN)?
	)
	;

asIdentityClauseOptionList
	: (
	startOption
	| incrementOption
	| minvalueOption
	| maxvalueOption
	| cycleOption
	| cacheOption
	| orderOption
	)
	;

asRowChangeTimestampClause
	: (FOR EACH ROW ON UPDATE AS ROW CHANGE TIMESTAMP)
	;

asRowTransactionStartIDClause
	: (AS TRANSACTION START ID)
	;

asRowTransactionTimestampClause
	: (AS ROW (BEGIN | START | END))
	;

asGeneratedExpressionClause
	: (AS LPAREN nonDeterministicExpression RPAREN)
	;

nonDeterministicExpression
	: (
	(DATA CHANGE OPERATION)
	| specialRegister
	| nonDeterministicExpressionSessionVariable
	)
	;

nonDeterministicExpressionSessionVariable
	: (
	(SYSIBM DOT PACKAGE_NAME)
	| (SYSIBM DOT PACKAGE_SCHEMA)
	| (SYSIBM DOT PACKAGE_VERSION)
	)
	;

columnAlteration
	: (columnName columnAlterationOptionList+)
	;

columnAlterationOptionList
	: (
	(SET DATA TYPE alteredDataType (INLINE LENGTH INTEGERLITERAL)?)
	| (SET defaultClause)
	| (SET INLINE LENGTH INTEGERLITERAL)
	| (SET GENERATED (ALWAYS | (BY DEFAULT)) identityAlteration?)
	| (identityAlteration)
	| (SET GENERATED ALWAYS? (asRowTransactionTimestampClause | asRowTransactionStartIDClause))
	| (DROP DEFAULT)
	)
	;

/*
In the IBM documentation, alteredDataType differs from dataType in that
it is a proper subset thereof.  The dataType rule includes a provision 
for CCSID on CHAR, VARCHAR, CLOB, GRAPHIC, VARGRAPHIC, and DBCLOB types
which is absent from the alteredDataType rule.  For purposes of this
grammar, a difference which makes no difference is no difference.
*/
alteredDataType
	: dataType
	;

/*
The difference between dataType and castDataType is in the coding
of the CCSID and FOR ... DATA qualifiers.  Sneaky.
*/
dataType
	: (builtInType | distinctTypeName)
	;

builtInType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) (length | (LPAREN RPAREN))? (forDataQualifier | ccsidClause2)?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) (length | (LPAREN RPAREN))? (forDataQualifier | ccsidClause2)?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidClause2?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) (LPAREN (INTEGERLITERAL | SQLIDENTIFIER) RPAREN)?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE)?)
	| ROWID
	| (XML (LPAREN xmlTypeModifier RPAREN)?)
	)
	;

sequenceDataType
	: (sequenceBuiltInType | distinctTypeName)
	;

sequenceBuiltInType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) integerInParens?)
	)
	;

sqlDataType
	: (
	(VARCHAR LPAREN INTEGERLITERAL RPAREN)
	| (DECFLOAT (LPAREN INTEGERLITERAL RPAREN)?)
	| DATE
	| (TIMESTAMP (LPAREN INTEGERLITERAL RPAREN)?)
	)
	;

xmlTypeModifier
	: (
	XMLSCHEMA 
	xmlSchemaSpecification (ELEMENT xmlElementName)?
	(COMMA xmlSchemaSpecification (ELEMENT xmlElementName)?)*
	)
	;

xmlSchemaSpecification
	: (
	(ID registeredXmlSchemaName)
	| (((URL targetNamespace) | (NO NAMESPACE)) (LOCATION schemaLocation)?)
	)
	;

/*
Documentation is a bit sketchy on details for the following
four items.  Examples would be nice.
*/
xmlElementName
	: (identifier | literal)
	;

piName
	: (NONNUMERICLITERAL)
	;

registeredXmlSchemaName
	: (
	SYSXSR DOT SQLIDENTIFIER
	)
	;

targetNamespace
	: (NONNUMERICLITERAL)
	;

schemaLocation
	: (NONNUMERICLITERAL)
	;

identityAlteration
	: (
	(RESTART (WITH INTEGERLITERAL)?)
	| (SET incrementOption)
	| (SET minvalueOption)
	| (SET maxvalueOption)
	| (SET cycleOption)
	| (SET cacheOption)
	| (SET orderOption)
	)
	;

uniqueConstraint
	: (
	(CONSTRAINT constraintName)? 
	((PRIMARY KEY) | UNIQUE) 
	LPAREN
	columnName (COMMA columnName)* 
	(COMMA BUSINESS_TIME WITHOUT OVERLAPS)? 
	RPAREN
	)
	;

referentialConstraint
	: (
	((CONSTRAINT constraintName FOREIGN KEY) | (FOREIGN KEY constraintName?))
	LPAREN
	columnName (PERIOD BUSINESS_TIME)? (COMMA columnName (PERIOD BUSINESS_TIME)?)* 
	RPAREN
	referencesClause
	)
	;

referencesClause
	: (
	REFERENCES tableName 
	(LPAREN
	columnName (PERIOD BUSINESS_TIME)? (COMMA columnName (PERIOD BUSINESS_TIME)?)* 
	RPAREN)?
	(ON DELETE (RESTRICT | (NO ACTION) | CASCADE | (SET NULL)))? 
	(NOT? ENFORCED)?
	(ENABLE QUERY OPTIMIZATION)?	
	)
	;

checkConstraint
	: (
	(CONSTRAINT constraintName)? CHECK LPAREN checkCondition RPAREN
	)
	;

partitioningClause
	: (
	PARTITION BY 
		((RANGE? 
		LPAREN 
		partitionExpression (COMMA partitionExpression)* 
		RPAREN
		LPAREN
		partitioningClauseElement (COMMA partitioningClauseElement)*
		RPAREN)
		| (SIZE (EVERY SQLIDENTIFIER)?))
	)
	;

partitionExpression
	: (
	columnName (NULLS LAST)? (ASC | DESC)
	)
	;

partitionLimitKey
	: (INTEGERLITERAL | MAXVALUE | MINVALUE)
	;

/*
The partitionHashSpace rule can be before the INCLUSIVE token in
the create table statement, or after the INCLUSIVE token in the
alter table statement.  Also, it's deprecated as of Db2 12.
*/
partitioningPhrase
	: (ENDING AT? LPAREN partitionLimitKey (COMMA partitionLimitKey)* RPAREN partitionHashSpace? INCLUSIVE? partitionHashSpace?)
	;

//deprecated as of Db2 12
partitionHashSpace
	: (HASH SPACE SQLIDENTIFIER)
	;

//deprecated as of Db2 12
alterHashOrganization
	: (
	(ADD ORGANIZE BY HASH UNIQUE LPAREN columnName (COMMA columnName)* RPAREN HASH SPACE SQLIDENTIFIER)
	| (ALTER ORGANIZATION SET HASH SPACE SQLIDENTIFIER)
	)
	;

partitioningClauseElement
	: (
	PARTITION INTEGERLITERAL partitioningPhrase
	)
	;

partitionClause
	: (
	partitioningPhrase | partitionHashSpace
	)
	;

rotatePartitionClause
	: (partitioningPhrase RESET)
	;

extraRowOption
	: (ON DELETE ADD EXTRA ROW)
	;

materializedQueryDefinition
	: (
	LPAREN fullSelect RPAREN refreshableTableOptions
	)
	;

materializedQueryAlteration
	: (SET refreshableTableOptionsList+)
	;

refreshableTableOptions
	: (dataInitiallyDeferredPhrase refreshDeferredPhrase refreshableTableOptionsList*)
	;

dataInitiallyDeferredPhrase
	: (DATA INITIALLY DEFERRED)
	;

refreshDeferredPhrase
	: (REFRESH DEFERRED)
	;

refreshableTableOptionsList
	: (
	(MAINTAINED BY (SYSTEM | USER))
	| (enableDisableOption QUERY OPTIMIZATION)
	)
	;

materializedQueryTableAlteration
	: (SET refreshableTableOptionsList+)
	;

periodDefinition
	: (
	PERIOD FOR?
	((SYSTEM_TIME LPAREN beginColumnName COMMA endColumnName RPAREN)
	| (BUSINESS_TIME LPAREN beginColumnName COMMA endColumnName (EXCLUSIVE | INCLUSIVE) RPAREN))
	)
	;

alterTableColumnDefinition
	: (
	(columnName builtInType alterTableColumnDefinitionOptionList1*)
	| (columnName distinctTypeName alterTableColumnDefinitionOptionList2*)
	)
	;

externalProgramName
	: (identifier | NONNUMERICLITERAL)
	;

packagePath
	: (
	collectionID
	| SESSION_USER
	| USER
	| (CURRENT PACKAGE PATH)
	| (CURRENT PATH)
	| hostVariable
	| NONNUMERICLITERAL
	)
	;

collectionID
	: identifier
	;

runTimeOptions
	: NONNUMERICLITERAL
	;

comparisonOperator
	: (EQ | GT | LT | GE | LE | NE)
	;

operator
	: (SPLAT | PLUS | MINUS | SLASH | CONCAT | CONCATOP)
	;

expression
	: (
	functionInvocation
	| LPAREN expression RPAREN
	| labeledDuration
	| literal
	| specialRegister
	| columnName
	| hostVariable
	| scalarFullSelect
	| timeZoneSpecificExpression
	| caseExpression
	| castSpecification
	| xmlCastSpecification
	| arrayElementSpecification
	| arrayConstructor
	| olapSpecification
	| rowChangeExpression
	| sequenceReference
	| ((operator | INTEGERLITERAL) expression)
	| ((functionInvocation
		| LPAREN expression RPAREN
		| labeledDuration
		| literal
		| specialRegister
		| columnName
		| hostVariable
		| scalarFullSelect
		| timeZoneSpecificExpression
		| caseExpression
		| castSpecification
		| xmlCastSpecification
		| arrayElementSpecification
		| arrayConstructor
		| olapSpecification
		| rowChangeExpression
		| sequenceReference)
		((operator | INTEGERLITERAL) expression)*)
	)
	;

keyExpression
	: (expression)
	;

rowChangeExpression
	: ROW CHANGE (TIMESTAMP | TOKEN) FOR tableName
	;

sequenceReference
	: (NEXT | PREVIOUS) VALUE FOR tableName
	;

functionInvocation
	: (
	scalarFunctionInvocation
	| aggregateFunctionInvocation
	| regressionFunctionInvocation
	| externalFunctionInvocation
	)
	;

scalarFunctionInvocation
	: (
	xmlattributesFunction
	| xmlelementFunction
	| xmlforestFunction
	| xmlmodifyFunction
	| xmlnamespaceFunction
	| xmlpiFunction
	| xmlqueryFunction
	| xmlserializeFunction
	| ((schemaName DOT)? scalarFunction LPAREN (expression (COMMA expression)*)? RPAREN (AS NONNUMERICLITERAL)?)
	)
	;

aggregateFunctionInvocation
	: (
	arrayaggFunction
	| correlationFunction
	| covarianceFunction
	| covarianceSampFunction
	| cumeDistFunction
	| listaggFunction
	| percentileContFunction
	| percentileDiscFunction
	| percentRankFunction
	| xmlaggFunction
	| ((schemaName DOT)? aggregateFunction LPAREN DISTINCT? (expression | SPLAT) RPAREN)
	)
	;

regressionFunctionInvocation
	: ((schemaName DOT)? regressionFunction
	LPAREN
	expression COMMA expression
	RPAREN)
	;

externalFunctionInvocation
	: ((schemaName DOT)? SQLIDENTIFIER
	LPAREN
	expression (COMMA expression)*
	RPAREN)
	;

labeledDuration
	: (
	(functionInvocation
	| (LPAREN expression RPAREN)
	| INTEGERLITERAL
	| columnName
	| variable)
	durationSuffix
	)
	;

durationSuffix
	: (
	YEAR
	| YEARS
	| MONTH
	| MONTHS
	| DAY
	| DAYS
	| HOUR
	| HOURS
	| MINUTE
	| MINUTES
	| SECOND
	| SECONDS
	| MICROSECOND
	| MICROSECONDS
	)
	;

xmlCastSpecification
	: XMLCAST (expression | NULL | parameterMarker) AS dataType
	;

arrayElementSpecification
	: arrayExpression OPENSQBRACKET arrayIndex CLOSESQBRACKET
	;

arrayIndex
	: expression (operator? expression)*
	;

arrayConstructor
	: ARRAY
	OPENSQBRACKET
	(
	QUESTIONMARK
	| fullSelect
	| ((expression | NULL) (COMMA (expression | NULL))*)
	)
	CLOSESQBRACKET
	;
	
olapSpecification
	: orderedOlapSpecification
	| numberingSpecification
	| aggregationSpecification
	;

orderedOlapSpecification
	: olapSpecificationFunction
	OVER LPAREN windowPartitionClause? windowOrderClause RPAREN
	;

olapSpecificationFunction
	: (
	(CUME_DIST LPAREN RPAREN)
	| (PERCENT_RANK LPAREN RPAREN)
	| (RANK LPAREN RPAREN)
	| (DENSE_RANK LPAREN RPAREN)
	| (NTILE LPAREN expression RPAREN)
	| lagFunction
	| leadFunction
	)
	;

lagFunction
	: LAG LPAREN expression 
	(
	COMMA INTEGERLITERAL 
		(COMMA expression 
			(COMMA ((RESPECT NULLS) | (IGNORE NULLS)))?)? RPAREN
	)
	;

leadFunction
	: LEAD LPAREN expression 
	(
	COMMA INTEGERLITERAL 
		(COMMA expression 
			(COMMA respectNullsClause)?)? RPAREN
	)
	;

respectNullsClause
	: ((RESPECT NULLS) | (IGNORE NULLS))
	;

windowPartitionClause
	: (PARTITION BY expression (COMMA expression)*)
	;

windowOrderClause
	: ORDER BY expression windowOrderClauseQualifier? (COMMA expression windowOrderClauseQualifier?)*
	;

windowOrderClauseQualifier
	: (ASC | DESC) (NULLS (FIRST | LAST))?
	;

numberingSpecification
	: ROW_NUMBER LPAREN RPAREN OVER LPAREN windowPartitionClause? windowOrderClause? RPAREN
	;

aggregationSpecification
	: (aggregateFunctionInvocation | olapColumnFunction) OVER LPAREN windowPartitionClause?
	((RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
	| (windowOrderClause ((RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) | windowAggregationGroupClause)?))?
	RPAREN
	;

aggregateFunction
	: (
	ARRAY_AGG
	| AVG
	| CORR
	| CORRELATION
	| COUNT
	| COUNT_BIG
	| COVAR_POP
	| COVARIANCE
	| COVAR
	| COVAR_SAMP
	| COVARIANCE_SAMP
	| CUME_DIST
	| GROUPING
	| LISTAGG
	| MAX
	| MEDIAN
	| MIN
	| PERCENTILE_CONT
	| PERCENTILE_DISC
	| PERCENT_RANK
	| STDDEV_POP
	| STDDEV
	| STDDEV_SAMP
	| SUM
	| VAR_POP
	| VARIANCE
	| VAR
	| VAR_SAMP
	| VARIANCE_SAMP
	| XMLAGG
	)
	;

regressionFunction
	: (
	REGR_AVGX
	| REGR_AVGY
	| REGR_COUNT
	| REGR_INTERCEPT
	| REGR_ICPT
	| REGR_R2
	| REGR_SLOPE
	| REGR_SXX
	| REGR_SXY
	| REGR_SYY
	)
	;

olapColumnFunction
	: (
	firstValueFunction
	| lastValueFunction
	| nthValueFunction
	| ratioToReportFunction
	)
	;

firstValueFunction
	: (FIRST_VALUE LPAREN expression (COMMA respectNullsClause)? RPAREN)
	;

lastValueFunction
	: (LAST_VALUE LPAREN expression (COMMA respectNullsClause)? RPAREN)
	;

nthValueFunction
	: (NTH_VALUE LPAREN expression COMMA INTEGERLITERAL RPAREN)
	;

ratioToReportFunction
	: (RATIO_TO_REPORT LPAREN expression RPAREN)
	;

listaggFunction
	: (
	LISTAGG LPAREN (ALL | DISTINCT)? expression (COMMA NONNUMERICLITERAL)? RPAREN
	(WITHIN GROUP LPAREN 
		ORDER BY sortKey (ASC | DESC)? (COMMA sortKey (ASC | DESC)?)* 
	RPAREN)?
	)
	;

arrayaggFunction
	: (arrayaggOrdinaryFunction | arrayaggAssociativeFunction)
	;

arrayaggOrdinaryFunction
	: (
	ARRAY_AGG LPAREN expression
	(ORDER BY sortKey (ASC | DESC)? (COMMA sortKey (ASC | DESC)?)*)?
	RPAREN
	)
	;

arrayaggAssociativeFunction
	: (
	ARRAY_AGG LPAREN expression (COMMA expression)? RPAREN
	)
	;

correlationFunction
	: ((CORR | CORRELATION) LPAREN expression COMMA expression RPAREN)
	;

covarianceFunction
	: ((COVAR_POP | COVARIANCE | COVAR) LPAREN expression COMMA expression RPAREN)
	;

covarianceSampFunction
	: ((COVAR_SAMP | COVARIANCE_SAMP) LPAREN expression COMMA expression RPAREN)
	;

cumeDistFunction
	: (
	CUME_DIST LPAREN
	expression (COMMA expression)*
	RPAREN 
	WITHIN GROUP LPAREN aggregateOrderByClause RPAREN
	)
	;

percentileContFunction
	: (
	PERCENTILE_CONT LPAREN expression RPAREN
	WITHIN GROUP LPAREN ORDER BY expression (ASC | DESC)? RPAREN
	)
	;

percentileDiscFunction
	: (
	PERCENTILE_DISC LPAREN expression RPAREN
	WITHIN GROUP LPAREN ORDER BY expression (ASC | DESC)? RPAREN
	)
	;

percentRankFunction
	: (
	PERCENT_RANK LPAREN
	expression (COMMA expression)*
	RPAREN 
	WITHIN GROUP LPAREN aggregateOrderByClause RPAREN
	)
	;

xmlaggFunction
	: (XMLAGG LPAREN expression xmlaggOrderByClause? RPAREN)
	;

xmlaggOrderByClause
	: (ORDER BY xmlaggOrderByOption (COMMA xmlaggOrderByOption)*)
	;

xmlaggOrderByOption
	: (expression (ASC | DESC)?)
	;

aggregateOrderByClause
	: (ORDER BY aggregateOrderByOption (COMMA aggregateOrderByOption)*)
	;

aggregateOrderByOption
	: (sortKey (ASC | DESC)? (NULLS (LAST | FIRST))?)
	;

windowAggregationGroupClause
	: (ROWS | RANGE) (groupStart | groupBetween | groupEnd)
	;

groupStart
	: (unboundedPreceding | boundedPreceding | currentRow)
	;

groupBetween
	: BETWEEN groupBound1 AND groupBound2
	;

groupEnd
	: (unboundedFollowing | boundedFollowing)
	;

groupBound1
	: (unboundedPreceding | boundedPreceding | boundedFollowing | currentRow)
	;

groupBound2
	: (unboundedFollowing | boundedPreceding | boundedFollowing | currentRow)
	;

unboundedPreceding
	: UNBOUNDED PRECEDING
	;

unboundedFollowing
	: UNBOUNDED FOLLOWING
	;

boundedPreceding
	: INTEGERLITERAL PRECEDING
	;

boundedFollowing
	: INTEGERLITERAL FOLLOWING
	;

currentRow
	: CURRENT ROW
	;

scalarFunction
	: (
	ABS
	| ABSVAL
	| ACOS
	| ADD_DAYS
	| ADD_MONTHS
	| ARRAY_DELETE
	| ARRAY_FIRST
	| ARRAY_LAST
	| ARRAY_NEXT
	| ARRAY_PRIOR
	| ARRAY_TRIM
	| ASCII
	| ASCII_CHR
	| ASCIISTR
	| ASCII_STR
	| ASIN
	| ATAN
	| ATAN2
	| ATANH
	| BIGINT
	| BINARY
	| BITAND
	| BITANDNOT
	| BITNOT
	| BITOR
	| BITXOR
	| BLOB
	| BTRIM
	| CARDINALITY
	| CCSID_ENCODING
	| CEIL
	| CEILING
	| CHAR
	| CHAR9
	| CHARACTER_LENGTH
	| CHAR_LENGTH
	| CHR
	| CLOB
	| COALESCE
	| COLLATION_KEY
	| COMPARE_DECFLOAT
	| CONCAT
	| CONTAINS
	| COS
	| COSH
	| DATE
	| DAY
	| DAYOFMONTH
	| DAYOFWEEK
	| DAYOFWEEK_ISO
	| DAYOFYEAR
	| DAYS
	| DAYS_BETWEEN
	| DBCLOB
	| DEC
	| DECFLOAT
	| DECFLOAT_FORMAT
	| DECFLOAT_SORTKEY
	| DECIMAL
	| DECODE
	| DECRYPT_BINARY
	| DECRYPT_BIT
	| DECRYPT_CHAR
	| DECRYPT_DATAKEY_BIGINT
	| DECRYPT_DATAKEY_BIT
	| DECRYPT_DATAKEY_CLOB
	| DECRYPT_DATAKEY_DBCLOB
	| DECRYPT_DATAKEY_DECIMAL
	| DECRYPT_DATAKEY_INTEGER
	| DECRYPT_DATAKEY_VARCHAR
	| DECRYPT_DATAKEY_VARGRAPHIC
	| DECRYPT_DB
	| DEGREES
	| DIFFERENCE
	| DIGITS
	| DOUBLE
	| DOUBLE_PRECISION
	| DSN_XMLVALIDATE
	| EBCDIC_CHR
	| EBCDIC_STR
	| ENCRYPT_DATAKEY
	| ENCRYPT_TDES
	| EXP
	| EXTRACT
	| FLOAT
	| FLOOR
	| GENERATE_UNIQUE
	| GENERATE_UNIQUE_BINARY
	| GETHINT
	| GETVARIABLE
	| GRAPHIC
	| GREATEST
	| HASH
	| HASH_CRC32
	| HASH_MD5
	| HASH_SHA1
	| HASH_SHA256
	| HEX
	| HOUR
	| IDENTITY_VAL_LOCAL
	| IFNULL
	| INSERT
	| INSTR
	| INT
	| INTEGER
	| JULIAN_DAY
	| LAST_DAY
	| LCASE
	| LEAST
	| LEFT
	| LENGTH
	| LN
	| LOCATE
	| LOCATE_IN_STRING
	| LOG10
	| LOWER
	| LPAD
	| LTRIM
	| MAX_CARDINALITY
	| MICROSECOND
	| MIDNIGHT_SECONDS
	| MINUTE
	| MOD
	| MONTH
	| MONTHS_BETWEEN
	| MQREAD
	| MQREADCLOB
	| MQRECEIVE
	| MQRECEIVECLOB
	| MQSEND
	| MULTIPLY_ALT
	| NEXT_DAY
	| NEXT_MONTH
	| NORMALIZE_DECFLOAT
	| NORMALIZE_STRING
	| NULLIF
	| NVL
	| OVERLAY
	| PACK
	| POSITION
	| POSSTR
	| POW
	| POWER
	| QUANTIZE
	| QUARTER
	| RADIANS
	| RAISE_ERROR
	| RAND
	| RANDOM
	| REAL
	| REGEXP_COUNT
	| REGEXP_INSTR
	| REGEXP_LIKE
	| REGEXP_REPLACE
	| REGEXP_SUBSTR
	| REPEAT
	| REPLACE
	| RID
	| RIGHT
	| ROUND
	| ROUND_TIMESTAMP
	| ROWID
	| RPAD
	| RTRIM
	| SCORE
	| SECOND
	| SIGN
	| SIN
	| SINH
	| SMALLINT
	| SOAPHTTPC
	| SOAPHTTPNC
	| SOAPHTTPNV
	| SOAPHTTPV
	| SOUNDEX
	| SPACE
	| SQRT
	| STRIP
	| STRLEFT
	| STRPOS
	| STRRIGHT
	| SUBSTR
	| SUBSTRING
	| TAN
	| TANH
	| TIME
	| TIMESTAMP
	| TIMESTAMPADD
	| TIMESTAMPDIFF
	| TIMESTAMP_FORMAT
	| TIMESTAMP_ISO
	| TIMESTAMP_TZ
	| TO_CHAR
	| TO_CLOB
	| TO_DATE
	| TO_NUMBER
	| TOTALORDER
	| TO_TIMESTAMP
	| TRANSLATE
	| TRIM
	| TRIM_ARRAY
	| TRUNC
	| TRUNCATE
	| TRUNC_TIMESTAMP
	| UCASE
	| UNICODE
	| UNICODE_STR
	| UNISTR
	| UPPER
	| VALUE
	| VARBINARY
	| VARCHAR
	| VARCHAR9
	| VARCHAR_BIT_FORMAT
	| VARCHAR_FORMAT
	| VARGRAPHIC
	| VERIFY_GROUP_FOR_USER
	| VERIFY_ROLE_FOR_USER
	| VERIFY_TRUSTED_CONTEXT_ROLE_FOR_USER
	| WEEK
	| WEEK_ISO
	| WRAP
	| XMLATTRIBUTES
	| XMLCOMMENT
	| XMLCONCAT
	| XMLDOCUMENT
	| XMLELEMENT
	| XMLFOREST
	| XMLMODIFY
	| XMLNAMESPACES
	| XMLPARSE
	| XMLPI
	| XMLQUERY
	| XMLSERIALIZE
	| XMLTEXT
	| XMLXSROBJECTID
	| XSLTRANSFORM
	| YEAR
	)
	;

tableFunction
	: (
	ADMIN_TASK_LIST
	| ADMIN_TASK_OUTPUT
	| ADMIN_TASK_STATUS
	| BLOCKING_THREADS
	| MQREADALL
	| MQREADALLCLOB
	| MQRECEIVEALL
	| MQRECEIVEALLCLOB
	| XMLTABLE
	)
	;
	
specialRegister
	: (
	CURRENT_ACCELERATOR
	| CURRENT_APPLICATION_COMPATIBILITY
	| CURRENT_APPLICATION_ENCODING_SCHEME
	| CURRENT_CLIENT_ACCTNG
	| CURRENT_CLIENT_APPLNAME
	| CURRENT_CLIENT_CORR_TOKEN
	| CURRENT_CLIENT_USERID
	| CURRENT_CLIENT_WRKSTNNAME
	| CURRENT_DATE
	| CURRENT_DEBUG_MODE
	| CURRENT_DECFLOAT_ROUNDING_MODE
	| CURRENT_DEGREE
	| CURRENT_EXPLAIN_MODE
	| CURRENT_GET_ACCEL_ARCHIVE
	| CURRENT_LOCALE_LC_CTYPE
	| CURRENT_MAINTAINED_TABLE_TYPES_FOR_OPTIMIZATION
	| CURRENT_MEMBER
	| CURRENT_OPTIMIZATION_HINT
	| CURRENT_PACKAGE_PATH
	| CURRENT_PACKAGESET
	| CURRENT_PATH
	| CURRENT_PRECISION
	| CURRENT_QUERY_ACCELERATION
	| CURRENT_QUERY_ACCELERATION_WAITFORDATA
	| CURRENT_REFRESH_AGE
	| CURRENT_ROUTINE_VERSION
	| CURRENT_RULES
	| CURRENT_SCHEMA
	| CURRENT_SERVER
	| CURRENT_SQLID
	| CURRENT_TEMPORAL_BUSINESS_TIME
	| CURRENT_TEMPORAL_SYSTEM_TIME
	| CURRENT_TIME
	| CURRENT_TIMESTAMP
	| CURRENT_TIME_ZONE
	| ENCRYPTION_PASSWORD
	| SESSION_TIME_ZONE
	| SESSION_USER
	| USER
	)
	;

xmlelementFunction
	: (
	XMLELEMENT LPAREN NAME xmlElementName
	(COMMA xmlnamespacesDeclaration)?
	(COMMA xmlattributesFunction)?
	(COMMA expression)*
	xmlFunctionOptionClause?
	RPAREN
	)
	;

xmlforestFunction
	: (
	XMLFOREST LPAREN xmlnamespaceFunction?
	elementContentExpression (AS xmlElementName)?
	(COMMA elementContentExpression (AS xmlElementName)?)*
	xmlFunctionOptionClause?
	RPAREN
	)
	;

xmlmodifyFunction
	: (
	XMLMODIFY LPAREN expression
	(COMMA expression AS (NONNUMERICLITERAL | identifier))*
	RPAREN
	)
	;

xmlpiFunction
	: (
	XMLPI LPAREN NAME piName (COMMA expression)? RPAREN
	)
	;

xmlqueryFunction
	: (
	XMLQUERY LPAREN xqueryExpressionConstant
	(PASSING (BY REF)? xqueryArgument (COMMA xqueryArgument)*)?
	(RETURNING SEQUENCE (BY REF)?)? (EMPTY ON EMPTY)?
	RPAREN
	)
	;

xmlattributesFunction
	: (
	XMLATTRIBUTES LPAREN 
	expression AS NONNUMERICLITERAL (COMMA expression AS NONNUMERICLITERAL)*
	RPAREN
	)
	;

xmlserializeFunction
	: (
	XMLSERIALIZE LPAREN CONTENT? expression AS dataType
	xmlserializeFunctionOptions*
	RPAREN
	)
	;

xmlnamespaceFunction
	: (
	XMLNAMESPACES LPAREN xmlnamespaceOption (COMMA xmlnamespaceOption)* RPAREN
	)
	;

xmlnamespaceOption
	: (
	(namespaceUri AS namespacePrefix)
	| (DEFAULT namespaceUri)
	| (NO DEFAULT)
	)
	;

xmlserializeFunctionOptions
	: (
	(VERSION NONNUMERICLITERAL)
	| ((EXCLUDING | INCLUDING) XMLDECLARATION)
	)
	;

xmlFunctionOptionClause
	: (
	OPTION xmlFunctionOption+
	)
	;

xmlFunctionOption
	: (
	((EMPTY | NULL) ON NULL)
	| (XMLBINARY USING? (BASE64 | HEX))
	)
	;

elementContentExpression
	: (expression)
	;

xqueryExpressionConstant
	: (NONNUMERICLITERAL)
	;

xqueryArgument
	: (xqueryContextItemExpression | (xqueryVariableExpression AS (identifier | NONNUMERICLITERAL)))
	;

xmltableFunctionSpecification
	: (
	XMLTABLE
	LPAREN
	(xmlnamespacesDeclaration COMMA)?
	rowXqueryExpressionConstant
	(PASSING (BY REF)? rowXqueryArgument (COMMA rowXqueryArgument)*)?
	(COLUMNS (xmlTableRegularColumnDefinition | xmlTableOrdinalityColumnDefinition)
		(COMMA (xmlTableRegularColumnDefinition | xmlTableOrdinalityColumnDefinition))*)?
	RPAREN
	)
	;

rowXqueryExpressionConstant
	: (NONNUMERICLITERAL)
	;

rowXqueryArgument
	: (
	(xqueryContextItemExpression | (xqueryVariableExpression AS (identifier | NONNUMERICLITERAL)))
	)
	;

xqueryContextItemExpression
	: (expression)
	;

xqueryVariableExpression
	: (expression)
	;

xmlTableRegularColumnDefinition
	: (
	columnName
	dataType
	(defaultClause | (PATH columnXqueryExpressionConstant))?
	)
	;

defaultClause
	: (
	WITH? DEFAULT
	(defaultClauseAllowables
	| (distinctTypeCastFunctionName LPAREN defaultClauseAllowables RPAREN))
	)
	;

defaultClause1
	: (
	WITH? DEFAULT defaultClauseAllowables?
	)
	;

defaultClause2
	: (
	WITH? DEFAULT
	(defaultClauseAllowables
	| (distinctTypeCastFunctionName LPAREN defaultClauseAllowables RPAREN))
	)
	;

defaultClauseAllowables
	: (
	literal
	| SESSION_USER
	| USER
	| CURRENT_SQLID
	| NULL
	)
	;

distinctTypeCastFunctionName
	: (identifier DOT identifier)
	;

/*
castFunction
	: (
	castSpecification
	| scalarFunctionInvocation
	| charFunctionSpecification
	| clobFunctionSpecification
	| dbclobFunctionSpecification
	| graphicFunctionSpecification1
	| graphicFunctionSpecification2
	| vargraphicFunctionSpecification1
	| vargraphicFunctionSpecification2
	)
	;

expressionAndCodeUnitsArguments
	: (
	expression 
	(COMMA INTEGERLITERAL (COMMA (CODEUNITS16 | CODEUNITS32 | OCTETS))?)?
	)
	;

clobFunctionSpecification
	: (
	CLOB
	LPAREN
	expressionAndCodeUnitsArguments
	RPAREN
	)
	;

dbclobFunctionSpecification
	: (
	DBCLOB
	LPAREN
	expressionAndCodeUnitsArguments
	RPAREN
	)
	;

graphicFunctionSpecification1
	: (
	GRAPHIC
	LPAREN
	expressionAndCodeUnitsArguments
	RPAREN
	)
	;

graphicFunctionSpecification2
	: (
	GRAPHIC
	LPAREN
	expression 
	NONNUMERICLITERAL?
	RPAREN
	)
	;

vargraphicFunctionSpecification1
	: (
	GRAPHIC
	LPAREN
	expressionAndCodeUnitsArguments
	RPAREN
	)
	;

vargraphicFunctionSpecification2
	: (
	GRAPHIC
	LPAREN
	expression 
	NONNUMERICLITERAL?
	RPAREN
	)
	;
*/

columnXqueryExpressionConstant
	: (NONNUMERICLITERAL)
	;

xmlTableOrdinalityColumnDefinition
	: (columnName FOR ORDINALITY)
	;

xmlnamespacesDeclaration
	: (
	xmlnamespacesFunctionSpecification
	(COMMA xmlnamespacesFunctionSpecification)*
	)
	;

xmlnamespacesFunctionSpecification
	: (
	XMLNAMESPACES
	LPAREN
	xmlnamespacesFunctionArguments
	(COMMA xmlnamespacesFunctionArguments)*
	RPAREN
	)
	;

xmlnamespacesFunctionArguments
	: (
	((namespaceUri AS namespacePrefix)
	| (DEFAULT namespaceUri)
	| (NO DEFAULT))
	)
	;

namespaceUri
	: NONNUMERICLITERAL
	;

namespacePrefix
	: NONNUMERICLITERAL
	;

timeZoneSpecificExpression
	: timeZoneExpressionSubset
	((AT LOCAL) | (AT TIME ZONE timeZoneExpressionSubset))
	;

timeZoneExpressionSubset
	: (
	functionInvocation
	| literal
	| columnName
	| hostVariable
	| specialRegister
	| scalarFullSelect
	| caseExpression
	| castSpecification
	)
	;

caseExpression
	: CASE
	(searchedWhenClause+ | simpleWhenClause)
	((ELSE NULL) | (ELSE resultExpression))?
	END
	;

resultExpression
	: expression
	;

searchedWhenClause
	: (
	WHEN searchCondition THEN (resultExpression | NULL)
	)
	;

simpleWhenClause
	: (
	expression
	(WHEN expression THEN (resultExpression | NULL))+
	)
	;

searchCondition
	: NOT?
	((predicate (SELECTIVITY NUMERICLITERAL)?) | (LPAREN searchCondition RPAREN))
	((AND | OR) NOT? (predicate | (LPAREN searchCondition RPAREN)))*
	;

checkCondition
	: (searchCondition)
	;

predicate
	: basicPredicate
	| quantifiedPredicate
	| arrayExistsPredicate
	| betweenPredicate
	| distinctPredicate
	| existsPredicate
	| inPredicate
	| likePredicate
	| nullPredicate
	| xmlExistsPredicate
	;

basicPredicate
	: ((expression comparisonOperator expression)
	| (rowValueExpression comparisonOperator rowValueExpression))
	;

rowValueExpression
	: LPAREN expression
	(COMMA expression)*
	RPAREN
	;

quantifiedPredicate
	: ((expression comparisonOperator (SOME | ANY | ALL) LPAREN fullSelect RPAREN)
	| (rowValueExpression EQ (SOME | ANY) LPAREN fullSelect RPAREN)
	| (rowValueExpression NE ALL LPAREN fullSelect RPAREN))
	;

arrayExistsPredicate
	: ARRAY_EXISTS
	LPAREN
	arrayExpression
	INTEGERLITERAL
	RPAREN
	;

betweenPredicate
	: expression NOT? BETWEEN expression AND expression
	;

distinctPredicate
	: expression IS NOT? DISTINCT FROM expression
	;

existsPredicate
	: EXISTS LPAREN fullSelect RPAREN
	;

inPredicate
	: expression NOT? IN (
	(LPAREN fullSelect RPAREN)
	| (LPAREN expression (COMMA expression)* RPAREN)
	)
	;

likePredicate
	: expression NOT? LIKE expression (ESCAPE expression)?
	;

nullPredicate
	: expression ((IS NOT? NULL) | ISNULL | NOTNULL)
	;

xmlExistsPredicate
	: XMLEXISTS
	LPAREN
	NONNUMERICLITERAL
	(PASSING (BY REF)? expression (COMMA expression)*)?
	RPAREN
	;

arrayExpression
	: variable
	| castSpecification
	;

castSpecification
	: CAST
	LPAREN
	(expression | NULL | parameterMarker)
	AS
	castDataType
	RPAREN
	;

parameterMarker
	: QUESTIONMARK
	;

castDataType
	: (
	castBuiltInType
	| distinctTypeName
	| arrayType
	)
	;

castBuiltInType
	: (
	SMALLINT
	| INTEGER
	| INT
	| BIGINT
	| ((DECIMAL | DEC | NUMERIC) (integerInParens | (LPAREN RPAREN)))
	| (DECFLOAT (integerInParens | (LPAREN RPAREN)))
	| (FLOAT (integerInParens | (LPAREN RPAREN)))
	| REAL
	| (DOUBLE PRECISION?)
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) (length | (LPAREN RPAREN))? ccsidQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) (length | (LPAREN RPAREN))? ccsidQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidQualifier?)
	| (BINARY (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY VARYING?) | VARBINARY) (integerInParens | (LPAREN RPAREN))?)
	| (((BINARY LARGE OBJECT) | BLOB) (LPAREN (INTEGERLITERAL SQLIDENTIFIER) RPAREN)?)
	| DATE
	| TIME
	| (TIMESTAMP integerInParens? ((WITH | WITHOUT) TIME ZONE)?)
	| ROWID
	| XML
	)
	;

integerInParens
	: (LPAREN INTEGERLITERAL (COMMA INTEGERLITERAL)? RPAREN)
	;

/*
It turns out the lengthQualifier of K or M or G gets lexed
as being part of the INTEGERLITERAL and becomes an SQLIDENTIFIER.
*/
length
	: (
	LPAREN
	(INTEGERLITERAL | SQLIDENTIFIER)
	(CODEUNITS16 | CODEUNITS32 | OCTETS)?
	RPAREN
	)
	;

ccsidQualifier
	: (
	CCSID
	(((ASCII | EBCDIC | UNICODE) forDataQualifier?) | INTEGERLITERAL)
	)
	;

forDataQualifier
	: (FOR (SBCS | MIXED | BIT) DATA)
	;

distinctTypeName
	: (schemaName DOT)? identifier
	;

arrayType
	: identifier
	;

literal
	: NUMERICLITERAL
	| NONNUMERICLITERAL
	| INTEGERLITERAL
	;

ccsidValue
	: INTEGERLITERAL
	;

columnName
	: (((correlationName | tableName) DOT)? (identifier1 | NONNUMERICLITERAL))
	;

sourceColumnName
	: columnName
	;

targetColumnName
	: columnName
	;

newColumnName
	: identifier
	;

beginColumnName
	: identifier
	;

endColumnName
	: identifier
	;

correlationName
	: identifier
	;

locationName
//	: (identifier | NUMERICLITERAL | INTEGERLITERAL) (DOT? (identifier | NUMERICLITERAL | INTEGERLITERAL))*
	: SQLIDENTIFIER
	;

schemaName
	: identifier1
	;

tableName
	: (((locationName DOT schemaName DOT) | (schemaName DOT))? identifier)
	;

alterTableName
	: (((locationName DOT schemaName DOT) | (schemaName DOT))? identifier)
	;

auxTableName
	: (((locationName DOT schemaName DOT) | (schemaName DOT))? identifier)
	;

historyTableName
	: tableName
	;

cloneTableName
	: tableName
	;

archiveTableName
	: tableName
	;

viewName
	: ((locationName DOT schemaName DOT) | (schemaName DOT))? identifier correlationName?
	;

programName
	: identifier
	;

packageName
	: identifier
	;

planName
	: identifier
	;

typeName
	: ((schemaName DOT)? identifier)
	;

variableName
	: ((schemaName DOT)? identifier)
	;

arrayTypeName
	: ((schemaName DOT)? identifier)
	;

jarName
	: ((schemaName DOT)? identifier)
	;

savepointName
	: identifier
	;

aliasName
	: identifier
	;

constraintName
	: identifier
	;

routineVersionID
	: (identifier | NUMERICLITERAL | INTEGERLITERAL) (DOT? (identifier | NUMERICLITERAL | INTEGERLITERAL))*
	;

versionID
	: (identifier | NUMERICLITERAL | INTEGERLITERAL) (DOT? (identifier | NUMERICLITERAL | INTEGERLITERAL))*
	;

indexName
	: (schemaName DOT)? identifier
	;

maskName
	: (schemaName DOT)? identifier
	;

permissionName
	: (schemaName DOT)? identifier
	;

procedureName
	: ((locationName DOT schemaName DOT) | (schemaName DOT))? identifier
	;

sequenceName
	: (schemaName DOT)? identifier
	;

memberName
	: identifier
	;

databaseName
	: identifier
	;

tablespaceName
	: identifier
	;

acceleratorName
	: identifier
	;

catalogName
	: identifier
	;

triggerName
	: identifier
	;

contextName
	: identifier
	;

authorizationName
	: identifier
	;

profileName
	: identifier
	;

roleName
	: identifier
	;

seclabelName
	: identifier
	;

parameterName
	: identifier
	;

addressValue
	: NONNUMERICLITERAL
	;

jobnameValue
	: NONNUMERICLITERAL
	;

servauthValue
	: NONNUMERICLITERAL
	;

encryptionValue
	: NONNUMERICLITERAL
	;

bpName
	: identifier
	;

stogroupName
	: identifier
	;

dcName
	: identifier
	;

mcName
	: identifier
	;

scName
	: identifier
	;

volumeID
	: identifier
	;

keyLabelName
	: (identifier | NONNUMERICLITERAL)
	;

functionName
	: (schemaName DOT)? identifier
	;

specificName
	: (schemaName DOT)? identifier
	;

hostLabel
	: identifier
	;

hostVariable
	: COLON (hostStructure DOT)? hostIdentifier (INDICATOR? COLON (nullIndicatorStructure DOT)? nullIndicator)?
	;

hostIdentifier
	: identifier
	;

hostStructure
	: identifier
	;

nullIndicator
	: identifier
	;

nullIndicatorStructure
	: identifier
	;

globalVariableName
	: ((schemaName DOT)? identifier1)
	;

sqlParameterName
	: ((schemaName DOT)? identifier1)
	;

sqlVariableName
	: ((schemaName DOT)? identifier1)
	;

transitionVariableName
	: columnName
	;

synonym
	: identifier
	;

/*
Trigger variables, global variables, SQL variables, all
these conform to the pattern (schemaName DOT)? identifier.
*/
variable
	: ((schemaName DOT)? identifier)
	| hostVariable
	;

intoClause
	: INTO
	(variable | arrayElementSpecification)
	(COMMA variable)*
	;

correlationClause
	: AS?
	correlationName
	(LPAREN
	newColumnName
	(COMMA newColumnName)*
	RPAREN)?
	;

/*	
fromClause
	: FROM
	tableName correlationClause?
	(COMMA tableName correlationClause?)*
	;
*/

fromClause
	: (
	FROM
	((LPAREN* tableReference RPAREN*) | collectionDerivedTable)
	(COMMA ((LPAREN* tableReference RPAREN*) | collectionDerivedTable))*
	)
	;

tableReference
	: (
	singleTableReference
	| nestedTableExpression
	| dataChangeTableReference
	| tableFunctionReference
	| tableLocatorReference
	| xmltableExpression
	| collectionDerivedTable
//	| joinedTable
/*
The following is brought to you by the ANTLR 4.9.2 message
"The following sets of rules are mutually left-recursive [tableReference, joinedTable]"
*/

	| ((singleTableReference 
		| nestedTableExpression 
		| tableFunctionReference 
		| tableLocatorReference 
		| xmltableExpression 
		| collectionDerivedTable 
		| (LPAREN+ tableReference RPAREN+)
		| ((singleTableReference 
			| nestedTableExpression 
			| tableFunctionReference 
			| tableLocatorReference 
			| xmltableExpression 
			| (LPAREN+ tableReference RPAREN+)
			| collectionDerivedTable)
				(INNER | ((LEFT | RIGHT | FULL) OUTER?)) JOIN
						tableReference ON joinCondition))
		((INNER | ((LEFT | RIGHT | FULL) OUTER?)) JOIN
					tableReference ON joinCondition)+)
	| ((singleTableReference 
		| nestedTableExpression 
		| tableFunctionReference 
		| tableLocatorReference 
		| xmltableExpression 
		| collectionDerivedTable 
		| (LPAREN+ tableReference RPAREN+)
		| ((singleTableReference 
			| nestedTableExpression 
			| tableFunctionReference 
			| tableLocatorReference 
			| xmltableExpression 
			| (LPAREN+ tableReference RPAREN+)
			| collectionDerivedTable)
				(INNER | ((LEFT | RIGHT | FULL) OUTER?)) JOIN
					tableReference ON joinCondition)) CROSS JOIN tableReference)
	| (LPAREN+ tableReference RPAREN+)
	)
	;

singleTableReference
	: (tableName AS? correlationName? periodSpecification* correlationClause?)
	;

periodSpecification
	: (
	FOR (SYSTEM_TIME | BUSINESS_TIME) 
	((AS OF expression) | (FROM expression TO expression) | (BETWEEN expression AND expression))
	)
	;

periodClause
	: (
	FOR PORTION OF BUSINESS_TIME 
	((FROM expression TO expression) | (BETWEEN expression AND expression))
	)
	;

nestedTableExpression
	: (TABLE? LPAREN fullSelect RPAREN correlationClause?)
	;

/**/
dataChangeTableReference
	: (
	(FINAL TABLE LPAREN insertStatement RPAREN correlationClause?)
	| ((FINAL | OLD) TABLE searchedUpdate)
	| (OLD TABLE searchedDelete)
	| (FINAL TABLE mergeStatement)
	)
	;

/**/

tableFunctionReference
	: (
	TABLE LPAREN 
	(schemaName DOT)?
	(scalarFunction | aggregateFunction | regressionFunction | tableFunction | identifier)
	LPAREN
	((expression | (TABLE tableName)) (COMMA (expression | (TABLE tableName)))*)?
	RPAREN
	tableUdfCardinalityClause?
	RPAREN
	(correlationClause | typedCorrelationClause)?
	)
	;

tableUdfCardinalityClause
	: (
	CARDINALITY MULTIPLIER? (INTEGERLITERAL | NUMERICLITERAL)
	)
	;

typedCorrelationClause
	: (
	AS? correlationName LPAREN columnName dataType (COMMA columnName dataType)* RPAREN
	)
	;

tableLocatorReference
	: (
	TABLE
	LPAREN
	identifier
	LIKE
	tableName
	RPAREN
	correlationName?
	)
	;

xmltableExpression
	: (xmltableFunctionSpecification correlationClause?)
	;

/*
correlationClause
	: (AS? correlationName (LPAREN columnName (COMMA columnName)* RPAREN)?)
	;
*/

collectionDerivedTable
	: (
	UNNEST
	LPAREN
	(ordinaryArrayExpression | associativeArrayExpression)
	(COMMA (ordinaryArrayExpression | associativeArrayExpression))*
	RPAREN
	(WITH ORDINALITY)?
	correlationClause?
	)
	;

/* moved to the interior of tableReference due to mutual left-recursion error
joinedTable
	: (
	(tableReference
	(INNER | ((LEFT | RIGHT | FULL) OUTER?))
	JOIN
	tableReference ON joinCondition)
	| (tableReference CROSS JOIN tableReference)
	| (LPAREN joinedTable RPAREN)
	)
	;
*/

joinCondition
	: (
	searchCondition
	| (fullJoinExpression EQ fullJoinExpression)
	)
	;

fullJoinExpression
	: (
	(columnName
	| castFunction
	| (COALESCE LPAREN (columnName | castFunction) (COMMA (columnName | castFunction))* RPAREN))
	)
	;

castFunction
	: (castSpecification)
	;

ordinaryArrayExpression
	: (expression)
	;

associativeArrayExpression
	: (expression)
	;

comparison
	: columnName comparisonOperator (columnName | literal)
	;

whereClause
	: WHERE searchCondition
	;

groupByClause
	: GROUP BY
	(groupingExpression | groupingSets | superGroups)
	;

havingClause
	: HAVING searchCondition
	;

groupingExpression
	: (expression (COMMA expression)*)
	;

groupingSets
	: GROUPING SETS groupingSetsGroup
	;

groupingSetsGroup
	: LPAREN 
	(groupingSetsGroup | groupingExpression | superGroups) 
	(COMMA (groupingSetsGroup | groupingExpression | superGroups))* 
	RPAREN
	;

superGroups
	: (
	((ROLLUP | CUBE) LPAREN groupingExpression RPAREN)
	| (LPAREN RPAREN)
	)
	;

selectColumns
	: (
	(expression ((operator expression) | INTEGERLITERAL)* (AS? (newColumnName | NONNUMERICLITERAL))?)
	| (tableName DOT SPLAT)
	| unpackedRow
	)
	;

unpackedRow
	: (
	UNPACK LPAREN expression RPAREN DOT SPLAT AS 
	LPAREN 
	columnName dataType (COMMA columnName dataType)* 
	RPAREN
	)
	;

selectClause
	: (
	SELECT
	(ALL | DISTINCT)?
	(SPLAT | (selectColumns (COMMA selectColumns)*))
	)
	;

subSelect
	: (
	selectClause
	fromClause
	whereClause?
	groupByClause?
	havingClause?
	orderByClause?
	offsetClause?
	fetchClause?
	)
	;

selectIntoStatement
	: (
	(WITH commonTableExpression (COMMA commonTableExpression)*)?
	selectClause
	intoClause
	fromClause
	whereClause?
	groupByClause?
	havingClause?
	orderByClause?
	offsetClause?
	fetchClause?
	(isolationClause | skipLockedDataClause)?
	querynoClause?
	)
	;

selectStatement
	: (
	(WITH commonTableExpression (COMMA commonTableExpression)*)?
	fullSelect
	(
	updateClause
	| readOnlyClause
	| optimizeClause
	| isolationClause 
	| skipLockedDataClause
	| querynoClause
	)*
	)
	;

commonTableExpression
	: tableName 
	LPAREN
	columnName
	(COMMA columnName)*
	RPAREN
	AS LPAREN fullSelect RPAREN
	;

updateClause
	: (FOR UPDATE (OF columnName (COMMA columnName)*)?)
	;

readOnlyClause
	: (FOR READ ONLY)
	;

optimizeClause
	: OPTIMIZE FOR INTEGERLITERAL (ROW | ROWS)
	;

isolationClause
	: WITH 
	(
	(RR lockClause?)
	| (RS lockClause?)
	| CS
	| UR
	)
	;

lockClause
	: (USE AND KEEP (EXCLUSIVE | UPDATE | SHARE) LOCKS)
	;

skipLockedDataClause
	: (SKIP_ LOCKED DATA)
	;

querynoClause
	: (QUERYNO INTEGERLITERAL)
	;

scalarFullSelect
	: LPAREN
	fullSelect
	RPAREN
	;

fullSelect
	: ((LPAREN fullSelect RPAREN) | subSelect | valuesClause)
	((UNION | EXCEPT | INTERSECT) (DISTINCT | ALL)? (subSelect | (LPAREN fullSelect RPAREN)))*
	orderByClause?
	offsetClause?
	fetchClause?
	;

valuesClause
	: VALUES
	(sequenceReference
	| (LPAREN sequenceReference (COMMA sequenceReference)* RPAREN))
	;

orderByClause
	: ORDER BY 
	(
	(sortKey (ASC | DESC)? (COMMA sortKey (ASC | DESC)?)*)
	| (INPUT SEQUENCE)
	| (ORDER OF tableName)
	)
	;

sortKey
	: (columnName | INTEGERLITERAL | expression)
	;

offsetClause
	: OFFSET INTEGERLITERAL (ROW | ROWS)
	;

fetchClause
	: FETCH (FIRST | NEXT) INTEGERLITERAL? (ROW | ROWS) ONLY
	;

identifier
	: SQLIDENTIFIER
	| sqlKeyword
	| specialRegister
	| scalarFunction
	| aggregateFunction
	| regressionFunction
	| tableFunction
	;

identifier1
	: SQLIDENTIFIER
	| sqlKeyword
	| scalarFunction
	| aggregateFunction
	| regressionFunction
	| tableFunction
	;

sqlKeyword
	: (
	ADD
	| AFTER
	| ALL
	| ALLOCATE
	| ALLOW
	| ALTERAND
	| ANY
	| ARRAY
	| ARRAY_EXISTS
	| AS
	| ASENSITIVE
	| ASSOCIATE
	| ASUTIME
	| AT
	| AUDIT
	| AUX
	| AUXILIARY
	| BEFORE
	| BEGIN
	| BETWEEN
	| BUFFERPOOL
	| BY
	| CALL
	| CAPTURE
	| CASCADED
	| CASE
	| CAST
	| CCSID
	| CHAR
	| CHARACTER
	| CHECK
	| CLONE
	| CLOSE
	| CLUSTER
	| COLLECTION
	| COLLID
	| COLUMN
	| COMMENT
	| COMMIT
	| CONCAT
	| CONDITION
	| CONNECT
	| CONNECTION
	| CONSTRAINT
	| CONTAINS
	| CONTENT
	| CONTINUE
	| CREATE
	| CUBE
	| CURRENT
	| CURRENT_DATE
//	| CURRENT_LC_CTYPE
	| CURRENT_PATH
	| CURRENT_SCHEMA
	| CURRENT_SERVER
	| CURRENT_TIME
	| CURRENT_TIMESTAMP
	| CURRENT_TIME_ZONE
	| CURRVAL
	| CURSOR
	| DATA
	| DATABASE
	| DAY
	| DAYS
	| DBINFO
	| DECLARE
	| DEFAULT
	| DELETE
	| DESCRIPTOR
	| DETERMINISTIC
	| DISABLE
	| DISALLOW
	| DISTINCT
	| DO
	| DOCUMENT
	| DOUBLE
	| DROP
	| DSSIZE
	| DYNAMIC
	| EDITPROC
	| ELSE
	| ELSEIF
	| ENCODING
	| ENCRYPTION
	| END
	| END_EXEC
	| ENDING
	| ERASE
	| ESCAPE
	| EXCEPT
	| EXCEPTION
	| EXEC_SQL
	| EXECUTE
	| EXISTS
	| EXIT
	| EXPLAIN
	| EXTERNAL
	| FENCED
	| FETCH
	| FIELDPROC
	| FINAL
	| FIRST
	| FOR
	| FREE
	| FROM
	| FULL
	| FUNCTION
	| GENERATED
	| GET
	| GLOBAL
	| GO
	| GOTO
	| GRANT
	| GROUP
	| HANDLER
	| HAVING
	| HOLD
	| HOUR
	| HOURS
	| IF
	| IMMEDIATE
	| IN
	| INCLUSIVE
	| INDEX
	| INHERIT
	| INNER
	| INOUT
	| INSENSITIVE
	| INSERT
	| INTERSECT
	| INTO
	| IS
	| ISOBID
	| ITERATE
	| JAR
	| JOIN
	| KEEP
	| KEY
	| LABEL
	| LANGUAGE
	| LAST
	| LC_CTYPE
	| LEAVE
	| LEFT
	| LIKE
	| LIMIT
	| LOCAL
	| LOCALE
	| LOCATOR
	| LOCATORS
	| LOCK
	| LOCKMAX
	| LOCKSIZE
	| LONG
	| LOOP
	| MAINTAINED
	| MATERIALIZED
	| MICROSECOND
	| MICROSECONDS
	| MINUTE
	| MINUTES
	| MODIFIES
	| MONTH
	| MONTHS
	| NEXT
	| NEXTVAL
	| NO
	| NONE
	| NOT
	| NULL
	| NULLS
	| NUMPARTS
	| OBID
	| OF
	| OFFSET
	| OLD
	| ON
	| OPEN
	| OPTIMIZATION
	| OPTIMIZE
	| OR
	| ORDER
	| ORGANIZATION
	| OUT
	| OUTER
	| PACKAGE
	| PADDED
	| PARAMETER
	| PART
	| PARTITION
	| PARTITIONED
	| PARTITIONING
	| PATH
	| PERIOD
	| PIECESIZE
	| PLAN
	| PRECISION
	| PREPARE
	| PREVVAL
	| PRIOR
	| PRIQTY
	| PRIVILEGES
	| PROCEDURE
	| PROGRAM
	| PSID
	| PUBLIC
	| QUERY
	| QUERYNO
	| READS
	| REFERENCES
	| REFRESH
	| RELEASE
	| RENAME
	| REPEAT
	| RESIGNAL
	| RESTRICT
	| RESULT
	| RESULT_SET_LOCATOR
	| RETURN
	| RETURNS
	| REVOKE
	| RIGHT
	| ROLE
	| ROLLBACK
	| ROLLUP
	| ROUND_CEILING
	| ROUND_DOWN
	| ROUND_FLOOR
	| ROUND_HALF_DOWN
	| ROUND_HALF_EVEN
	| ROUND_HALF_UP
	| ROUND_UP
	| ROW
	| ROWSET
	| RUN
	| SAVEPOINT
	| SCHEMA
	| SCRATCHPAD
	| SECOND
	| SECONDS
	| SECQTY
	| SECURITY
	| SELECT
	| SENSITIVE
	| SEQUENCE
	| SESSION_USER
	| SET
	| SIGNAL
	| SIMPLE
	| SOME
	| SOURCE
	| SPECIFIC
	| STANDARD
	| STATEMENT
	| STATIC
	| STAY
	| STOGROUP
	| STORES
	| STYLE
	| SUMMARY
	| SYNONYM
	| SYSDATE
	| SYSTEM
	| SYSTIMESTAMP
	| TABLE
	| TABLESPACE
	| THEN
	| TO
	| TRIGGER
	| TRUNCATE
	| TYPE
	| UNDO
	| UNION
	| UNIQUE
	| UNTIL
	| UPDATE
	| USER
	| USING
	| VALIDPROC
	| VALUE
	| VALUES
	| VARIABLE
	| VARIANT
	| VCAT
	| VERSIONING
	| VIEW
	| VOLATILE
	| VOLUMES
	| WHEN
	| WHENEVER
	| WHERE
	| WHILE
	| WITH
	| WLM
	| XMLCAST
	| XMLEXISTS
	| XMLNAMESPACES
	| YEAR
	| YEARS
	| ZONE
	| AND
	| ARRAY_AGG
	| ASC
	| AVG
	| BIT
	| CHANGE
	| CODEUNITS16
	| CODEUNITS32
	| CORR
	| CORRELATION
	| COVAR
	| COVARIANCE
	| COVARIANCE_SAMP
	| COVAR_POP
	| COVAR_SAMP
	| CS
	| CUME_DIST
	| DENSE_RANK
	| DESC
	| EBCDIC
	| EXCLUSIVE
	| FIRST_VALUE
	| FOLLOWING
	| GROUPING
	| IGNORE
	| INDICATOR
	| INPUT
	| ISNULL
	| LAG
	| LARGE
	| LAST_VALUE
	| LEAD
	| LISTAGG
	| LOCKED
	| LOCKS
	| MEDIAN
	| MINUTES
	| MIXED
	| NOTNULL
	| NTH_VALUE
	| NTILE
	| NUMERIC
	| OBJECT
	| OCTETS
	| ONLY
	| OVER
	| PASSING
	| PERCENTILE_CONT
	| PERCENTILE_DISC
	| PERCENT_RANK
	| PRECEDING
	| PREVIOUS
	| RANGE
	| RANK
	| RATIO_TO_REPORT
	| READ
	| REF
	| REGR_AVGX
	| REGR_AVGY
	| REGR_COUNT
	| REGR_ICPT
	| REGR_INTERCEPT
	| REGR_R2
	| REGR_SLOPE
	| REGR_SXX
	| REGR_SXY
	| REGR_SYY
	| RESPECT
	| ROW_NUMBER
	| ROWS
	| RR
	| RS
	| SBCS
	| SELECTIVITY
	| SETS
	| SHARE
	| SKIP_
	| STDDEV
	| STDDEV_POP
	| STDDEV_SAMP
	| SUM
	| TOKEN
	| UNBOUNDED
	| UNPACK
	| UR
	| USE
	| VAR
	| VARIANCE
	| VARIANCE_SAMP
	| VAR_POP
	| VAR_SAMP
	| VARYING
	| WITHOUT
	| XML
	| XMLAGG
	| COLUMNS
	| SQLID
	| ORDINALITY
	| SYSTEM_TIME
	| BUSINESS_TIME
	| MULTIPLIER
	| UNNEST
	| CROSS
	| CALLER
	| CLIENT
	| POSITIONING
	| SCROLL
	| ALTER
	| INDEXBP
	| ACTION
	| ASSEMBLE
	| C_
	| CALLED
	| COBOL
	| DB2
	| DEFINER
	| DISPATCH
	| ENVIRONMENT
	| FAILURE
	| FAILURES
	| JAVA
	| MAIN
	| NAME
	| OPTIONS
	| PARALLEL
	| PLI
	| REGISTERS
	| RESIDENT
	| SECURED
	| SPECIAL
	| SQL
	| STOP
	| SUB
	| YES
	| APPLICATION
	| CHANGED
	| COMPATIBILITY
	| COMPRESS
	| COPY
	| FREEPAGE
	| GBPCACHE
	| INCLUDE
	| MAXVALUE
	| MINVALUE
	| PCTFREE
	| REGENERATE
	| MASK
	| ENABLE
	| PERMISSION
	| ATOMIC
	| SQLEXCEPTION
	| MERGE
	| MATCHED
	| SQLSTATE
	| MESSAGE_TEXT
	| OVERRIDING
	| PORTION
	| DB2SQL
	| DEBUG
	| GENERAL
	| MODE_
	| REXX
	| CACHE
	| CYCLE
	| INCREMENT
	| RESTART
	| DATACLAS
	| MGMTCLAS
	| REMOVE
	| STORCLAS
	| ACCESS
	| ACTIVATE
	| ALWAYS
	| APPEND
	| ARCHIVE
	| BUSINESS
	| CASCADE
	| CHANGES
	| CONTROL
	| DEACTIVATE
	| DEFERRED
	| EACH
	| ENFORCED
	| EXTRA
	| FOREIGN
	| HIDDEN_
	| HISTORY
	| ID
	| IDENTITY
	| IMPLICITLY
	| INITIALLY
	| INLINE
	| OPERATION
	| ORGANIZE
	| OVERLAPS
	| PACKAGE_NAME
	| PACKAGE_SCHEMA
	| PACKAGE_VERSION
	| PRIMARY
	| RESET
	| ROTATE
	| START
	| SYSIBM
	| TRANSACTION
	| XMLSCHEMA
	| ELEMENT
	| URL
	| NAMESPACE
	| LOCATION
	| SYSXSR
	| ALGORITHM
	| FIXEDLENGTH
	| HUFFMAN
	| LOB
	| LOG
	| LOGGED
	| MAXPARTITIONS
	| MAXROWS
	| MEMBER
	| MOVE
	| PAGE
	| PAGENUM
	| PENDING
	| RELATIVE
	| SEGSIZE
	| TRACKMOD
	| ADDRESS
	| ATTRIBUTES
	| AUTHENTICATION
	| AUTHID
	| CONTEXT
	| JOBNAME
	| OWNER
	| PROFILE
	| QUALIFIER
	| SERVAUTH
	| TRUSTED
	| SECTION
	| ACTIVE
	| VERSION
	| ALIAS
	| WORK
	| WORKFILE
	| SYSDEFLT
	| NULTERM
	| STRUCTURE
	| GENERIC
	| TEMPORARY
	| DEFER
	| DEFINE
	| EXCLUDE
	| GENERATE
	| KEYS
	| XMLPATTERN
	| SIZE
	| EVERY
	| ABSOLUTE
	| ACCELERATOR
	| EXCLUDING
	| INCLUDING
	| DEFAULTS
	| MODIFIERS
	| INSTEAD
	| NEW
	| NEW_TABLE
	| OLD_TABLE
	| REFERENCING
	| BASED
	| UPON
    | OPTION
	| PRESERVE
	| BOTH
	| DESCRIBE
	| LABELS
	| NAMES
	| OUTPUT
	| EXCHANGE
	| STABILIZED
	| STMTCACHE
	| STMTID
	| STMTTOKEN
	| STARTING
	| CATALOG_NAME
	| CONDITION_NUMBER
	| CURSOR_NAME
	| DB2_AUTHENTICATION_TYPE
	| DB2_AUTHORIZATION_ID
	| DB2_CONNECTION_STATE
	| DB2_CONNECTION_STATUS
	| DB2_ENCRYPTION_TYPE
	| DB2_ERROR_CODE1
	| DB2_ERROR_CODE2
	| DB2_ERROR_CODE3
	| DB2_ERROR_CODE4
	| DB2_GET_DIAGNOSTICS_DIAGNOSTICS
	| DB2_INTERNAL_ERROR_POINTER
	| DB2_LAST_ROW
	| DB2_LINE_NUMBER
	| DB2_MESSAGE_ID
	| DB2_MODULE_DETECTING_ERROR
	| DB2_NUMBER_PARAMETER_MARKERS
	| DB2_NUMBER_RESULT_SETS
	| DB2_NUMBER_ROWS
	| DB2_ORDINAL_TOKEN_
	| DB2_PRODUCT_ID
	| DB2_REASON_CODE
	| DB2_RETURNED_SQLCODE
	| DB2_RETURN_STATUS
	| DB2_ROW_NUMBER
	| DB2_SERVER_CLASS_NAME
	| DB2_SQL_ATTR_CURSOR_HOLD
	| DB2_SQL_ATTR_CURSOR_ROWSET
	| DB2_SQL_ATTR_CURSOR_SCROLLABLE
	| DB2_SQL_ATTR_CURSOR_SENSITIVITY
	| DB2_SQL_ATTR_CURSOR_TYPE
	| DB2_SQLERRD1
	| DB2_SQLERRD2
	| DB2_SQLERRD3
	| DB2_SQLERRD4
	| DB2_SQLERRD5
	| DB2_SQLERRD6
	| DB2_SQLERRD_SET
	| DB2_SQL_NESTING_LEVEL
	| DB2_TOKEN_COUNT
	| DIAGNOSTICS
	| MORE_
	| NUMBER
	| RETURNED_SQLSTATE
	| ROW_COUNT
	| SERVER_NAME
	| STACKED
	| CREATETAB
	| CREATETS
	| DBADM
	| DBCTRL
	| DBMAINT
	| DISPLAYDB
	| IMAGCOPY
	| LOAD
	| PACKADM
	| RECOVERDB
	| REORG
	| REPAIR
	| STARTDB
	| STATS
	| STOPDB
	| BIND
	| ALTERIN
	| CREATEIN
	| DROPIN
	| USAGE
	| ACCESSCTRL
	| BINDADD
	| BINDAGENT
	| BSDS
	| CREATEALIAS
	| CREATEDBA
	| CREATEDBC
	| CREATE_SECURE_OBJECT
	| CREATESG
	| CREATETMTAB
	| DATAACCESS
	| DEBUGSESSION
	| DISPLAY
	| MONITOR1
	| MONITOR2
	| RECOVER
	| SQLADM
	| STOPALL
	| STOSPACE
	| SYSADM
	| SYSCTRL
	| SYSOPR
	| TRACE
	| UNLOAD
	| WRITE
	| BUFFERPOOLS
	| DEPENDENT
	| RETAIN
	| CURSORS
	| PASSWORD
	| HINT
	| TIMEZONE
	| TRANSFER
	| OWNERSHIP
	| REUSE
	| STORAGE
	| TRIGGERS
	| FOUND
	| SQLERROR
	| SQLWARNING
	| WITHIN
	| EMPTY
	| XMLBINARY
	| BASE64
	| XMLDECLARATION
	| REFERENCE
	| RETURNING
	)
	;


