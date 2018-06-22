--1.
SELECT A.SALES_SOURCE_SECOND_NAME,
       SUM(A.EFFECTIVE_ORDER_AMOUNT) EFFECTIVE_ORDER_AMOUNT,
       SUM(A.EFFECTIVE_ORDER_QTY) EFFECTIVE_ORDER_QTY
  FROM OPER_PRODUCT_DAILY_REPORT A
 WHERE A.POSTING_DATE_KEY = 20180616
   AND A.SALES_SOURCE_NAME = '电商'
 GROUP BY A.SALES_SOURCE_SECOND_NAME
 ORDER BY A.SALES_SOURCE_SECOND_NAME;

--2.
SELECT A.ITEM_CODE,
       SUM(A.EFFECTIVE_ORDER_AMOUNT) EFFECTIVE_ORDER_AMOUNT,
       SUM(A.EFFECTIVE_ORDER_QTY) EFFECTIVE_ORDER_QTY
  FROM OPER_PRODUCT_DAILY_REPORT A
 WHERE A.POSTING_DATE_KEY = 20180616
   AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）'
 GROUP BY A.ITEM_CODE
 ORDER BY A.ITEM_CODE;

--******************************************************
--229842
--******************************************************
--3.
  SELECT *
    FROM OPER_PRODUCT_DAILY_REPORT A
   WHERE A.POSTING_DATE_KEY = 20180616
     AND A.SALES_SOURCE_SECOND_NAME = '新媒体APP（2.0）'
     AND A.ITEM_CODE = 229842;

--4.
SELECT *
  FROM FACT_GOODS_SALES A
 WHERE (A.POSTING_DATE_KEY = 20180616 OR A.UPDATE_TIME = 20180616)
   AND A.GOODS_COMMON_KEY = 229842
   AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--5.
SELECT *
  FROM FACT_GOODS_SALES_REVERSE A
 WHERE (A.POSTING_DATE_KEY = 20180616 OR A.UPDATE_TIME = 20180616)
   AND A.GOODS_COMMON_KEY = 229842
   AND A.SALES_SOURCE_SECOND_DESC = 'A20017';

--6.
SELECT *
  FROM ODSHAPPIGO.ODS_ORDER A
 WHERE A.CRMPOSTDAT = 20180616
   AND A.ZMATER2 = '000000000000229842'
 ORDER BY A.CRM_OBJ_ID;

--7.
SELECT *
  FROM ODSHAPPIGO.SAP_BIC_AZTCRD00100 A
 WHERE A.CRMPOSTDAT = 20180616
   AND A."/BIC/ZMATER2" = '000000000000229842';

--8.
SELECT *
  FROM ODSHAPPIGO.OD_ORDER_ITEM A
 WHERE TRUNC(A.ORDER_DATE) = DATE '2018-06-16'
   AND A.ITEM_CODE = 229842;
	 
--*************************************************************************
--FIX
--*************************************************************************
--1.
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180615);
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180616);
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180617);
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180618);
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180619);
CALL OD_ORDER_ETL.INSERT_ODS_ORDER(20180620);

--2.
DECLARE
  IN_DATE_INT NUMBER(8);
  IN_DATE     DATE;
  BEGIN_DATE  DATE := DATE '2018-06-15';
  END_DATE    DATE := DATE '2018-06-20';
BEGIN
  IN_DATE := BEGIN_DATE;
  WHILE IN_DATE <= END_DATE LOOP
    IN_DATE_INT := TO_CHAR(IN_DATE, 'YYYYMMDD');
    YANGJIN_PKG.FACT_GOODS_SALES_FIX(IN_DATE_INT, 'FACT');
    IN_DATE := IN_DATE + 1;
  END LOOP;
END;
/

--3.
DECLARE
  IN_DATE_INT NUMBER(8);
  IN_DATE     DATE;
  BEGIN_DATE  DATE := DATE '2018-06-15';
  END_DATE    DATE := DATE '2018-06-20';
BEGIN
  IN_DATE := BEGIN_DATE;
  WHILE IN_DATE <= END_DATE LOOP
    IN_DATE_INT := TO_CHAR(IN_DATE, 'YYYYMMDD');
    YANGJIN_PKG.OPER_PRODUCT_DAILY_RPT(IN_DATE_INT);
    IN_DATE := IN_DATE + 1;
  END LOOP;
END;
/
