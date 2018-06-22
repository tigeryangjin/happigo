--*********************************************************************
--1.daily check
--*********************************************************************
--1.1没有执行的过程
SELECT * FROM YJ_DAILY_CHECK_NO_EXEC_V T ORDER BY T.IP, T."USER", T.PNAME;

--1.2.W_ETL_LOG check
select * from YJ_DAILY_CHECK_ERR_V T ORDER BY T.IP, T."USER", T.START_TIME;

--1.2.44line
/*
10.10.204.27 dw_user
HAPPIGO_EC_PKG_1  HAPPIGO_EC_PKG.MERGE_EC_GOODS_COMMON
HAPPIGO_EC_PKG_2  HAPPIGO_EC_PKG.MERGE_EC_GOODS_MANUAL
HAPPIGO_EC_PKG_3  HAPPIGO_EC_PKG.MERGE_EC_ORDER
HAPPIGO_EC_PKG_4  HAPPIGO_EC_PKG.MERGE_EC_ORDER_COMMON
HAPPIGO_EC_PKG_5  HAPPIGO_EC_PKG.MERGE_EC_ORDER_GOODS
HAPPIGO_EC_PKG_6  HAPPIGO_EC_PKG.MERGE_EC_P_MANSONG
HAPPIGO_EC_PKG_7  HAPPIGO_EC_PKG.MERGE_EC_P_MANSONG_GOODS
HAPPIGO_EC_PKG_8  HAPPIGO_EC_PKG.MERGE_EC_P_XIANSHI
HAPPIGO_EC_PKG_9  HAPPIGO_EC_PKG.MERGE_EC_P_XIANSHI_GOODS
HAPPIGO_EC_PKG_10 HAPPIGO_EC_PKG.MERGE_EC_VOUCHER
HAPPIGO_EC_PKG_11 HAPPIGO_EC_PKG.MERGE_EC_VOUCHER_BATCH
HAPPIGO_EC_PKG_12 HAPPIGO_EC_PKG.MERGE_EC_VOUCHER_PRICE
HAPPIGO_KPI_PKG_1 HAPPIGO_KPI_PKG.KPI_ACTIVE_VID_BASE_PROC
HAPPIGO_KPI_PKG_2 HAPPIGO_KPI_PKG.KPI_ASMT_APP_DOWNLOAD_PROC
HAPPIGO_KPI_PKG_3 HAPPIGO_KPI_PKG.KPI_ASMT_APP_ITEM_CVR_DT_PROC
HAPPIGO_KPI_PKG_4 HAPPIGO_KPI_PKG.KPI_ASMT_APP_ITEM_CVR_PROC
HAPPIGO_KPI_PKG_5 HAPPIGO_KPI_PKG.KPI_ASMT_APP_MAU_PROC
HAPPIGO_KPI_PKG_6 HAPPIGO_KPI_PKG.KPI_ASMT_APP_NET_ORDER_CVR_P
HAPPIGO_KPI_PKG_7 HAPPIGO_KPI_PKG.KPI_ASMT_NEW_UV_DT_PROC
HAPPIGO_KPI_PKG_8 HAPPIGO_KPI_PKG.KPI_ASMT_NEW_UV_PROC
HAPPIGO_KPI_PKG_9 HAPPIGO_KPI_PKG.KPI_ASMT_OLD_UV_DT_PROC
HAPPIGO_KPI_PKG_10  HAPPIGO_KPI_PKG.KPI_ASMT_OLD_UV_PROC
HAPPIGO_KPI_PKG_11  HAPPIGO_KPI_PKG.KPI_ASMT_REG_ORDER_CVR_PROC
HAPPIGO_KPI_PKG_12  HAPPIGO_KPI_PKG.KPI_ASMT_REPURCHASE_MEMBER_P
HAPPIGO_KPI_PKG_13  HAPPIGO_KPI_PKG.KPI_ASMT_TOTAL_MONTH_PROC
HAPPIGO_KPI_PKG_14  HAPPIGO_KPI_PKG.KPI_ASMT_VEDIO_ITEM_CVR_DT_P
HAPPIGO_KPI_PKG_15  HAPPIGO_KPI_PKG.KPI_ASMT_VEDIO_ITEM_CVR_PROC
HAPPIGO_KPI_PKG_16  HAPPIGO_KPI_PKG.KPI_ASMT_WX_DAU_PROC
HAPPIGO_KPI_PKG_17  HAPPIGO_KPI_PKG.KPI_ASMT_WX_NEW_REG_PROC
HAPPIGO_KPI_PKG_18  HAPPIGO_KPI_PKG.KPI_ASMT_WX_NON_SCAN_CVR_DT_P
HAPPIGO_KPI_PKG_19  HAPPIGO_KPI_PKG.KPI_ASMT_WX_NON_SCAN_CVR_PROC
HAPPIGO_KPI_PKG_20  HAPPIGO_KPI_PKG.KPI_VID_FIRST_ORDER_PROC
HAPPIGO_KPI_PKG_21  HAPPIGO_KPI_PKG.KPI_VID_FIRST_VISIT_PROC
MEMBER_LABEL_PKG_1  MEMBER_LABEL_PKG.APP_LOSS_SCORE
MEMBER_LABEL_PKG_2  MEMBER_LABEL_PKG.COMMON_PORT
MEMBER_LABEL_PKG_3  MEMBER_LABEL_PKG.FIRST_ORDER_GIFT
MEMBER_LABEL_PKG_4  MEMBER_LABEL_PKG.FIRST_ORDER_ITEM
MEMBER_LABEL_PKG_5  MEMBER_LABEL_PKG.FIRST_ORDER_NOT
MEMBER_LABEL_PKG_6  MEMBER_LABEL_PKG.MEMBER_INJURED_PERIOD
MEMBER_LABEL_PKG_7  MEMBER_LABEL_PKG.MEMBER_LEVEL
MEMBER_LABEL_PKG_8  MEMBER_LABEL_PKG.MEMBER_LIFE_PERIOD
MEMBER_LABEL_PKG_9  MEMBER_LABEL_PKG.MEMBER_PAYMENT_METHOD
MEMBER_LABEL_PKG_10 MEMBER_LABEL_PKG.MEMBER_REPURCHASE
MEMBER_LABEL_PKG_11 MEMBER_LABEL_PKG.MIXED_CUSTOMER
MEMBER_LABEL_PKG_12 MEMBER_LABEL_PKG.ONLY_BROADCAST
MEMBER_LABEL_PKG_13 MEMBER_LABEL_PKG.ONLY_ONLINE_RETAIL
MEMBER_LABEL_PKG_14 MEMBER_LABEL_PKG.ONLY_SELF_SALES
MEMBER_LABEL_PKG_15 MEMBER_LABEL_PKG.ONLY_TV
MEMBER_LABEL_PKG_16 MEMBER_LABEL_PKG.WEBSITE_LOSS_SCORE
MEMBER_LABEL_PKG_17 MEMBER_LABEL_PKG.WX_LOSS_SCORE
MEMBER_REPURCHASE_PKG_1 MEMBER_REPURCHASE_PKG.MEMBER_REPURCHASE_PURSH_PROC
MEMBER_REPURCHASE_PKG_2 MEMBER_REPURCHASE_PKG.MEMBER_REPURCHASE_TRACT_PROC
MEMBER_SMS_PKG_1  MEMBER_SMS_PKG.MEMBER_SMS_POOL_OMMD
MEMBER_SMS_PKG_2  MEMBER_SMS_PKG.OPER_MEMBER_MBLEVEL_DCGOOD
YANGJIN_PKG_1 YANGJIN_PKG.CR_DATA_BASE_PROC
YANGJIN_PKG_2 YANGJIN_PKG.DATA_ACQUISITION_ITEM_BASE
YANGJIN_PKG_3 YANGJIN_PKG.DATA_ACQUISITION_ITEM_CURRENT
YANGJIN_PKG_4 YANGJIN_PKG.DATA_ACQUISITION_ITEM_MIN_PER
YANGJIN_PKG_5 YANGJIN_PKG.DATA_ACQUISITION_MONTH_NEW
YANGJIN_PKG_6 YANGJIN_PKG.DATA_ACQUISITION_MONTH_TOPN
YANGJIN_PKG_7 YANGJIN_PKG.DATA_ACQUISITION_WEEK_NEW
YANGJIN_PKG_8 YANGJIN_PKG.DATA_ACQUISITION_WEEK_TOPN
YANGJIN_PKG_9 YANGJIN_PKG.DIM_GOOD_PRICE_LEVEL_UPDATE
YANGJIN_PKG_10  YANGJIN_PKG.EC_NEW_MEMBER_TRACK_BASE
YANGJIN_PKG_11  YANGJIN_PKG.EC_NEW_MEMBER_TRACK_RANK
YANGJIN_PKG_12  YANGJIN_PKG.FACT_TV_QRC_PROC
YANGJIN_PKG_13  YANGJIN_PKG.MERGE_DIM_MEMBER_ZONE
YANGJIN_PKG_14  YANGJIN_PKG.OPER_MEMBER_NOT_IN_EC
YANGJIN_PKG_15  YANGJIN_PKG.OPER_NM_PROMOTION_ITEM_RPT
YANGJIN_PKG_16  YANGJIN_PKG.OPER_NM_PROMOTION_ORDER_RPT
YANGJIN_PKG_17  YANGJIN_PKG.OPER_NM_VOUCHER_RPT
YANGJIN_PKG_18  YANGJIN_PKG.OPER_PRODUCT_DAILY_RPT
YANGJIN_PKG_19  YANGJIN_PKG.OPER_PRODUCT_PVUV_DAILY_RPT
YANGJIN_PKG_20  YANGJIN_PKG.PROCESSMAKETHMSC_IA
*/
SELECT SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) || '_' || RANK() OVER(PARTITION BY SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) ORDER BY T.PROC_NAME, T.END_TIME DESC) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM W_ETL_LOG T
 WHERE EXISTS (SELECT 1
          FROM S_PARAMETERS2 A
         WHERE T.PROC_NAME = A.PNAME
           AND A.DEVELOPER = 'yangjin')
   AND T.PROC_NAME <> 'MEMBER_LABEL_PKG.MERGE_PUSH_MSG_LOG'
   AND T.PROC_NAME <> 'MEMBER_LABEL_PKG.MESSAGE_PUSH_LABEL'
   AND T.PROC_NAME <> 'MEMBER_LABEL_PKG.MERGE_PUSH_TASK_RULE'
   AND TRUNC(T.START_TIME) = TRUNC(SYSDATE);

