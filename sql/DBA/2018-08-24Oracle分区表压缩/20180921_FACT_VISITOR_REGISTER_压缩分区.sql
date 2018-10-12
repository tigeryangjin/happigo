--1.
/*
2018-09-21
DBA_SEGMENTS:
--7.35G
--BLOCKS:963840
DBA_TABLES:
--BLOCKS:959678

DBA_SEGMENTS:
--5.27G
--BLOCKS:690208
DBA_TABLES:
--BLOCKS:688272

*/
SELECT SUM(A.BYTES) / 1024 / 1024 / 1024 GB, SUM(A.BLOCKS) BLOCKS
  FROM DBA_SEGMENTS A
 WHERE A.OWNER = 'DW_USER'
   AND A.SEGMENT_NAME = 'FACT_VISITOR_REGISTER';

SELECT *
  FROM DBA_TABLES A
 WHERE A.OWNER = 'DW_USER'
   AND A.TABLE_NAME = 'FACT_VISITOR_REGISTER';

SELECT *
  FROM DBA_PART_TABLES A
 WHERE A.OWNER = 'DW_USER'
   AND A.TABLE_NAME = 'FACT_VISITOR_REGISTER';

--2.
SELECT 'ALTER TABLE ' || A.TABLE_NAME || ' MOVE PARTITION ' ||
       A.PARTITION_NAME || ' COMPRESS PARALLEL 8;' S
  FROM DBA_TAB_PARTITIONS A
 WHERE A.TABLE_NAME = 'FACT_VISITOR_REGISTER'
   AND A.PARTITION_NAME IN ('VR1', 'VR2', 'VR3')
 ORDER BY A.PARTITION_NAME, A.PARTITION_NAME;
--3.
ALTER INDEX FACT_VISITOR_REGISTER_VID REBUILD PARTITION VR1;
ALTER INDEX FACT_VISITOR_REGISTER_VID REBUILD PARTITION VR2;
ALTER INDEX FACT_VISITOR_REGISTER_VID REBUILD PARTITION VR3;
ALTER INDEX FACT_VISITOR_REGISTER_IP_INT REBUILD PARTITION VR1;
ALTER INDEX FACT_VISITOR_REGISTER_IP_INT REBUILD PARTITION VR2;
ALTER INDEX FACT_VISITOR_REGISTER_IP_INT REBUILD PARTITION VR3;
ALTER INDEX FACT_VISITOR_REGISTER_I2 REBUILD PARTITION VR1;
ALTER INDEX FACT_VISITOR_REGISTER_I2 REBUILD PARTITION VR2;
ALTER INDEX FACT_VISITOR_REGISTER_I2 REBUILD PARTITION VR3;
ALTER INDEX FACT_VISITOR_REGISTER_I1 REBUILD PARTITION VR1;
ALTER INDEX FACT_VISITOR_REGISTER_I1 REBUILD PARTITION VR2;
ALTER INDEX FACT_VISITOR_REGISTER_I1 REBUILD PARTITION VR3;
--4.
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'DW_USER',
                                TABNAME => 'FACT_VISITOR_REGISTER',
                                DEGREE  => 4,
                                CASCADE => TRUE);
END;
/

--tmp
  SELECT 963840 * 8 / 1024 / 1024 FROM DUAL;
