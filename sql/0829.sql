SELECT F.MEMBER_KEY,
       G.M_LABEL_ID,
       G.M_LABEL_TYPE_ID,
       SYSDATE CREATE_DATE,
       'yangjin' CREATE_USER_ID,
       SYSDATE LAST_UPDATE_DATE,
       'yangjin' LAST_UPDATE_USER_ID
  FROM (SELECT E.MEMBER_KEY, E.PAYMENT_LABEL
          FROM (SELECT D.MEMBER_KEY,
                       D.PAYMENT_METHOD,
                       D.ORDER_AMOUNT,
                       D.RANK1,
                       D.TOTAL_ORDER_AMOUNT,
                       CASE
                       /*COD支付方式的金额大于合计支付金额的60%*/
                         WHEN D.RANK1 = 1 AND D.PAYMENT_METHOD = 'PAYMENT_COD' AND
                              D.ORDER_AMOUNT >= D.TOTAL_ORDER_AMOUNT * 0.6 THEN
                          D.PAYMENT_METHOD
                       END PAYMENT_LABEL
                  FROM (SELECT C.MEMBER_KEY,
                               C.PAYMENT_METHOD,
                               C.ORDER_AMOUNT,
                               RANK() OVER(PARTITION BY C.MEMBER_KEY ORDER BY C.ORDER_AMOUNT DESC) RANK1 /*订单金额倒序排名*/,
                               SUM(C.ORDER_AMOUNT) OVER(PARTITION BY C.MEMBER_KEY) TOTAL_ORDER_AMOUNT /*会员合计订单金额*/
                          FROM (SELECT B.MEMBER_KEY,
                                       B.PAYMENT_METHOD,
                                       SUM(B.ORDER_AMOUNT) ORDER_AMOUNT
                                  FROM (SELECT A.CUST_NO MEMBER_KEY,
                                               A.ADD_TIME,
                                               TO_CHAR(A.ORDER_SN) ORDER_NO,
                                               CASE
                                                 WHEN UPPER(A.PAYMENTCHANNEL) =
                                                      '线下支付' OR
                                                      A.PAYMENTCHANNEL IS NULL THEN
                                                  'PAYMENT_COD' /*COD*/
                                                 ELSE
                                                  'PAYMENT_ONLINE'
                                               END PAYMENT_METHOD,
                                               A.ORDER_AMOUNT
                                          FROM FACT_EC_ORDER A
                                         WHERE A.ORDER_STATE >= 20 /*已付款订单*/
                                              /*日期条件-180天*/
                                           AND A.ADD_TIME BETWEEN
                                               TO_CHAR(TRUNC(&IN_POSTING_DATE - 179),
                                                       'YYYYMMDD') AND
                                               TO_CHAR(TRUNC(&IN_POSTING_DATE),
                                                       'YYYYMMDD')) B
                                 WHERE B.PAYMENT_METHOD IS NOT NULL
                                 GROUP BY B.MEMBER_KEY, B.PAYMENT_METHOD) C) D) E
         WHERE E.PAYMENT_LABEL IS NOT NULL
              /*剔除掉订购金额=0的member*/
           AND E.TOTAL_ORDER_AMOUNT > 0) F,
       MEMBER_LABEL_HEAD G
 WHERE G.M_LABEL_ID BETWEEN 122 AND 125
   AND F.FINAL_PAYMENT_LABEL = G.M_LABEL_NAME;