--1.2.1.odshappigo
/*
OD_ORDER_ETL_1  OD_ORDER_ETL.INSERT_MODIFY_TP
OD_ORDER_ETL_2  OD_ORDER_ETL.INSERT_ODS_ORDER
OD_ORDER_ETL_3  OD_ORDER_ETL.INSERT_ODS_ORDER_CANCEL
OD_ORDER_ETL_4  OD_ORDER_ETL.MERGE_SAP_BIC_AZTCRD00100
*/
SELECT SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) || '_' || RANK() OVER(PARTITION BY SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) ORDER BY T.PROC_NAME, T.END_TIME DESC) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM ODSHAPPIGO.W_ETL_LOG T
 WHERE EXISTS (SELECT 1
          FROM ODSHAPPIGO.S_PARAMETERS2 A
         WHERE T.PROC_NAME = A.PNAME
           AND A.DEVELOPER = 'yangjin')
   AND TRUNC(T.START_TIME) >= TRUNC(SYSDATE);

--1.3.8line
/*
10.10.204.18 dw_user
OPER_MEMBER_LIKE_PKG_1  OPER_MEMBER_LIKE_PKG.OPER_MEMBER_LIKE_BASE_PROC
OPER_MEMBER_LIKE_PKG_2  OPER_MEMBER_LIKE_PKG.OPER_MEMBER_LIKE_ITEM_PROC
OPER_MEMBER_LIKE_PKG_3  OPER_MEMBER_LIKE_PKG.OPER_MEMBER_LIKE_MATXL_PROC
OPER_MEMBER_MARKETING_PKG_1 OPER_MEMBER_MARKETING_PKG.PROC_MBR_FIRST_ORDER_15DAYS
OPER_MEMBER_MARKETING_PKG_2 OPER_MEMBER_MARKETING_PKG.PROC_MBR_ORDER_PUSH
OPER_MEMBER_MARKETING_PKG_3 OPER_MEMBER_MARKETING_PKG.PROC_MBR_REG_WITHOUT_ORDER
OPER_MEMBER_MARKETING_PKG_4 OPER_MEMBER_MARKETING_PKG.PROC_MBR_SECOND_ORDER_20DAYS
OPER_MEMBER_MARKETING_PKG_5 OPER_MEMBER_MARKETING_PKG.PROC_MBR_THIRD_ORDER_30DAYS
*/
SELECT SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) || '_' || RANK() OVER(PARTITION BY SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) ORDER BY T.PROC_NAME, T.END_TIME DESC) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM W_ETL_LOG@BITONEWBI T
 WHERE EXISTS (SELECT 1
          FROM S_PARAMETERS2@BITONEWBI A
         WHERE T.PROC_NAME = A.PNAME
           AND A.DEVELOPER = 'yangjin')
   AND TRUNC(T.START_TIME) = TRUNC(SYSDATE);

