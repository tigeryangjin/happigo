BEGIN
  PROCESSSTATVTMINUTE();
  PROCESSSTATVTMINUTE5();
  PROCESSSTATVTMINUTE30();
END;


processstatnull5;
processstatnull;

PROCESSSTATVTMINUTE5_BAK;

SELECT P3.APPLICATION_KEY, COUNT(DISTINCT P3.VID) AS UVCOUNT
  FROM FACT_PAGE_VIEW_VT P3
 WHERE P3.VISIT_DATE >= &I
   AND P3.VISIT_DATE < &I + 5 / 24 / 60
   AND P3.APPLICATION_KEY IN (10, 20, 30, 40, 50)
 GROUP BY P3.APPLICATION_KEY;

SELECT C.APPLICATION_KEY, NVL(B.UVCOUNT, 0) UVCOUNT
  FROM (SELECT A.APPLICATION_KEY, COUNT(DISTINCT A.VID) AS UVCOUNT
          FROM FACT_PAGE_VIEW_VT A
         WHERE A.VISIT_DATE >= &I
           AND A.VISIT_DATE < &I + 1 / 24 / 60
           AND A.APPLICATION_KEY IN (10, 20, 30, 40, 50)
         GROUP BY A.APPLICATION_KEY) B,
       (SELECT 10 APPLICATION_KEY
          FROM DUAL
        UNION ALL
        SELECT 20 APPLICATION_KEY
          FROM DUAL
        UNION ALL
        SELECT 30 APPLICATION_KEY
          FROM DUAL
        UNION ALL
        SELECT 40 APPLICATION_KEY
          FROM DUAL
        UNION ALL
        SELECT 50 APPLICATION_KEY
          FROM DUAL) C
 WHERE C.APPLICATION_KEY = B.APPLICATION_KEY(+);


SELECT *
  FROM ALL_SOURCE A
 WHERE UPPER(A.TEXT) LIKE '%STATS_ONLINE_VISITOR_MINUTE%';


SELECT *
  FROM W_ETL_LOG A
 WHERE A.PROC_NAME = 'processstatnull'
 ORDER BY A.START_TIME DESC;

SELECT P3.APPLICATION_KEY, COUNT(DISTINCT P3.VID) AS UVCOUNT
  FROM FACT_PAGE_VIEW_VT P3
 WHERE P3.VISIT_DATE >= &I
   AND P3.VISIT_DATE < &I + 5 / 24 / 60
   AND P3.APPLICATION_KEY IN (10, 20, 30, 40, 50)
 GROUP BY P3.APPLICATION_KEY;

SELECT DATE '2018-11-27' + 1 / 24 + 20 / 24 / 60 FROM DUAL;

SELECT MAX(A.STATDATE)
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.ONLINEVISITOR = 0;
 
SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181102
   AND A.APPLICATION_KEY = 40
	 AND A.FREQUENCY=5
 ORDER BY A.START_TIME;

SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.ONLINEVISITOR = 0
   AND A.STATDATE >= 20181101;

SELECT A.STATDATE, A.APPLICATION_KEY, A.STATHOUR, COUNT(1)
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181127
   AND A.FREQUENCY = 5
 GROUP BY A.STATDATE, A.APPLICATION_KEY, A.STATHOUR
 ORDER BY A.STATDATE, A.APPLICATION_KEY, A.STATHOUR;
 

 
SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181127
   AND A.FREQUENCY = 5
   AND A.APPLICATION_KEY = 20
 ORDER BY A.STATHOUR, A.STATMINUTE;
 
SELECT * FROM ALL_SOURCE A WHERE UPPER(A.TEXT) LIKE '%INSERT%STATS_ONLINE_VISITOR_MINUTE%';

 
SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181127
   AND A.FREQUENCY = 5
   AND A.APPLICATION_KEY = 30
 ORDER BY A.STATHOUR, A.STATMINUTE;
 
SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181127
   AND A.FREQUENCY = 5
   AND A.APPLICATION_KEY = 40
 ORDER BY A.STATHOUR, A.STATMINUTE;

SELECT A.STATDATE, A.APPLICATION_NAME, A.STATHOUR, A.STATMINUTE, COUNT(1)
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181127
   AND A.APPLICATION_KEY = 10
 GROUP BY A.STATDATE, A.APPLICATION_NAME, A.STATHOUR, A.STATMINUTE
 ORDER BY A.STATDATE, A.APPLICATION_NAME, A.STATHOUR, A.STATMINUTE;

SELECT A.STATDATE, A.STATHOUR, COUNT(1)
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181126
 GROUP BY A.STATDATE, A.STATHOUR
 ORDER BY A.STATDATE, A.STATHOUR;

SELECT *
  FROM DW_USER.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181126
--AND A.FREQUENCY = 5
--AND A.STATHOUR >= 17
 ORDER BY A.APPLICATION_KEY,
          A.STATDATE,
          A.STATHOUR,
          A.STATMINUTE,
          A.FREQUENCY;

SELECT *
  FROM DW_HAPPIGO.STATS_ONLINE_VISITOR_MINUTE A
 WHERE A.STATDATE = 20181126
   AND A.FREQUENCY = 5
   AND A.STATHOUR >= 16
 ORDER BY A.STATDATE, A.STATHOUR, A.STATMINUTE, a.application_key;

SELECT * FROM STATS_ONLINE_GOOD2_MINUTE A;
SELECT * FROM STATS_ONLINE_GOOD_MINUTE A;
SELECT * FROM STATS_ONLINE_PUV_MINUTE A WHERE A.STATDATE = 20181126;
SELECT * FROM STATS_ONLINE_ACT_MINUTE A;

select * from all_all_tables a where a.table_name like '%STATS_ONLINE%';
SELECT * FROM ALL_OBJECTS A WHERE A.OBJECT_NAME LIKE 'STATS_ONLINE%';

select sysdate from dual;
