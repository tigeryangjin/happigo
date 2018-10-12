/*
物料大类  
物料中类  
物料小类  
物料细类  
商品编号  
商品名称  
提报组 
配送方式  
净订购件数 
拒退件数  
单笔订单中出现的最高订购件数  
单笔订单中出现的最多订购件数
*/
WITH S AS
 (
  --S
  SELECT A.GOODS_COMMON_KEY ITEM_CODE,
          SUM(A.NUMS) ORDER_QTY,
          MAX(A.NUMS) MAX_ORDER_QTY,
          MEDIAN(A.NUMS) MEDIAN_ORDER_QTY
    FROM FACT_GOODS_SALES A
   WHERE A.POSTING_DATE_KEY BETWEEN 20180801 AND 20180827
     AND A.ORDER_STATE = 1
   GROUP BY A.GOODS_COMMON_KEY),
R AS
 (
  --R
  SELECT B.GOODS_COMMON_KEY ITEM_CODE, SUM(B.NUMS) RE_ORDER_QTY
    FROM FACT_GOODS_SALES_REVERSE B
   WHERE B.POSTING_DATE_KEY BETWEEN 20180801 AND 20180827
   GROUP BY B.GOODS_COMMON_KEY),
D AS
 (SELECT C.ITEM_CODE,
         C.GOODS_NAME,
         C.MATDL,
         C.MATDLT,
         C.MATZL,
         C.MATZLT,
         C.MATXL,
         C.MATXLT,
         C.MATL_GROUP,
         C.MATXXLT,
         C.GROUP_ID,
         C.GROUP_NAME,
         CASE
           WHEN C1.IS_SHIPPING_SELF = 0 THEN
            '直配送'
           WHEN C1.IS_SHIPPING_SELF = 1 THEN
            '入库'
         END IS_SHIPPING_SELF /*配送方式*/
    FROM DIM_GOOD C, FACT_EC_GOODS C1
   WHERE C.ITEM_CODE = C1.ITEM_CODE)
SELECT D.MATDL            物料大类编码,
       D.MATDLT           物料大类名称,
       D.MATZL            物料中类编码,
       D.MATZLT           物料中类名称,
       D.MATXL            物料小类编码,
       D.MATXLT           物料小类名称,
       D.MATL_GROUP       物料细类编码,
       D.MATXXLT          物料细类名称,
       D.GROUP_ID         提报组编码,
       D.GROUP_NAME       提报组名称,
       D.IS_SHIPPING_SELF 配送方式,
       S.ITEM_CODE        商品编码,
       D.GOODS_NAME       商品名称,
       S.ORDER_QTY        净订购件数,
       R.RE_ORDER_QTY     拒退件数,
       S.MAX_ORDER_QTY    单笔订单最高订购件数,
       S.MEDIAN_ORDER_QTY 单笔订单最多订购件数
  FROM S, R, D
 WHERE S.ITEM_CODE = R.ITEM_CODE
   AND S.ITEM_CODE = D.ITEM_CODE;

SELECT * FROM DIM_GOOD;
SELECT * FROM FACT_EC_GOODS;
