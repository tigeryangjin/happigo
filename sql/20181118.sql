--1.103gb
SELECT *
  FROM DBA_SEGMENTS A
 WHERE A.TABLESPACE_NAME = 'DB_LOGISTICS'
 ORDER BY A.BYTES DESC;

--2.
SELECT B.OWNER "owner",
       B.TABLE_NAME "table_naeme",
       ROUND(A.SEG_BYTES / 1024 / 1024, 1) "SEG_BYTES(MB)",
       ROUND(B.TAB_BYTES / 1024 / 1024, 1) "TAB_BYTES(MB)",
       ROUND((A.SEG_BYTES - B.TAB_BYTES) / 1024 / 1024, 1) "free(MB)",
       ROUND(B.TAB_BYTES / A.SEG_BYTES, 2) "used_per",
       B.LAST_ANALYZED
  FROM (SELECT A1.OWNER, A1.SEGMENT_NAME, SUM(A1.BYTES) SEG_BYTES
          FROM DBA_SEGMENTS A1
         GROUP BY OWNER, SEGMENT_NAME) A,
       (SELECT B1.OWNER,
               B1.TABLE_NAME,
               B1.LAST_ANALYZED,
               SUM(B1.NUM_ROWS * B1.AVG_ROW_LEN) TAB_BYTES
          FROM DBA_TABLES B1
         GROUP BY OWNER, TABLE_NAME, B1.LAST_ANALYZED) B
 WHERE A.SEGMENT_NAME = B.TABLE_NAME
   AND B.OWNER IN ('DW_USER', 'ODSHAPPIGO')
   AND B.TABLE_NAME = 'LIKP'
 ORDER BY 5 DESC;
 
--3.
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'ODSHAPPIGO',
                                TABNAME => 'LIKP',
                                DEGREE  => 4,
                                CASCADE => TRUE);
END;
/

--4.
SELECT B.COL1, B.OWNER, B.TABLE_NAME, B.COL2
  FROM (SELECT 1 COL1,
               A.owner,
               A.TABLE_NAME,
               'ALTER TABLE ' || A.OWNER || '.' || A.TABLE_NAME ||
               ' MOVE TABLESPACE DWDATA00 PARALLEL(DEGREE 4) NOLOGGING;' COL2
          FROM DBA_TABLES A
         WHERE A.tablespace_name = 'DB_LOGISTICS'
           AND A.PARTITIONED = 'NO'
        UNION ALL
        SELECT 2 COL1,
               A.owner,
               A.TABLE_NAME,
               'ALTER INDEX ' || A.OWNER || '.' || A.index_name ||
               ' REBUILD TABLESPACE DWDATA00 PARALLEL(DEGREE 4) NOLOGGING;' COL2
          FROM DBA_INDEXES A
         WHERE A.tablespace_name = 'DB_LOGISTICS'
           AND A.partitioned = 'NO'
           AND A.INDEX_TYPE = 'NORMAL'
        UNION ALL
        SELECT 3 COL1,
               A.owner,
               A.TABLE_NAME,
               'ALTER INDEX ' || A.OWNER || '.' || A.index_name ||
               ' NOPARALLEL;' COL2
          FROM DBA_INDEXES A
         WHERE A.tablespace_name = 'DB_LOGISTICS'
           AND A.partitioned = 'NO'
           AND A.INDEX_TYPE = 'NORMAL') B
 WHERE B.TABLE_NAME = 'FACT_HMSC_ITEM_AREA_MARKET'
 ORDER BY B.OWNER, B.TABLE_NAME, B.COL1;




