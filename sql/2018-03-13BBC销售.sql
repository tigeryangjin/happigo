/*
销售日期  店铺名称  商品品类  商品名称  有效订购金额  有效订购件数
*/
--1.
SELECT A.ADD_TIME 销售日期,
       A.STORE_NAME 店铺名称,
       (SELECT D.GC_NAME
          FROM DIM_EC_GOOD C, DIM_EC_GOODS_CLASS D
         WHERE B.ITEM_CODE = C.ITEM_CODE
           AND C.GC_ID = D.GC_ID) 商品品类,
       B.ITEM_CODE 商品编码,
       B.GOODS_NAME 商品名称,
       SUM(B.GOODS_NUM * B.GOODS_PAY_PRICE) 有效订购金额,
       SUM(B.GOODS_NUM) 有效订购件数
  FROM FACTEC_ORDER A, FACTEC_ORDER_GOODS B
 WHERE A.ORDER_ID = B.ORDER_ID
   AND A.ORDER_STATE >= 20
   AND A.STORE_ID <> 1
 GROUP BY A.ADD_TIME, A.STORE_NAME, B.ITEM_CODE, B.GOODS_NAME
 ORDER BY A.ADD_TIME, A.STORE_NAME, B.ITEM_CODE, B.GOODS_NAME;

--tmp
SELECT * FROM FACTEC_ORDER;
SELECT * FROM FACTEC_ORDER_GOODS;
SELECT * FROM DIM_EC_GOOD A WHERE A.ITEM_CODE = 105310010;
SELECT *
  FROM ALL_COL_COMMENTS A
 WHERE A.COLUMN_NAME LIKE '%GC_ID%'
 ORDER BY A.OWNER, A.TABLE_NAME, A.COLUMN_NAME;
SELECT * FROM DIM_EC_GOODS_CLASS;
