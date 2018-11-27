--LIKP
ALTER TABLE ODSHAPPIGO.LIKP MOVE PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_LIKP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_LIKP NOPARALLEL;

--LIKP_TEMP
ALTER TABLE ODSHAPPIGO.LIKP_TEMP MOVE PARALLEL(DEGREE 4) NOLOGGING;

--LIPS
ALTER TABLE ODSHAPPIGO.LIPS MOVE PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_LIPS REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_LIPS NOPARALLEL;

--LIPS_TEMP
ALTER TABLE ODSHAPPIGO.LIPS_TEMP MOVE PARALLEL(DEGREE 4) NOLOGGING;

--MSEG
ALTER TABLE ODSHAPPIGO.MSEG MOVE PARALLEL(DEGREE 4) NOLOGGING;

--MSEG_TEMP
ALTER TABLE ODSHAPPIGO.MSEG_TEMP MOVE PARALLEL(DEGREE 4) NOLOGGING;

--NEW_ZTMM023_TEMP
ALTER TABLE ODSHAPPIGO.NEW_ZTMM023_TEMP MOVE PARALLEL(DEGREE 4) NOLOGGING;

--ZMCHB_H
ALTER TABLE ODSHAPPIGO.ZMCHB_H MOVE PARALLEL(DEGREE 4) NOLOGGING;

--ZMKOL_H
ALTER TABLE ODSHAPPIGO.ZMKOL_H MOVE PARALLEL(DEGREE 4) NOLOGGING;

--ZTSCM012
ALTER TABLE ODSHAPPIGO.ZTSCM012 MOVE PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_ZTSCM012 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_ZTSCM012 NOPARALLEL;