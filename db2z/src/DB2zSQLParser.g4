/*
Copyright (C) 2021 Craig Schneiderwent.  All rights reserved.  I accept
no liability for damages of any kind resulting from the use of this 
software.  Use at your own risk.

This software may be modified and distributed under the terms
of the MIT license. See the LICENSE file for details.

The ALTER FUNCTION variations (external), (inlined SQL scalar), and
(SQL table) are all variations on each other and are contained in
the alterFunctionStatement rule.

The rule signalStatement is not a full implementation of the syntax
of the SIGNAL statement, but a subset that is possible to embed in
an application program.

This grammar does not include SQL/PL or the following SQL statements.

ALTER FUNCTION (compiled SQL scalar)

*/


parser grammar DB2zSQLParser;

options {tokenVocab=DB2zSQLLexer;}

startRule : sqlStatement* | EOF ;

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
	| declareCursorStatement
	| declareTableStatement
	| declareStatementStatement
	| deleteStatement
	| insertStatement
	| mergeStatement
	| updateStatement
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

declareCursorStatement
	: (
	DECLARE cursorName
	((NO SCROLL) | ((ASENSITIVE | INSENSITIVE | (SENSITIVE (DYNAMIC | STATIC))) SCROLL))?
	CURSOR (holdability | returnability | rowsetPositioning)* FOR (selectStatement | statementName)
	)
	;

cursorName
	: identifier
	;

statementName
	: identifier
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

declareTableStatement
	: (
	DECLARE tableName TABLE LPAREN
	(columnName dataType notNullPhrase?)
	(COMMA columnName dataType notNullPhrase?)*
	RPAREN
	)
	;

notNullPhrase
	: ((NOT NULL) | (NOT NULL WITH DEFAULT))
	;

declareStatementStatement
	: (DECLARE statementName (COMMA statementName)* STATEMENT)
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
	((BUFFERPOOL bpName)
	| (INDEXBP bpName)
	| (STOGROUP stogroupName)
	| (CCSID ccsidValue))+
	)
	;

alterFunctionStatement
	: (
	ALTER 
		((FUNCTION functionName (LPAREN parameterType (COMMA parameterType)* RPAREN)?) 
		| (SPECIFIC FUNCTION specificName))
	RESTRICT?
	optionList+
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

searchedDelete
	: (
	DELETE FROM tableName periodClause? correlationName? includeColumns?
	(SET assignmentClause)? (WHERE searchCondition) fetchClause?
	(isolationClause | skipLockedDataClause)* (QUERYNO INTEGERLITERAL)?
	)
	;

positionedDelete
	: (
	DELETE FROM tableName correlationName? WHERE CURRENT OF cursorName
	(FOR ROW (hostVariable | INTEGERLITERAL) OF ROWSET)?
	)
	;

deleteStatement
	: (searchedDelete | positionedDelete)
	;

insertStatement
	: (
	INSERT INTO tableName (LPAREN columnName (COMMA columnName)* RPAREN)?
	includeColumns?
	(OVERRIDING USER VALUE)?
	((VALUES (valuesList1 |
		(LPAREN valuesList1 (COMMA valuesList1)* RPAREN)))
	| ((WITH commonTableExpression (COMMA commonTableExpression)*)?
		fullSelect isolationClause? (QUERYNO INTEGERLITERAL)?)
	| multipleRowInsert)
	)
	;

mergeStatement
	: (
	MERGE INTO tableName correlationClause? includeColumns?
	USING ((LPAREN* tableReference RPAREN*) | sourceValues) ON searchCondition
	(WHEN matchingCondition THEN (modificationOperation | signalStatement))+ (ELSE IGNORE)?
	(NOT ATOMIC CONTINUE ON SQLEXCEPTION)?
	(QUERYNO INTEGERLITERAL)?
	)
	;

searchedUpdate
	: (
	UPDATE tableName periodClause? correlationName? includeColumns?
	SET assignmentClause (WHERE searchCondition)? 
	(isolationClause | skipLockedDataClause)* (QUERYNO INTEGERLITERAL)?
	)
	;

positionedUpdate
	: (
	UPDATE tableName correlationName? 
	SET assignmentClause
	WHERE CURRENT OF cursorName
	(FOR ROW (hostVariable | INTEGERLITERAL) OF ROWSET)?
	)
	;

updateStatement
	: (searchedUpdate | positionedUpdate)
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
		LPAREN (valuesList1 (COMMA valuesList1)*) | fullSelect)
		RPAREN
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

signalStatement
	: (
	SIGNAL SQLSTATE VALUE? NONNUMERICLITERAL signalInformation?
	)
	;

