/*Consumption characteristics indicators 
消费特征指标*/

--直播商品忠诚度(PRODUCT_LOYALTY)
/*
只买播出商品(ONLY_BROADCAST)
只买TV商品(ONLY_TV)
只买电商提报商品(ONLY_ONLINE_RETAIL)
只买自营商品(SELF_SALES)
只买非自营商品(NON_SELF_SALES)
混合型(MIXED_CUSTOMER)
*/
INSERT INTO MEMBER_LABEL_HEAD
  (M_LABEL_ID,
   M_LABEL_NAME,
   M_LABEL_DESC,
   M_LABEL_TYPE_ID,
   M_LABEL_FATHER_ID,
   CREATE_DATE,
   CREATE_USER_ID,
   LAST_UPDATE_DATE,
   LAST_UPDATE_USER_ID,
   CURRENT_FLAG)
  SELECT MEMBER_LABEL_HEAD_SEQ.NEXTVAL, /*M_LABEL_ID*/
         'MIXED_CUSTOMER', /*M_LABEL_NAME*/
         '混合型', /*M_LABEL_DESC*/
         null, /*M_LABEL_TYPE_ID*/
         2, /*M_LABEL_FATHER_ID*/
         sysdate, /*CREATE_DATE*/
         'yangjin', /*CREATE_USER_ID*/
         sysdate, /*LAST_UPDATE_DATE*/
         'yangjin', /*LAST_UPDATE_USER_ID*/
         1 /*CURRENT_FLAG*/
    FROM DUAL;

--只买播出商品(ONLY_BROADCAST)
INSERT INTO MEMBER_LABEL_LINK
  (MEMBER_KEY,
   M_LABEL_ID,
   M_LABEL_TYPE_ID,
   CREATE_DATE,
   CREATE_USER_ID,
   LAST_UPDATE_DATE,
   LAST_UPDATE_USER_ID)
  SELECT D.MEMBER_KEY,
         3 M_LABEL_ID,
         1 M_LABEL_TYPE_ID,
         SYSDATE CREATE_DATE,
         'yangjin' CREATE_USER_ID,
         SYSDATE LAST_UPDATE_DATE,
         'yangjin' LAST_UPDATE_USER_ID
    FROM (SELECT C.MEMBER_KEY,
                 COUNT(C.ITEM_CODE) ITEM_COUNT,
                 COUNT(CASE
                         WHEN C.IS_BCST = 1 THEN
                          1
                         ELSE
                          NULL
                       END) BCST_ITEM_COUNT,
                 COUNT(DISTINCT C.ORDER_KEY) ORDER_COUNT
            FROM (SELECT SALES.POSTING_DATE_KEY,
                         SALES.ORDER_KEY,
                         SALES.MEMBER_KEY,
                         SALES.GOODS_COMMON_KEY ITEM_CODE,
                         NVL(TV_GOOD.IS_BCST, 0) IS_BCST
                    FROM (SELECT DISTINCT A.POSTING_DATE_KEY,
                                          A.ORDER_KEY,
                                          A.MEMBER_KEY,
                                          A.GOODS_COMMON_KEY
                            FROM FACT_GOODS_SALES A
                           WHERE A.POSTING_DATE_KEY >=
                                 TO_CHAR(TRUNC(SYSDATE - 181), 'YYYYMMDD')
                             AND A.ORDER_STATE = 1
                             AND A.TRAN_TYPE = 0) SALES,
                         (SELECT B.ITEM_CODE, B.TV_STARTDAY_KEY, 1 IS_BCST /*是否播出*/
                            FROM DIM_TV_GOOD B
                           WHERE B.IS_LIVE = '直播'
                             AND B.TV_STARTDAY_KEY >=
                                 TO_CHAR(TRUNC(SYSDATE - 181), 'YYYYMMDD')) TV_GOOD
                   WHERE SALES.POSTING_DATE_KEY = TV_GOOD.TV_STARTDAY_KEY(+)
                     AND SALES.GOODS_COMMON_KEY = TV_GOOD.ITEM_CODE(+)) C
           GROUP BY C.MEMBER_KEY) D
   WHERE /*用户订购单数大于4单时启用*/
   D.ORDER_COUNT >= 4
  /*订购商品达到70%以上是播出商品时认为是只买播出商品用户*/
   AND D.BCST_ITEM_COUNT / D.ITEM_COUNT >= 0.7;

--tmp
SELECT * FROM DIM_TV_GOOD ORDER BY TV_START_TIME DESC;
SELECT * FROM MEMBER_LABEL_HEAD;
SELECT * FROM MEMBER_LABEL_TYPE;
SELECT * FROM MEMBER_LABEL_LINK;
SELECT * FROM MEMBER_LABEL_LOG;
SELECT * FROM DIM_TV_GOOD;

SELECT * FROM ALL_COL_COMMENTS A WHERE A.COMMENTS LIKE '%自营%';
SELECT DISTINCT IS_SHIPPING_SELF FROM FACT_DAILY_GOODZAIJIA;
