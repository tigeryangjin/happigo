--1.
SELECT SUM(A.BYTES) / 1024 / 1024 / 1024 GB, SUM(A.BLOCKS) BLOCKS
  FROM DBA_SEGMENTS A
 WHERE A.OWNER = 'DW_USER'
   AND A.SEGMENT_NAME = 'FACT_MEMBER_REGISTER';

SELECT *
  FROM DBA_TABLES A
 WHERE A.OWNER = 'DW_USER'
   AND A.TABLE_NAME = 'FACT_MEMBER_REGISTER';

SELECT *
  FROM DBA_PART_TABLES A
 WHERE A.OWNER = 'DW_USER'
   AND A.TABLE_NAME = 'FACT_MEMBER_REGISTER';

--2.
SELECT 'ALTER TABLE ' || A.TABLE_NAME || ' MOVE PARTITION ' ||
       A.PARTITION_NAME || ' COMPRESS PARALLEL 4;' S
  FROM DBA_TAB_PARTITIONS A
 WHERE A.TABLE_NAME = 'FACT_MEMBER_REGISTER'
   AND A.PARTITION_NAME IN ('MR1', 'MR2', 'MR3')
 ORDER BY A.PARTITION_NAME, A.PARTITION_NAME;
--3.重建分区索引
WITH A AS
 (SELECT A1.TABLE_OWNER, A1.TABLE_NAME, A1.PARTITION_NAME
    FROM DBA_TAB_PARTITIONS A1
   WHERE A1.TABLE_NAME = 'FACT_MEMBER_REGISTER'
     AND A1.PARTITION_NAME IN ('MR1', 'MR2', 'MR3')),
B AS
 (SELECT B1.table_owner, B1.table_name, B1.index_name
    FROM DBA_INDEXES B1
   WHERE B1.owner = 'DW_USER'
     AND B1.TABLE_NAME = 'FACT_MEMBER_REGISTER')
SELECT 'ALTER INDEX ' || B.INDEX_NAME || ' REBUILD PARTITION ' ||
       A.PARTITION_NAME || ';' S
  FROM A, B
 WHERE A.TABLE_OWNER = B.TABLE_OWNER
   AND A.TABLE_NAME = B.TABLE_NAME
 ORDER BY B.INDEX_NAME, A.PARTITION_NAME;
--4.
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'DW_USER',
                                TABNAME => 'FACT_MEMBER_REGISTER',
                                DEGREE  => 4,
                                CASCADE => TRUE);
END;
/

--tmp
  SELECT 963840 * 8 / 1024 / 1024 FROM DUAL;
