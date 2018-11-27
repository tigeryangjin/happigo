SELECT p1 "file#", p2 "block#", p3 "class#"
  FROM v$session_wait
 WHERE event = 'read by other session';

/*
82,2273163
82,2273163
45,4150636
*/
SELECT OWNER,
       SEGMENT_NAME,
       SEGMENT_TYPE,
       TABLESPACE_NAME,
       A.PARTITION_NAME,
       A.BLOCK_ID,
       A.BLOCKS,
			 A.BLOCK_ID-A.BLOCKS
  FROM DBA_EXTENTS A
 WHERE FILE_ID = &FILE_ID
   AND &BLOCK_ID BETWEEN BLOCK_ID AND BLOCK_ID + BLOCKS �C 1;
	 
SELECT OWNER,
       SEGMENT_NAME,
       SEGMENT_TYPE,
       TABLESPACE_NAME,
       A.PARTITION_NAME,
       A.BLOCK_ID,
       A.BLOCKS,
       A.BLOCK_ID - A.BLOCKS
  FROM DBA_EXTENTS A
 WHERE A.FILE_ID = 82
   AND 2273163 BETWEEN A.BLOCK_ID AND A.BLOCK_ID + A.BLOCKS ;
	 
SELECT * FROM DBA_IND_SUBPARTITIONS A WHERE A.status='UNUSABLE';
	 


SELECT OWNER,
       SEGMENT_NAME,
       SEGMENT_TYPE,
       TABLESPACE_NAME,
       A.PARTITION_NAME,
       A.BLOCK_ID,
       A.BLOCKS,
			 A.BLOCK_ID-A.BLOCKS
  FROM DBA_EXTENTS A
 WHERE FILE_ID = &FILE_ID
 ORDER BY A.BLOCK_ID;

SELECT * FROM Dba_Data_Files;


SELECT *
  FROM (SELECT O.OWNER, O.OBJECT_NAME, O.OBJECT_TYPE, SUM(TCH) TOUCHTIME
          FROM X$BH B, DBA_OBJECTS O
         WHERE B.OBJ = O.DATA_OBJECT_ID
           AND B.TS# > 0
         GROUP BY O.OWNER, O.OBJECT_NAME, O.OBJECT_TYPE
         ORDER BY SUM(TCH) DESC)
 WHERE ROWNUM <= 10;
--����
SELECT E.OWNER, E.SEGMENT_NAME, E.SEGMENT_TYPE
  FROM DBA_EXTENTS E,
       (SELECT *
          FROM (SELECT ADDR, TS#, FILE#, DBARFIL, DBABLK, TCH
                  FROM X$BH
                 ORDER BY TCH DESC)
         WHERE ROWNUM < 11) B
 WHERE E.RELATIVE_FNO = B.DBARFIL
   AND E.BLOCK_ID <= B.DBABLK
   AND E.BLOCK_ID + E.BLOCKS > B.DBABLK;
	 
	 
SELECT * FROM ALL_SOURCE A WHERE UPPER(A.TEXT) LIKE '%INSERT%FACT_PAGE_VIEW%';

SELECT * FROM W_ETL_LOG A WHERE A.PROC_NAME='createpaveviewfact' ORDER BY A.START_TIME DESC;