SELECT SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) || '_' || RANK() OVER(PARTITION BY SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) ORDER BY T.PROC_NAME, T.END_TIME DESC) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM W_ETL_LOG@BITONEWBI T
 WHERE T.PROC_NAME IN
       ('OPER_MEMBER_LIKE_PKG.OPER_ITEM_RECOMMEND_AR_PROC',
        'OPER_MEMBER_LIKE_PKG.OPER_ITEM_RECOMMEND_SR_PROC',
        'OPER_MEMBER_LIKE_PKG.OPER_ITEM_RECOMMEND_UNION_PROC')
   AND TRUNC(T.START_TIME) >= TRUNC(SYSDATE - 1);

--1.4.2line
/*
10.10.204.18 ml
MEMBER_FILTER_PKG_1 MEMBER_FILTER_PKG.SYNC_MEMBER_LABEL_HEAD
MEMBER_FILTER_PKG_2 MEMBER_FILTER_PKG.SYNC_MEMBER_LABEL_LINK
*/
SELECT SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) || '_' || RANK() OVER(PARTITION BY SUBSTR(T.PROC_NAME, 1, INSTR(T.PROC_NAME, '.') - 1) ORDER BY T.PROC_NAME, T.END_TIME DESC) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM W_ETL_LOG@ML18 T
 WHERE EXISTS (SELECT 1
          FROM S_PARAMETERS2@ML18 A
         WHERE T.PROC_NAME = A.PNAME
           AND A.DEVELOPER = 'yangjin')
   AND TRUNC(T.START_TIME) = TRUNC(SYSDATE);

