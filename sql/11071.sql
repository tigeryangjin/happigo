SELECT TRUNC(OH.ADD_TIME) ADD_TIME, /*��������*/
       NVL(X.XIANSHI_NAME, '��ʱ����') PROMOTION_NAME, /*��������*/
       CASE
         WHEN X.XIANSHI_TYPE = 1 THEN
          '��ʱֱ��'
         WHEN X.XIANSHI_TYPE = 2 THEN
          '��ʱ��'
         WHEN X.XIANSHI_TYPE = 3 THEN
          'TVֱ��'
         ELSE
          '��ʱ����'
       END PROMOTION_TYPE, /*��������*/
       CASE
         WHEN X.CRM_POLICY_ID = '0' THEN
          '��ý��'
         WHEN X.CRM_POLICY_ID <> '0' THEN
          'ͬ������'
         ELSE
          '��ý��'
       END PROMOTION_SOURCE, /*������Դ*/
       NVL(X.CRM_POLICY_ID, 0) PROMOTION_NO, /*�������*/
       CASE
         WHEN OH.APP_NAME = 'KLGiPhone' THEN
          'APP'
         WHEN OH.APP_NAME = 'KLGAndroid' THEN
          'APP'
         WHEN OH.APP_NAME = 'KLGPortal' THEN
          'WEB'
         WHEN OH.APP_NAME = 'KLGMPortal' THEN
          'WEB'
         WHEN OH.APP_NAME = 'KLGWX' THEN
          '΢��'
         WHEN OH.APP_NAME = 'undefined' THEN
          'δ֪'
       END PATHWAY, /*ͨ·*/
       OG.ERP_CODE ITEM_CODE, /*��Ʒ����*/
       OG.GOODS_NAME ITEM_NAME, /*��Ʒ����*/
       OG.GOODS_NUM SALES_QTY, /*��Ч��������*/
       OG.GOODS_NUM * OG.GOODS_PAY_PRICE SALES_AMOUNT, /*��Ʒ��Ч���*/
       (NVL(OG.GOODS_PRICE, 0) - NVL(OG.GOODS_PAY_PRICE, 0) -
       NVL(OG.TV_DISCOUNT_AMOUNT, 0) - NVL(OG.APPORTION_PRICE, 0)) *
       OG.GOODS_NUM COMPANY_APPORTION_AMOUNT, /*��˾����*/
       OG.APPORTION_PRICE * OG.GOODS_NUM SUPP_APPORTION_AMOUNT, /*��Ӧ������*/
       OG.SUPPLIER_ID, /*��Ӧ�̱���*/
       (NVL(OG.GOODS_PRICE, 0) - NVL(OG.GOODS_PAY_PRICE, 0) -
       NVL(OG.TV_DISCOUNT_AMOUNT, 0)) * OG.GOODS_NUM TOTAL_APPORTION_AMOUNT, /*�����ܳɱ�*/
       TO_CHAR(OH.ORDER_SN) ORDER_SN /*��������*/
  FROM FACT_EC_ORDER_2         OH,
       FACT_EC_ORDER_GOODS     OG,
       FACT_EC_P_XIANSHI       X,
       FACT_EC_P_XIANSHI_GOODS XG
 WHERE OH.ORDER_ID = OG.ORDER_ID
   AND OG.XIANSHI_GOODS_ID = XG.XIANSHI_GOODS_ID(+)
   AND XG.XIANSHI_ID = X.XIANSHI_ID(+)
      /*��Ч��������*/
   AND OH.ORDER_STATE >= 30
   AND OH.REFUND_STATE = 0
   AND OG.GOODS_TYPE = 3
   AND TRUNC(OH.ADD_TIME) BETWEEN DATE '2017-10-01' AND DATE
 '2017-10-31';

SELECT *
  FROM FACT_EC_ORDER_2         OH,
       FACT_EC_ORDER_GOODS     OG,
       FACT_EC_P_XIANSHI       X,
       FACT_EC_P_XIANSHI_GOODS XG
 WHERE OH.ORDER_ID = OG.ORDER_ID
   AND OG.XIANSHI_GOODS_ID = XG.XIANSHI_GOODS_ID(+)
   AND XG.XIANSHI_ID = X.XIANSHI_ID(+)
      /*��Ч��������*/
   AND OH.ORDER_STATE >= 30
   AND OH.REFUND_STATE = 0
   AND OG.GOODS_TYPE = 3
   AND TRUNC(OH.ADD_TIME) BETWEEN DATE '2017-10-01' AND DATE
 '2017-10-31';