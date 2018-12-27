???CREATE OR REPLACE FORCE VIEW DW_USER.YJ_DAILY_CHECK_ZBPARTNER_V AS
SELECT CREATEDON, COUNT(1) CNT
  FROM ODSHAPPIGO.ODS_ZBPARTNER
 WHERE CREATEDON >= TO_CHAR(SYSDATE - 30, 'YYYYMMDD')
 GROUP BY CREATEDON
 ORDER BY CREATEDON DESC;