--1.5.实时消息推送
SELECT RANK() OVER(PARTITION BY TO_CHAR(T.START_TIME, 'YYYYMMDDHH24') ORDER BY T.END_TIME) RANK1,
       T.PROC_NAME,
       T.ETL_STATUS,
       T.ETL_DURATION,
       T.ETL_RECORD_INS,
       T.ETL_RECORD_UPD,
       T.ETL_RECORD_DEL,
       T.START_TIME,
       T.END_TIME,
       T.TABLE_NAME,
       T.ERR_MSG
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME IN
       ('MEMBER_LABEL_PKG.MERGE_PUSH_MSG_LOG',
        'MEMBER_LABEL_PKG.MERGE_PUSH_TASK_RULE',
        'MEMBER_LABEL_PKG.MESSAGE_PUSH_LABEL')
   AND TRUNC(T.START_TIME) = TRUNC(SYSDATE)
 ORDER BY T.END_TIME DESC;

--1.6.会员筛选
SELECT *
  FROM MEMBER_FILTER_OPTION_HEAD@ML18 A
 WHERE A.RESULT_MESSAGE IS NOT NULL
   AND A.RESULT_MESSAGE <> 'SUCCESS'
 ORDER BY A.FILTER_ID;

--1.7商品筛选
SELECT *
  FROM GOODS_FILTER_OPTION_HEAD@ML18 A
 WHERE A.RESULT_MESSAGE IS NOT NULL
   AND A.RESULT_MESSAGE <> 'SUCCESS'
 ORDER BY A.FILTER_ID;

--*************************************************************************************
--2.异常检查
--*************************************************************************************
--2.0.订单接入监控
SELECT A.CRMPOSTDAT, COUNT(1)
  FROM ODSHAPPIGO.SAP_BIC_AZTCRD00100 A
 WHERE NOT EXISTS (SELECT 1
          FROM ODSHAPPIGO.ODS_ORDER B
         WHERE B.ZTCRMC04 = A."/BIC/ZTCRMC04")
 GROUP BY A.CRMPOSTDAT
 ORDER BY A.CRMPOSTDAT DESC;

