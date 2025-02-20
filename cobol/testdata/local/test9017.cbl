       Identification Division.
       Program-ID. test9017.
       Data Division.
       Working-Storage Section.
       01  CONSTANTS.
           05  MYNAME               PIC X(012) VALUE 'test9017'.
           05  PGM-0001             PIC X(008) VALUE 'PGMA0001'.

       Procedure Division.
           DISPLAY MYNAME ' Begin'
           
           EXEC CICS
                START TRANSID('ABCD')
                AFTER SECONDS(3)
                FROM(CONSTANTS)
           END-EXEC

           EXEC CICS RUN
                TRANSID('EFGH')
           END-EXEC

           EXEC CICS READ FILE('SAMVIMES') INTO(PGM-0001)
           END-EXEC

           EXEC CICS DELETE FILE ( 'GASPODE' ) END-EXEC

           EXEC CICS WRITE
                FILE( 'CARROT') END-EXEC.

           EXEC CICS
                REWRITE
                FILE( 'VETINARI')
           END-EXEC

           EXEC CICS STARTBR
                     FILE('CMOTDBLR')
                     EQUAL
           END-EXEC

           EXEC CICS
                READNEXT
                FILE('CMOTDBLR')
                INTO(PGM-0001)
                LENGTH(LENGTH OF PGM-0001)
           END-EXEC

           EXEC CICS READPREV FILE('CMOTDBLR') INTO(PGM-0001)
           LENGTH(FUNCTION LENGTH(PGM-0001))
           END-EXEC

           DISPLAY MYNAME ' End'
           
           GOBACK
           .


