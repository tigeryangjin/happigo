--****************************************************************************************
--商品编码：234240
--5208514566-订购-2018/5/25 01:43:03
--5208533026-退货-2018/5/26 08:19:31
--5208533026-退货取消-2018/6/7 10:44:16
--5208731187-退货-2018/6/7 10:44:30
--****************************************************************************************
--1.
SELECT
  A.SALES_SOURCE_SECOND_NAME,
  SUM(A.EFFECTIVE_ORDER_AMOUNT) EFFECTIVE_ORDER_AMOUNT
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_NAME = '电商'
GROUP BY A.SALES_SOURCE_SECOND_NAME;

--2.
SELECT
  A.ITEM_CODE,
  SUM(A.EFFECTIVE_ORDER_AMOUNT) EFFECTIVE_ORDER_AMOUNT
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）'
GROUP BY A.ITEM_CODE
ORDER BY A.ITEM_CODE;

--3.
SELECT *
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）' AND A.ITEM_CODE = 222856;

--4.
SELECT *
FROM FACT_GOODS_SALES A
WHERE A.GOODS_COMMON_KEY = 222856
      AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--5.
SELECT *
FROM FACT_GOODS_SALES_REVERSE A
WHERE A.GOODS_COMMON_KEY = 222856
      AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--6.
SELECT *
FROM ODSHAPPIGO.ODS_ORDER A
WHERE A.ZTCRMC04 = 5208514566
ORDER BY A.CRM_OBJ_ID;

--7.
SELECT *
FROM ODSHAPPIGO.OD_ORDER_ITEM A
WHERE A.ORDER_NO = 20180525835210;

--****************************************************************************************
--234568
--****************************************************************************************
--3.
SELECT *
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_SECOND_NAME = '新媒体微信（2.0）' AND A.ITEM_CODE = 234568;

--4.
SELECT *
FROM FACT_GOODS_SALES A
WHERE A.POSTING_DATE_KEY = 20180607 AND A.GOODS_COMMON_KEY = 234568
      AND A.SALES_SOURCE_SECOND_DESC = 'A20021';

--5.
SELECT *
FROM FACT_GOODS_SALES_REVERSE A
WHERE A.POSTING_DATE_KEY = 20180607 AND A.GOODS_COMMON_KEY = 234568
      AND A.SALES_SOURCE_SECOND_DESC = 'A20021';

--6.
SELECT *
FROM ODSHAPPIGO.ODS_ORDER A
WHERE A.ZTCRMC04 = 5208514566;

--7.
SELECT *
FROM ODSHAPPIGO.OD_ORDER_ITEM A
WHERE A.ORDER_NO = 20180525835210;

--****************************************************************************************
--处理
--****************************************************************************************
--重复定位
--DROP TABLE YANGJIN.ODS_ORDER_DUPLICATE;
--CREATE TABLE YANGJIN.ODS_ORDER_DUPLICATE AS
SELECT
  ROWNUM ROW_ID,
  B.CRMPOSTDAT,
  B.ZTCRMC04,
  B.CRM_OBJ_ID,
  B.CRM_NUMINT,
  B.CRM_OHGUID,
  B.CRM_PRCTYP,
  B.ZCRMD001
FROM (
       SELECT
         A.CRMPOSTDAT,
         A.ZTCRMC04,
         A.CRM_OBJ_ID,
         A.CRM_NUMINT,
         A.CRM_OHGUID,
         A.CRM_PRCTYP,
         A.ZCRMD001
       FROM ODSHAPPIGO.ODS_ORDER A
       GROUP BY A.CRMPOSTDAT,
         A.ZTCRMC04,
         A.CRM_OBJ_ID,
         A.CRM_NUMINT,
         A.CRM_OHGUID,
         A.CRM_PRCTYP,
         A.ZCRMD001
       HAVING COUNT(1) > 1) B;

SELECT *
FROM FACT_GOODS_SALES_REVERSE A
WHERE A.Order_Key = 5208514566
      AND A.GOODS_COMMON_KEY = 234240
      AND A.SALES_SOURCE_SECOND_DESC = 'A20021';

--****************************************************************************************
--商品编码：222856
--新媒体APP（2.0）
--日期：20180607
--5208537188-订购-2018-05-26 11:38:02
--5208602278-退货-2018-05-30 11:49:51
--5208602278-退货取消-2018-06-07 12:57:15
--****************************************************************************************
--2.
SELECT
  A.ITEM_CODE,
  SUM(A.EFFECTIVE_ORDER_AMOUNT) EFFECTIVE_ORDER_AMOUNT
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）'
GROUP BY A.ITEM_CODE
ORDER BY A.ITEM_CODE;

--3.
SELECT *
FROM OPER_PRODUCT_DAILY_REPORT A
WHERE A.POSTING_DATE_KEY = 20180607
      AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）' AND A.ITEM_CODE = 222856;

--4.
SELECT *
FROM FACT_GOODS_SALES A
WHERE A.GOODS_COMMON_KEY = 222856
      AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--5.
SELECT *
FROM FACT_GOODS_SALES_REVERSE A
WHERE A.GOODS_COMMON_KEY = 222856
      AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--6.
SELECT *
FROM FACT_GOODS_SALES A
WHERE A.ORDER_KEY = 5208537188;

--7.
SELECT *
FROM FACT_GOODS_SALES_REVERSE A
WHERE A.ORDER_KEY = 5208537188;

--8.
SELECT *
FROM ODSHAPPIGO.ODS_ORDER A
WHERE A.ZTCRMC04 = 5208537188;

--9.
SELECT *
FROM ODSHAPPIGO.OD_ORDER_ITEM A
WHERE A.ORDER_NO = 20180526756457;
