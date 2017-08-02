--1.
-- Create sequence 
drop sequence DIM_GOOD_SEQ;
create sequence DIM_GOOD_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;
--2.
CREATE TABLE DIM_GOOD_BAK0724 AS
SELECT * FROM DIM_GOOD;

UPDATE DIM_GOOD A SET A.ROW_WID=DIM_GOOD_SEQ.NEXTVAL WHERE 1=1;
COMMIT;

--3.
UPDATE DIM_GOOD A
   SET A.W_INSERT_DT = A.CREATE_TIME, A.W_UPDATE_DT = A.CREATE_TIME
 WHERE A.W_INSERT_DT IS NULL;
COMMIT;
--4.UPDATE CURRENT_FLG
--4.1加入到存储过程中每日执行
UPDATE DIM_GOOD A
   SET A.CURRENT_FLG = 'N'
 WHERE EXISTS
 (SELECT 1
          FROM (SELECT C.ITEM_CODE, COUNT(1) CNT, MAX(C.ROW_WID) ROW_WID
                  FROM DIM_GOOD C
                 WHERE C.CURRENT_FLG = 'Y'
                 GROUP BY C.ITEM_CODE
                HAVING COUNT(1) > 1) B
         WHERE A.ITEM_CODE = B.ITEM_CODE
           AND A.ROW_WID <> B.ROW_WID
					 AND A.CURRENT_FLG='Y');

--4.2
UPDATE DIM_GOOD A
   SET A.CURRENT_FLG = 'Y'
 WHERE EXISTS (SELECT 1
          FROM (SELECT C.ITEM_CODE, MAX(C.ROW_WID) ROW_WID
                  FROM DIM_GOOD C
                 GROUP BY C.ITEM_CODE) B
         WHERE A.ITEM_CODE = B.ITEM_CODE
           AND A.ROW_WID = B.ROW_WID)
					 AND A.CURRENT_FLG IS NULL;
COMMIT;

--4.3
UPDATE DIM_GOOD A SET A.CURRENT_FLG = 'N' WHERE A.CURRENT_FLG IS NULL;
COMMIT;

--tmp
SELECT A.ITEM_CODE,COUNT(DISTINCT A.MD) FROM DIM_GOOD A WHERE A.MD<>0 AND A.MD IS NOT NULL GROUP BY A.ITEM_CODE HAVING COUNT(1)>1;
SELECT * FROM DIM_GOOD A WHERE A.ITEM_CODE=214435;
SELECT * FROM DIM_GOOD A WHERE TRUNC(A.W_INSERT_DT)=DATE'2017-07-25';
SELECT A.ITEM_CODE,COUNT(1) FROM DIM_GOOD A WHERE A.CURRENT_FLG='Y' GROUP BY A.ITEM_CODE HAVING COUNT(1)>1;
SELECT * FROM DIM_GOOD A WHERE A.CURRENT_FLG IS NULL;
SELECT * FROM DIM_GOOD A WHERE A.ITEM_CODE=214384 FOR UPDATE;
SELECT * FROM W_ETL_LOG A WHERE A.PROC_NAME='processgood' ORDER BY A.START_TIME DESC;
SELECT * FROM DIM_GOOD;
SELECT * FROM ALL_SOURCE A WHERE UPPER(A.TEXT) LIKE '%INSERT INTO%DIM_GOOD%';
SELECT A.ITEM_CODE,COUNT(1) FROM DIM_GOOD A WHERE A.GOODS_COMMONID IS NOT NULL GROUP BY A.ITEM_CODE ORDER BY COUNT(1) DESC;
SELECT * FROM DIM_GOOD A WHERE A.ITEM_CODE=214384;
select /*+parallel(16)*/ * from ODSHAPPIGO.ODS_ZMATERIAL t WHERE T.zmater2='214384';
select * from ODSHAPPIGO.ODS_ZMATERIAL where rownum<=10;
SELECT COUNT(1) FROM DIM_GOOD;
select /*+PARALLEL(20)*/ * from ODSHAPPIGO.ODS_ZMATERIAL A where A.createdon=20170711;
SELECT * FROM DIM_GOOD A WHERE A.W_INSERT_DT IS NOT NULL;