--2.1.会员发券监控(PROCESSED:1 成功 2失败 3接口错误 9 不用发券)
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_REG_WITHOUT_ORDER@BITONEWBI A
 WHERE A.RECORD_DATE_KEY = TO_CHAR(TRUNC(SYSDATE - 2), 'YYYYMMDD')
 GROUP BY A.PROCESSED;
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_ORDER_RETAIN_PUSH@BITONEWBI A
 WHERE A.RECORD_DATE_KEY = TO_CHAR(TRUNC(SYSDATE - 2), 'YYYYMMDD')
 GROUP BY A.PROCESSED;
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_REG_WITHOUT_ORDER@BITONEWBI A
 WHERE A.RECORD_DATE_KEY = TO_CHAR(TRUNC(SYSDATE - 1), 'YYYYMMDD')
 GROUP BY A.PROCESSED;
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_ORDER_RETAIN_PUSH@BITONEWBI A
 WHERE A.RECORD_DATE_KEY = TO_CHAR(TRUNC(SYSDATE - 1), 'YYYYMMDD')
 GROUP BY A.PROCESSED;
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_THIRD_ORDER_CAL_MONTH@BITONEWBI A
 WHERE A.MONTH_KEY = TO_CHAR(TRUNC(SYSDATE - 1, 'MONTH') - 1, 'YYYYMM')
 GROUP BY A.PROCESSED;
SELECT A.PROCESSED, COUNT(A.MEMBER_KEY)
  FROM OPER_MBR_TWELVE_ORDER_YEAR@BITONEWBI A
 WHERE A.MONTH_KEY = TO_CHAR(TRUNC(SYSDATE - 1, 'MONTH') - 1, 'YYYYMM')
 GROUP BY A.PROCESSED;

--2.2.订购退货单据是否传入DW
SELECT *
  FROM FACT_GOODS_SALES A
 WHERE A.POSTING_DATE_KEY = TO_CHAR(TRUNC(SYSDATE) - 1, 'YYYYMMDD');
SELECT *
  FROM FACT_GOODS_SALES_REVERSE A
 WHERE A.POSTING_DATE_KEY = TO_CHAR(TRUNC(SYSDATE) - 1, 'YYYYMMDD');
SELECT *
  FROM FACT_ORDER A
 WHERE A.POSTING_DATE_KEY = TO_CHAR(TRUNC(SYSDATE) - 1, 'YYYYMMDD');
SELECT A.CRMPOSTDAT, COUNT(1)
  FROM ODSHAPPIGO.ODS_ORDER A
 WHERE A.CRMPOSTDAT BETWEEN '20180401' AND '20180430'
 GROUP BY A.CRMPOSTDAT
 ORDER BY A.CRMPOSTDAT DESC;

SELECT TRUNC(A.ORDER_DATE), COUNT(1)
  FROM ODSHAPPIGO.OD_ORDER A
 WHERE A.ORDER_DATE BETWEEN DATE '2018-04-01' AND DATE '2018-04-30'
 GROUP BY TRUNC(A.ORDER_DATE)
 ORDER BY TRUNC(A.ORDER_DATE) DESC;

SELECT A.START_TIME,
       A.END_TIME,
       A.ETL_DURATION,
       A.PROC_NAME,
       A.ETL_RECORD_INS,
       A.ETL_STATUS,
       A.ERR_MSG
  FROM W_ETL_LOG A
 WHERE A.PROC_NAME = 'YANGJIN_PKG.OPER_PRODUCT_DAILY_RPT'
 ORDER BY A.START_TIME DESC;

--2.3.商品资料缺失
SELECT DISTINCT A.GOODS_KEY
  FROM OPER_PRODUCT_DAILY_REPORT A
 WHERE A.POSTING_DATE_KEY = TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
   AND A.GOODS_NAME IS NULL
 ORDER BY 1;
--2.3.1.每个商品的最大ROW_WID的current_flg='Y'
SELECT *
  FROM DIM_GOOD A
 WHERE EXISTS (SELECT 1
          FROM (SELECT B.ITEM_CODE, MAX(B.ROW_WID) ROW_WID
                  FROM DIM_GOOD B
                 GROUP BY B.ITEM_CODE) C
         WHERE A.ITEM_CODE = C.ITEM_CODE
           AND A.ROW_WID = C.ROW_WID)
   AND A.CURRENT_FLG = 'N';

