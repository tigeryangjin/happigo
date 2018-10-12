/*
1-9月浏览过电视但未订购电视的用户
*/
--浏览
CREATE TABLE YANGJIN.FACT_PAGE_VIEW_2018_678 AS
  SELECT /*+PARALLEL(8)*/
   *
    FROM FACT_PAGE_VIEW A
   WHERE A.VISIT_DATE_KEY BETWEEN 20180601 AND 20180831
     AND A.PAGE_NAME IN ('good', 'Good')
     AND A.MEMBER_KEY <> 0
     AND A.PAGE_VALUE =
         TRANSLATE(A.PAGE_VALUE,
                   '0' || TRANSLATE(A.PAGE_VALUE, '#0123456789', '#'),
                   '0');

WITH PV AS
 (
  --浏览
  SELECT DISTINCT TO_NUMBER(A.MEMBER_KEY) MEMBER_BP
    FROM YANGJIN.FACT_PAGE_VIEW_2018_678 A
   WHERE EXISTS (SELECT 1
            FROM (SELECT D.GOODS_COMMONID
                    FROM DIM_EC_GOOD D, DIM_GOOD_CLASS E
                   WHERE D.MATDL = E.MATDL
                     AND E.MATXL = 430202) B
           WHERE A.PAGE_VALUE = B.GOODS_COMMONID)),

ORD AS
 (
  --订购
  SELECT F.MEMBER_BP
    FROM (SELECT TO_NUMBER(A.CUST_NO) MEMBER_BP,
                  COUNT(DISTINCT A.ORDER_ID) ORDER_CNT
             FROM FACT_EC_ORDER_2 A, FACT_EC_ORDER_GOODS B
            WHERE A.ORDER_ID = B.ORDER_ID
              AND A.ADD_TIME BETWEEN DATE '2018-01-01' AND DATE
            '2018-08-31'
              AND A.ORDER_STATE >= 20
              AND A.CUST_NO <> 0
              AND EXISTS
            (SELECT 1
                     FROM (SELECT D.GOODS_COMMONID
                             FROM DIM_EC_GOOD D, DIM_GOOD_CLASS E
                            WHERE D.MATDL = E.MATDL
                              AND E.MATXL = 430202) C
                    WHERE B.GOODS_COMMONID = C.GOODS_COMMONID)
            GROUP BY A.CUST_NO) F)
SELECT PV.MEMBER_BP
  FROM PV
 WHERE NOT EXISTS (SELECT 1 FROM ORD WHERE PV.MEMBER_BP = ORD.MEMBER_BP);





--tmp
SELECT * FROM DIM_GOOD A WHERE A.ITEM_CODE = 226570;
SELECT * FROM DIM_GOOD_CLASS A WHERE A.MATDLT LIKE '%电视%';
SELECT * FROM DIM_GOOD_CLASS A WHERE A.MATZLT LIKE '%电视%';
SELECT * FROM DIM_GOOD_CLASS A WHERE A.MATXLT LIKE '%电视%';
SELECT * FROM DIM_GOOD_CLASS A WHERE A.Matklt LIKE '%电视%';
