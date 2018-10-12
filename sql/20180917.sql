--1.
SELECT *
  FROM DBA_SEGMENTS A
 WHERE A.OWNER = 'YANGJIN'
   AND A.SEGMENT_NAME = 'MEMBER_TMP';

SELECT *
  FROM DBA_EXTENTS A
 WHERE A.OWNER = 'YANGJIN'
   AND A.SEGMENT_TYPE = 'TABLE'
   AND A.SEGMENT_NAME = 'MEMBER_TMP';

SELECT *
  FROM DBA_TABLES A
 WHERE A.OWNER = 'YANGJIN'
   AND A.TABLE_NAME = 'MEMBER_TMP';

SELECT B.OWNER "owner",
       B.TABLE_NAME "table_naeme",
       ROUND(A.SEG_BYTES / 1024 / 1024, 1) "allocated_size(MB)",
       ROUND(B.TAB_BYTES / 1024 / 1024, 1) "used_size(MB)",
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
   AND A.OWNER = B.OWNER
   AND B.OWNER = 'YANGJIN'
   AND B.TABLE_NAME = 'MEMBER_TMP'
 ORDER BY 5 DESC;

SELECT COUNT(1) FROM YANGJIN.MEMBER_TMP;

--2.
TRUNCATE TABLE YANGJIN.MEMBER_TMP;

INSERT INTO YANGJIN.MEMBER_TMP
  SELECT A.MEMBER_BP
    FROM DW_USER.DIM_MEMBER A
   WHERE ROWNUM <= 100000
   ORDER BY A.MEMBER_BP;
COMMIT;

--5W
DELETE YANGJIN.MEMBER_TMP A WHERE A.MEMBER_KEY >= 609069045;
COMMIT;

--1W
DELETE YANGJIN.MEMBER_TMP A WHERE A.MEMBER_KEY >= 604018706;
COMMIT;

DELETE YANGJIN.MEMBER_TMP;
COMMIT;

--3.
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'YANGJIN',
                                TABNAME => 'MEMBER_TMP',
                                DEGREE  => 4,
                                CASCADE => TRUE);
END;
/

ANALYZE TABLE MEMBER_TMP COMPUTE STATISTICS;

ALTER TABLE MEMBER_TMP ENABLE ROW MOVEMENT;
ALTER TABLE MEMBER_TMP SHRINK SPACE COMPACT;
ALTER TABLE MEMBER_TMP DISABLE ROW MOVEMENT;

ALTER TABLE MEMBER_TMP ENABLE ROW MOVEMENT;
ALTER TABLE MEMBER_TMP SHRINK SPACE;
ALTER TABLE MEMBER_TMP DISABLE ROW MOVEMENT;