SELECT *
  from dim_good a
 where a.item_code in
       (SELECT DISTINCT A.GOODS_KEY
          FROM OPER_PRODUCT_DAILY_REPORT A
         WHERE A.POSTING_DATE_KEY = TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
           AND A.GOODS_NAME IS NULL);
SELECT *
  from ods_zmaterial a
 where a.zmater2 in
       (SELECT DISTINCT '000000000000' || A.GOODS_KEY
          FROM OPER_PRODUCT_DAILY_REPORT A
         WHERE A.POSTING_DATE_KEY = TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
           AND A.GOODS_NAME IS NULL)
--and a.zmaterial not like '%F%'
--and a.ZEAMC027 is not null
/*and a.zeamc027 != 0*/
;

SELECT A.GOODS_COMMON_KEY, MIN(A.POSTING_DATE_KEY)
  FROM FACT_GOODS_SALES A
 WHERE A.GOODS_COMMON_KEY IN
       (SELECT DISTINCT A.GOODS_KEY
          FROM OPER_PRODUCT_DAILY_REPORT A
         WHERE A.POSTING_DATE_KEY = TO_CHAR(SYSDATE - 1, 'YYYYMMDD')
           AND A.GOODS_NAME IS NULL)
 GROUP BY A.GOODS_COMMON_KEY
 ORDER BY 1;

SELECT *
  FROM DIM_EC_GOOD A
 WHERE A.ITEM_CODE IN (224294, 224086, 224793, 224605, 224174, 224794);

SELECT *
  FROM W_ETL_LOG A
 WHERE A.PROC_NAME = 'YANGJIN_PKG.DIM_GOOD_FIX'
 ORDER BY A.START_TIME DESC;

CALL YANGJIN_PKG.DIM_GOOD_FIX();

--2.4.
---------订单
select CRMPOSTDAT, count(1)
  from odshappigo.ods_order
 where CRMPOSTDAT between '20180101' and '20180131'
 group by CRMPOSTDAT;

--------会员
select bb2.createdon, count(1)
  from odshappigo.ods_zbpartner bb2
 where bb2.createdon between '20180101' and '20180106'
 group by bb2.createdon;

--------商品
select bb2.createdon, count(1)
  from odshappigo.ods_zmaterial bb2
 where bb2.createdon between '20180101' and '20180106'
 group by bb2.createdon;

--**************************************************************************
--3.查询单个任务执行日志
--**************************************************************************
--3.1.YANGJIN_PKG.PROCESSMAKETHMSC_IA
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'YANGJIN_PKG.PROCESSMAKETHMSC_IA'
 ORDER BY T.START_TIME DESC;

--3.2.YANGJIN_PKG.OPER_PRODUCT_DAILY_RPT
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'YANGJIN_PKG.OPER_PRODUCT_DAILY_RPT'
 ORDER BY T.START_TIME DESC;

--3.3.YANGJIN_PKG.OPER_PRODUCT_PVUV_DAILY_RPT
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'YANGJIN_PKG.OPER_PRODUCT_PVUV_DAILY_RPT'
 ORDER BY T.START_TIME DESC;

--3.4.YANGJIN_PKG.OPER_PRODUCT_PVUV_DAILY_RPT
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'YANGJIN_PKG.OPER_MEMBER_MBLEVEL_DCGOOD'
 ORDER BY T.START_TIME DESC;

--3.4.YANGJIN_PKG.DIM_GOOD_FIX
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'YANGJIN_PKG.DIM_GOOD_FIX'
 ORDER BY T.START_TIME DESC;

--3.5.processgood
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'processgood'
 ORDER BY T.START_TIME DESC;

--3.6.MEMBER_LABEL_PKG.MEMBER_REPURCHASE
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'MEMBER_LABEL_PKG.MEMBER_REPURCHASE'
 ORDER BY T.START_TIME DESC;

--3.7.MEMBER_LABEL_PKG.MEMBER_LIFE_PERIOD
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME = 'MEMBER_LABEL_PKG.MEMBER_LIFE_PERIOD'
 ORDER BY T.START_TIME DESC;

--4.正逆向订单
SELECT *
  FROM W_ETL_LOG T
 WHERE T.PROC_NAME IN ('createfactordergoodsreverse',
                       'createordergoods',
                       'processupdateorder',
                       'processupdateorderreverse')
 ORDER BY T.START_TIME DESC;
