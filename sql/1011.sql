UPDATE OPER_MBR_ORDER_RETAIN_PUSH
   SET PROCESSED = 3,
       UPDATE_DT = TO_DATE('2017-10-12 14:44:32', 'yyyy-mm-dd hh24:mi:ss')
 WHERE MEMBER_KEY = '1105517003'
   AND RECORD_DATE_KEY = '20171011';

--2017-10-12 14:44:32 
SELECT *
  FROM OPER_MBR_ORDER_RETAIN_PUSH A
 WHERE A.MEMBER_KEY = 1105517003
   AND A.RECORD_DATE_KEY = 20171011;