signalInformation
	: (
	SET MESSAGE_TEXT EQ expression (operator expression)*
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
	(ATOMIC | (NOT ATOMIC CONTINUE ON SQLEXCEPTION))
	)
	;

regenerateClause
	: (REGENERATE (USING APPLICATION COMPATIBILITY applCompatValue)?)
	;

alterIndexOptions
	:(
	(BUFFERPOOL bpName)
	| (CLOSE (YES | NO))
	| (COPY (YES | NO))
	| (DSSIZE SQLIDENTIFIER)
	| (PIECESIZE SQLIDENTIFIER)
	| usingSpecification
	| freeSpecification
	| gbpcacheSpecification
	| (NOT? CLUSTER)
	| (NOT? PADDED)
	| (COMPRESS (YES | NO))
	| (ADD
		((COLUMN
		LPAREN
		columnName (ASC | DESC | RANDOM)?
		RPAREN)
		| (INCLUDE COLUMN LPAREN columnName RPAREN))
	  )
	)
	;

alterIndexPartitionOptions
	: (
	ALTER partitionElement
		(usingSpecification+
		| freeSpecification+
		| gbpcacheSpecification
		| (DSSIZE SQLIDENTIFIER))*
	)
	;

usingSpecification
	: (
	(USING ((VCAT catalogName) | (STOGROUP stogroupName)))
	| (PRIQTY INTEGERLITERAL)
	| (SEQTY INTEGERLITERAL)
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
	GBPCACHE (CHANGED | ALL | NONE)
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

parameterType
	: (dataType (AS LOCATOR)?)
	;

optionList
	: (
	(EXTERNAL NAME (externalProgramName | identifier))
	| (LANGUAGE (ASSEMBLE | C_ | COBOL | JAVA | PLI | SQL))
	| (PARAMETER STYLE (SQL | JAVA))
	| (NOT? DETERMINISTIC)
	| (NOT? VARIANT)
	| (((RETURNS NULL) | CALLED) ON NULL INPUT)
	| (NULL CALL) 
	| ((MODIFIES SQL DATA) | (READS SQL DATA) | (CONTAINS SQL) | (NO SQL))
	| (NO? EXTERNAL ACTION)
	| ((PACKAGE PATH packagePath) | (NO PACKAGE PATH))
	| ((NO SCRATCHPAD) | (SCRATCHPAD INTEGERLITERAL))
	| (NO? FINAL CALL)
	| ((ALLOW | DISALLOW) PARALLEL)
	| (NO? DBINFO)
	| (CARDINALITY INTEGERLITERAL)
	| ((NO COLLID) | (COLLID collectionID))
	| (WLM ENVIRONMENT (identifier | (LPAREN identifier COMMA SPLAT RPAREN)))
	| (ASUTIME ((NO LIMIT) | (LIMIT INTEGERLITERAL)) )
	| (STAY RESIDENT (NO | YES))
	| (PROGRAM TYPE (SUB | MAIN))
	| (SECURITY (DB2 | USER | DEFINER))
	| ((STOP AFTER SYSTEM DEFAULT FAILURES) | (STOP AFTER INTEGERLITERAL FAILURES) | (CONTINUE AFTER FAILURE))
	| (RUN OPTIONS runTimeOptions)
	| ((INHERIT | DEFAULT) SPECIAL REGISTERS)
	| (STATIC DISPATCH)
	| (NOT? SECURED)
	| SPECIFIC
	| (PARAMETER CCSID)
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
	| literal
	| columnName
	| hostVariable
	| specialRegister
	| scalarFullSelect
	| timeZoneSpecificExpression
	| labeledDuration
	| caseExpression
	| castSpecification
	| xmlCastSpecification
	| arrayElementSpecification
	| arrayConstructor
	| olapSpecification
	| rowChangeExpression
	| sequenceReference
	)
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
	: ((schemaName DOT)? scalarFunction
	LPAREN
	expression (COMMA expression)*
	RPAREN)
	;

aggregateFunctionInvocation
	: ((schemaName DOT)? aggregateFunction
	LPAREN
	DISTINCT?
	(expression | SPLAT)
	RPAREN)
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
	(YEAR
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
	| MICROSECONDS)
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
	: FIRST_VALUE LPAREN expression (COMMA respectNullsClause)? RPAREN
	;

lastValueFunction
	: LAST_VALUE LPAREN expression (COMMA respectNullsClause)? RPAREN
	;

nthValueFunction
	: NTH_VALUE LPAREN expression COMMA INTEGERLITERAL RPAREN
	;

ratioToReportFunction
	: RATIO_TO_REPORT LPAREN expression RPAREN
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

xmltableFunctionSpecification
	: (
	XMLTABLE
	LPAREN
	(xmlnamespacesDeclaration COMMA)?
	rowXqueryExpressionConstant
	(PASSING (BY REF)? rowXqueryArgument (COMMA rowXqueryArgument))?
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
	(xqueryContextItemExpression | (xqueryVariableExpression AS identifier))
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

defaultClauseAllowables
	: (
	literal
	| SESSION_USER
	| USER
	| (CURRENT SQLID)
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
	(searchedWhenClause | simpleWhenClause)
	((ELSE NULL) | (ELSE resultExpression))
	END
	;

resultExpression
	: expression
	;

searchedWhenClause
	: WHEN
	searchCondition
	THEN
	(resultExpression | NULL)
	;

simpleWhenClause
	: expression
	WHEN
	expression
	THEN
	(resultExpression | NULL)
	;

searchCondition
	: NOT?
	((predicate (SELECTIVITY NUMERICLITERAL)?) | (LPAREN searchCondition RPAREN))
	((AND | OR) NOT? (predicate | (LPAREN searchCondition RPAREN)))*
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
	dataType
	RPAREN
	;

parameterMarker
	: QUESTIONMARK
	;

dataType
	: (
	builtInType
	| distinctTypeName
	| arrayType
	)
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
	| ((((CHARACTER | CHAR) VARYING? ) | VARCHAR) (length | (LPAREN RPAREN))? ccsidQualifier?)
	| ((((CHARACTER | CHAR) LARGE OBJECT) | CLOB) (length | (LPAREN RPAREN))? ccsidQualifier?)
	| ((GRAPHIC | VARGRAPHIC | DBCLOB) (length | (LPAREN RPAREN))? ccsidQualifier?)
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
	(((ASCII | EBCDIC | UNICODE) forDataQualfier?) | INTEGERLITERAL)
	)
	;

forDataQualfier
	: (FOR (SBCS | MIXED | BIT) DATA)
	;

distinctTypeName
	: identifier
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
	: (correlationName DOT)? identifier
	;

newColumnName
	: identifier
	;

correlationName
	: identifier
	;

locationName
	: identifier
	;

schemaName
	: identifier
	;

tableName
	: ((locationName DOT schemaName DOT) | (schemaName DOT))? identifier correlationName?
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

databaseName
	: identifier
	;

catalogName
	: identifier
	;

bpName
	: identifier
	;

stogroupName
	: identifier
	;

functionName
	: (schemaName DOT)? identifier
	;

specificName
	: (schemaName DOT)? identifier
	;

hostVariable
	: COLON (hostStructure DOT)? hostIdentifier (INDICATOR? COLON (hostStructure DOT)? hostIdentifier)?
	;

hostIdentifier
	: identifier
	;

hostStructure
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
		(INNER | ((LEFT | RIGHT | FULL) OUTER?)) JOIN
					tableReference ON joinCondition)
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
	: (tableName periodSpecification* correlationClause?)
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
	(scalarFunction | aggregateFunction | regressionFunction | identifier)
	LPAREN
	(expression | (TABLE tableName)) (COMMA (expression | (TABLE tableName)))*
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
	(expression (operator expression)* (AS? newColumnName)?)
	| (tableName DOT SPLAT)
	| (unpackedRow)
	)
	;

unpackedRow
	: UNPACK LPAREN expression RPAREN DOT SPLAT AS 
	LPAREN 
	columnName dataType (COMMA columnName dataType)* 
	RPAREN
	;

selectClause
	: SELECT
	(ALL | DISTINCT)?
	(SPLAT | (selectColumns (COMMA selectColumns)*))
	;

subSelect
	: selectClause
	fromClause
	whereClause?
	groupByClause?
	havingClause?
	orderByClause?
	offsetClause?
	fetchClause?
	;

selectIntoStatement
	: (WITH commonTableExpression (COMMA commonTableExpression)*)?
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
	;

selectStatement
	: (WITH commonTableExpression (COMMA commonTableExpression)*)?
	fullSelect
	(
	updateClause
	| readOnlyClause
	| optimizeClause
	| isolationClause 
	| skipLockedDataClause
	| querynoClause
	)*
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
	:(QUERYNO INTEGERLITERAL)
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
/*	| G_CHAR
	| K_CHAR
	| M_CHAR*/
	| sqlKeyword
	| specialRegister
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
	| CURRENT_LC_CTYPE
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
	| SEQTY
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
	)
	;


