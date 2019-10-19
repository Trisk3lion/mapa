//SYMBOLIC JOB
//*
//GLOBAL   INCLUDE MEMBER=GSET
//*
//AERYN    PROC AENV=D,B=7
//*
// SET AENV=Z Nullified by the value set on the PROC statement
//*
//PS01     EXEC PGM=CHIANA
//STEPLIB      INCLUDE MEMBER=LIB&AENV
//OUTPUT01 DD  DISP=(,CATLG,DELETE),
//             DSN=&SYSUID..CHIANNA.&AENV,
//             AVGREC=K,
//             LRECL=80,
//             SPACE=(80,(10,10),RLSE)
//PRINT        INCLUDE MEMBER=O&A.X&B&C.YZ
//*
//         PEND
//*
//MOYA     PROC
//*
//PS01     EXEC PGM=TALYN
//STEPLIB       INCLUDE MEMBER=LIB&AENV Must be set via SET
//OUTPUT01 DD  DISP=(,CATLG,DELETE),
//             DSN=&SYSUID..TALYN.&AENV,
//             AVGREC=K,
//             LRECL=80,
//             SPACE=(80,(10,10),RLSE)
//*
//         PEND
//*
// SET AENV=P
// SET UNUSED1='D''AVIN&&JAQOBIS'
// SET UNUSED2=DUTCH,UNUSED3='LUCY',UNUSED4=JOHNNY
// SET CENV=&AENV
//*
//JS01     EXEC PGM=CRICHTON
//STEPLIB      INCLUDE MEMBER=LIB&AENV Production
//OUTPUT01 DD  DISP=(,CATLG,DELETE),
//             DSN=&SYSUID..CRICHTON.&AENV,
//             AVGREC=K,
//             LRECL=80,
//             SPACE=(80,(10,10),RLSE)
//*
// SET AENV=Q
//*
//JS02     EXEC PGM=CRICHTON
//STEPLIB      INCLUDE MEMBER=LIB&AENV QA
//OUTPUT01 DD  DISP=(,CATLG,DELETE),
//             DSN=&SYSUID..CRICHTON.&AENV,
//             AVGREC=K,
//             LRECL=80,
//             SPACE=(80,(10,10),RLSE)
//*
//JS03     EXEC PROC=AERYN
//*
//JS04     EXEC PROC=AERYN,AENV=P
//*
//JS05     EXEC PROC=MOYA
//*
//JS06     EXEC PROC=MOYA,AENV=Q
//*
//JS02     EXEC PGM=CRAIS
//STEPLIB      INCLUDE MEMBER=LIB&AENV
//CARDS    DD  DISP=SHR,DSN=CARDS&CENV..APP
//OUTPUT01 DD  DISP=(,CATLG,DELETE),
//             DSN=&SYSUID..CRICHTON.&AENV,
//             AVGREC=K,
//             LRECL=80,
//             SPACE=(80,(10,10),RLSE)
//PRINT        INCLUDE MEMBER=O&A.X&B&C.YZ
//*
