//PROSBDB2 JOB ,,NOTIFY=&SYSUID
//*
//****************************************************************************
//*       CREATION D'UNE TABLE
//*     avec sauvegarde syscopy
//****************************************************************************
//*
//JOBLIB   DD DSN=DB2B10.SDSNLOAD,DISP=SHR
//*
//****************************************************************************
//*
//*     STEP 1 : CREATE TABLE PROSPECT
//*
//PH01S01  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  DSN SYSTEM(DB2T)
  RUN PROGRAM(DSNTIAD) PLAN(DSNTIA11) -
      LIB('SYS2.DB2B10.RUNLIB')
//SYSPRINT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSIN    DD *

  CREATE TABLE TRAIN04.PROSPECT
      (ID         CHAR(6) NOT NULL,
       NOM        CHAR(35) NOT NULL,
       ADDR_RUE   CHAR(40),
       ADDR_CP    CHAR(5),
       ADDR_VILLE CHAR(35),
       PRIMARY KEY(ID))
    IN BI04BASE.BI04TT04
    CCSID EBCDIC;

  CREATE UNIQUE INDEX TRAIN04.PROSPECT
      ON TRAIN04.PROSPECT(ID ASC)
      USING STOGROUP BI04STGR PRIQTY 12 ERASE NO;
//*
//****************************************************************************
//*
//*        STEP 2: GRANT AUTHORITY TO PROSPECT
//*
//PH01S02  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  DSN SYSTEM(DB2T)
  RUN PROGRAM(DSNTIAD) PLAN(DSNTIA11) -
      LIB('SYS.DB2B10.RUNLIB')
//SYSPRINT DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SYSIN    DD *
  GRANT DELETE, INSERT, SELECT, UPDATE
  ON TABLE TRAIN04.PROSPECT
  TO PUBLIC;
//*
//****************************************************************************
//*
//*        STEP 3: CREATE TABLE CONTACT
//*
//PH01S03  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  DSN SYSTEM(DB2T)
  RUN PROGRAM(DSNTIAD) PLAN(DSNTIA11) -
      LIB('SYS2.DB2B10.RUNLIB')
//SYSPRINT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//SYSIN    DD *

  CREATE TABLE TRAIN04.CONTACT
      (ID         CHAR(6) NOT NULL,
       NOM        CHAR(35),
       PRENOM     CHAR(35),
       TEL        CHAR(10),
       MEL        CHAR(80),
       NOTE       CHAR(80),
       PID        CHAR(6) NOT NULL,
       CONSTRAINT FK_PROSPECT_ID
          FOREIGN KEY(PID)
          REFERENCES PROSPECT(ID)
          ON DELETE RESTRICT,
       PRIMARY KEY(ID))
    IN BI04BASE.BI04TT04
    CCSID EBCDIC;

  CREATE UNIQUE INDEX TRAIN04.CONTACT
      ON TRAIN04.CONTACT(ID ASC)
      USING STOGROUP BI04STGR PRIQTY 12 ERASE NO;
//*
//****************************************************************************
//*
//*        STEP 4: GRANT AUTHORITY TO CONTACT
//*
//PH01S04  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  DSN SYSTEM(DB2T)
  RUN PROGRAM(DSNTIAD) PLAN(DSNTIA11) -
      LIB('SYS.DB2B10.RUNLIB')
//SYSPRINT DD SYSOUT=*
//SYSDUMP  DD SYSOUT=*
//SYSIN    DD *
  GRANT DELETE, INSERT, SELECT, UPDATE
  ON TABLE TRAIN04.CONTACT
  TO PUBLIC;