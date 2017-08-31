/*Consumption characteristics indicators 
消费特征指标*/

--************************************************************************
--新建标签
--************************************************************************
begin
  -- Call the procedure
  member_label_pkg.create_member_label(in_m_label_name      => 'FIRST_ORDER_BBC',
                                       in_m_label_desc      => '首单为BBC商品',
                                       in_m_label_type_id   => 1,
                                       in_m_label_father_id => 41);
end;
/

--************************************************************************
--直播商品忠诚度(PRODUCT_LOYALTY)
--************************************************************************
/*
只买播出商品(ONLY_BROADCAST)
只买TV商品(ONLY_TV)
只买电商提报商品(ONLY_ONLINE_RETAIL)
只买自营商品(SELF_SALES)
只买非自营商品(NON_SELF_SALES)
混合型(MIXED_CUSTOMER)
*/
INSERT
  INTO MEMBER_LABEL_HEAD(M_LABEL_ID, M_LABEL_NAME, M_LABEL_DESC, M_LABEL_TYPE_ID, M_LABEL_FATHER_ID, CREATE_DATE, CREATE_USER_ID, LAST_UPDATE_DATE, LAST_UPDATE_USER_ID, CURRENT_FLAG)
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

--************************************************************************
--常用端口(Common port)
--************************************************************************
/*
APP(COMMON_PORT_APP)(10,20,)
微信(COMMON_PORT_WX)(50)
WAP(COMMON_PORT_WAP)(30)
PC(COMMON_PORT_PC)(40)
无规律(COMMON_PORT_VARIETY)
*/
--fact_session.application_key
INSERT INTO MEMBER_LABEL_LINK
  (MEMBER_KEY,
   M_LABEL_ID,
   M_LABEL_TYPE_ID,
   CREATE_DATE,
   CREATE_USER_ID,
   LAST_UPDATE_DATE,
   LAST_UPDATE_USER_ID)
  SELECT F.MEMBER_KEY,
         G.M_LABEL_ID,
         G.M_LABEL_TYPE_ID,
         SYSDATE CREATE_DATE,
         'yangjin' CREATE_USER_ID,
         sysdate LAST_UPDATE_DATE,
         'yangjin' LAST_UPDATE_USER_ID
    FROM (SELECT E.MEMBER_KEY, SUBSTR(MAX(E.MAX_PER_PORT), 3) COMMON_PORT
            FROM (SELECT D.MEMBER_KEY,
                         D.COMMON_PORT,
                         D.FREQ,
                         D.TOTAL_FREQ,
                         D.FREQ / D.TOTAL_FREQ PORT_PER,
                         CASE
                           WHEN D.FREQ / D.TOTAL_FREQ >= 0.7 THEN
                            '2_' || D.COMMON_PORT
                           ELSE
                            '1_COMMON_PORT_VARIETY'
                         END MAX_PER_PORT
                    FROM (SELECT C.MEMBER_KEY,
                                 C.COMMON_PORT,
                                 C.FREQ,
                                 SUM(C.FREQ) OVER(PARTITION BY C.MEMBER_KEY) TOTAL_FREQ
                            FROM (SELECT B.MEMBER_KEY,
                                         B.COMMON_PORT,
                                         COUNT(1) FREQ
                                    FROM (SELECT A.MEMBER_KEY,
                                                 DECODE(A.APPLICATION_KEY,
                                                        10,
                                                        'COMMON_PORT_APP',
                                                        20,
                                                        'COMMON_PORT_APP',
                                                        30,
                                                        'COMMON_PORT_WAP',
                                                        40,
                                                        'COMMON_PORT_PC',
                                                        50,
                                                        'COMMON_PORT_WX') COMMON_PORT
                                            FROM FACT_SESSION A
                                           WHERE A.START_DATE_KEY BETWEEN
                                                 TO_CHAR(TRUNC(SYSDATE - 180),
                                                         'YYYYMMDD') AND
                                                 TO_CHAR(TRUNC(SYSDATE - 1),
                                                         'YYYYMMDD')
                                             AND A.MEMBER_KEY <> 0) B
                                   WHERE B.COMMON_PORT IS NOT NULL
                                   GROUP BY B.MEMBER_KEY, B.COMMON_PORT) C) D
                   WHERE D.TOTAL_FREQ >= 4) E
           GROUP BY E.MEMBER_KEY) F,
         MEMBER_LABEL_HEAD G
   WHERE G.M_LABEL_FATHER_ID = 21
     AND F.COMMON_PORT = G.M_LABEL_NAME;

--************************************************************************
--首单状态(first order)
--************************************************************************     
/*
未产生首单(first_order_not)
首单为新人礼(first_order_gift)(订单金额少于30元都算新人礼)
首单为TV播出商品(first_order_broadcast)
首单为TV非播出商品(first_order_not_broadcast)
首单为自营商品(first_order_self)
首单为BBC商品(first_order_BBC)
首单标签应该每日刷新，当一个用户注册之后，就应该打上首单标签。当一个用户第一次订购之后，首单标签就不会再变动了。
自营商品只在电商销售
先满足新人礼，然后才是其他标签。
*/

--重新刷新历史数据
DECLARE
  IN_DATE_INT NUMBER(8);
  IN_DATE     DATE;
  BEGIN_DATE  DATE := DATE '2017-01-01';
  END_DATE    DATE := DATE '2017-08-21';
BEGIN
  IN_DATE := BEGIN_DATE;
  WHILE IN_DATE <= END_DATE LOOP
    IN_DATE_INT := TO_CHAR(IN_DATE, 'YYYYMMDD');
    MEMBER_LABEL_PKG.FIRST_ORDER_MAIN(IN_DATE_INT);
    IN_DATE := IN_DATE + 1;
  END LOOP;
END;
/

INSERT
  INTO MEMBER_LABEL_LINK(MEMBER_KEY, M_LABEL_ID, M_LABEL_TYPE_ID, CREATE_DATE, CREATE_USER_ID, LAST_UPDATE_DATE, LAST_UPDATE_USER_ID)
  SELECT D.MEMBER_KEY,
         E.M_LABEL_ID,
         E.M_LABEL_TYPE_ID,
         SYSDATE CREATE_DATE,
         'yangjin' CREATE_USER_ID,
         SYSDATE LAST_UPDATE_DATE,
         'yangjin' LAST_UPDATE_USER_ID
    FROM (SELECT A.MEMBER_KEY
            FROM FACT_VISITOR_REGISTER A
           WHERE A.MEMBER_KEY <> 0
             AND A.CREATE_DATE_KEY = &IN_POSTING_DATE_KEY
             AND NOT EXISTS (SELECT 1
                    FROM (SELECT C.MEMBER_KEY
                            FROM FACT_GOODS_SALES C
                           WHERE C.ORDER_STATE = 1) B
                   WHERE A.MEMBER_KEY = B.MEMBER_KEY)) D,
         MEMBER_LABEL_HEAD E
   WHERE E.M_LABEL_NAME = 'FIRST_ORDER_NOT';

--首单订购金额最大的商品
SELECT A.MEMBER_KEY, A.ORDER_KEY, A.GOODS_COMMON_KEY, A.ORDER_AMOUNT
  FROM FACT_GOODS_SALES A
 WHERE A.ORDER_STATE = 1
   AND A.GOODS_COMMON_KEY IS NOT NULL
   AND EXISTS (SELECT 1
          FROM (SELECT C.MEMBER_KEY, MIN(C.ORDER_KEY) ORDER_KEY
                  FROM FACT_GOODS_SALES C
                 WHERE C.ORDER_STATE = 1
                   AND C.GOODS_COMMON_KEY IS NOT NULL
                 GROUP BY C.MEMBER_KEY) B
         WHERE A.MEMBER_KEY = B.MEMBER_KEY
           AND A.ORDER_KEY = B.ORDER_KEY)
   AND EXISTS (SELECT 1
          FROM (SELECT C.MEMBER_KEY,
                       C.ORDER_KEY,
                       MAX(C.ORDER_AMOUNT) ORDER_AMOUNT
                  FROM FACT_GOODS_SALES C
                 WHERE C.ORDER_STATE = 1
                   AND C.GOODS_COMMON_KEY IS NOT NULL
                 GROUP BY C.MEMBER_KEY, C.ORDER_KEY) D
         WHERE A.MEMBER_KEY = D.MEMBER_KEY
           AND A.ORDER_KEY = D.ORDER_KEY
           AND A.ORDER_AMOUNT = D.ORDER_AMOUNT)
   AND A.MEMBER_KEY = 1103386002;

--DIM_GOOD商品分类(TV播出商品,TV非播出商品,自营商品,BBC商品)
/*
首单为TV播出商品(FIRST_ORDER_BROADCAST)
首单为TV非播出商品(FIRST_ORDER_NOT_BROADCAST)
首单为自营商品(FIRST_ORDER_SELF)
首单为BBC商品(FIRST_ORDER_BBC)
*/
SELECT A.ITEM_CODE,
       CASE
         WHEN A.GROUP_ID = 1000 AND EXISTS
          (SELECT 1 FROM DIM_TV_GOOD B WHERE A.ITEM_CODE = B.ITEM_CODE) THEN
          'FIRST_ORDER_BROADCAST'
         WHEN A.GROUP_ID = 1000 THEN
          'FIRST_ORDER_NOT_BROADCAST'
         WHEN A.GROUP_ID = 2000 AND EXISTS (SELECT 1
                 FROM DIM_EC_GOOD C
                WHERE A.ITEM_CODE = C.ITEM_CODE
                  AND C.STORE_ID = 1) THEN
          'FIRST_ORDER_SELF'
         WHEN A.GROUP_ID = 2000 AND EXISTS (SELECT 1
                 FROM DIM_EC_GOOD C
                WHERE A.ITEM_CODE = C.ITEM_CODE
                  AND C.STORE_ID <> 1) THEN
          'FIRST_ORDER_BBC'
         ELSE
          'OTHER'
       END ITEM_LABEL
  FROM DIM_GOOD A
 WHERE A.CURRENT_FLG = 'Y';

--************************************************************************
--会员等级（member_level）
--************************************************************************   
merge into (select *
              from member_label_link
             where m_label_id in (62, 63, 64, 65, 66, 67, 68)) t
using (select member_bp,
              case
                when member_level = 'HAPP_T0' then
                 62
                when member_level = 'HAPP_T1' then
                 63
                when member_level = 'HAPP_T2' then
                 64
                when member_level = 'HAPP_T3' then
                 65
                when member_level = 'HAPP_T4' then
                 66
                when member_level = 'HAPP_T5' then
                 67
                when member_level = 'HAPP_T6' then
                 68
              end member_level_id
         from dim_member
        where ch_date_key = 20170828
          AND MEMBER_LEVEL IS NOT NULL) s
on (t.member_key = s.member_bp)
when matched then
  update set t.m_label_id = s.member_level_id, t.last_update_date = sysdate
when not matched then
  insert
    (t.member_key,
     t.m_label_id,
     t.m_label_type_id,
     t.create_date,
     t.create_user_id,
     t.last_update_date,
     t.last_update_user_id)
  values
    (s.member_bp,
     s.member_level_id,
     1,
     sysdate,
     'yangjin',
     sysdate,
     'yangjin');


--重新刷新历史数据
--jobid:1543
DECLARE
  IN_DATE_INT NUMBER(8);
  IN_DATE     DATE;
  BEGIN_DATE  DATE := DATE '2014-10-24';
  END_DATE    DATE := DATE '2017-08-28';
BEGIN
  IN_DATE := BEGIN_DATE;
  WHILE IN_DATE <= END_DATE LOOP
    IN_DATE_INT := TO_CHAR(IN_DATE, 'YYYYMMDD');
    MEMBER_LABEL_PKG.MEMBER_LEVEL(IN_DATE_INT);
    IN_DATE := IN_DATE + 1;
  END LOOP;
END;
/

SELECT COUNT(1)
  FROM MEMBER_LABEL_LINK_V A
 WHERE A.m_label_id BETWEEN 62 AND 68;

SELECT * FROM DIM_MEMBER A WHERE A.CH_DATE_KEY=20170829;
SELECT A.CH_DATE_KEY,COUNT(A.MEMBER_BP) FROM DIM_MEMBER A  WHERE A.MEMBER_LEVEL IS NOT NULL GROUP BY A.CH_DATE_KEY ORDER BY 1;
SELECT * FROM W_ETL_LOG A WHERE A.PROC_NAME='MEMBER_LABEL_PKG.MEMBER_LEVEL' ORDER BY A.START_TIME DESC;
SELECT 'CALL MEMBER_LABEL_PKG.MEMBER_LEVEL(' || B.CH_DATE_KEY || ');'
  FROM (SELECT DISTINCT A.CH_DATE_KEY
          FROM DIM_MEMBER A
         WHERE A.MEMBER_LEVEL IS NOT NULL
         ORDER BY 1) B;


--************************************************************************
--复购周期（repurchase_cycle）
--************************************************************************
DECLARE
  IN_INT NUMBER(8) := 1;
BEGIN
  WHILE IN_INT <= 1000 LOOP
    INSERT INTO YJ_TMP1
      SELECT A.MEMBER_BP,
             MEMBER_LABEL_PKG.MEMBER_REPURCHASE_CYCLE_DAYS(A.MEMBER_BP) REPURCHASE_CYCLE_DAYS
        FROM DIM_MEMBER A
       WHERE TO_NUMBER(SUBSTR(A.MEMBER_BP, -3, 3)) = IN_INT;
    COMMIT;
    IN_INT := IN_INT + 1;
  END LOOP;
END;
/

INSERT
  INTO YJ_TMP1
  SELECT A.MEMBER_BP,
         MEMBER_LABEL_PKG.MEMBER_REPURCHASE_CYCLE_DAYS(A.MEMBER_BP) REPURCHASE_CYCLE_DAYS
    FROM DIM_MEMBER A
   WHERE TO_NUMBER(SUBSTR(A.MEMBER_BP, -3, 3)) = 0;
COMMIT;

SELECT DISTINCT TO_NUMBER(SUBSTR(A.MEMBER_BP, -3, 3))
  FROM YJ_TMP1 A
 ORDER BY TO_NUMBER(SUBSTR(A.MEMBER_BP, -3, 3)) DESC;

SELECT A.REPURCHASE_CYCLE_DAYS, COUNT(A.MEMBER_BP)
  FROM YJ_TMP1 A
 --where a.repurchase_cycle_days <> -1
 GROUP BY A.REPURCHASE_CYCLE_DAYS
 ORDER BY 1;

SELECT * FROM YJ_TMP1 A WHERE A.REPURCHASE_CYCLE_DAYS = 0;
SELECT A.MEMBER_BP,
       MEMBER_LABEL_PKG.MEMBER_REPURCHASE_CYCLE_DAYS(A.MEMBER_BP) REPURCHASE_CYCLE_DAYS
  FROM DIM_MEMBER A
 WHERE A.MEMBER_BP = 605032002;

SELECT A.MEMBER_KEY,
       TO_DATE(A.POSTING_DATE_KEY, 'yyyymmdd') POSTING_DATE,
       A.ORDER_KEY
  FROM FACT_ORDER A
 WHERE A.ORDER_STATE = 1
   AND A.MEMBER_KEY = 604020149
 ORDER BY A.ORDER_KEY;

--tmp
SELECT * FROM MEMBER_LABEL_HEAD ORDER BY M_LABEL_ID;
SELECT * FROM MEMBER_LABEL_TYPE;
SELECT * FROM MEMBER_LABEL_LINK;
SELECT * FROM MEMBER_LABEL_LINK_V;
SELECT * FROM MEMBER_LABEL_LOG;

--TV
--4027
SELECT count(distinct a.item_code) from dim_tv_good a;
select count(distinct a.item_code)
  from dim_good a
 where a.group_id = 1000
   and not exists
 (select 1 from dim_tv_good b where a.item_code = b.item_code);

--电商
select count(distinct a.item_code) from dim_ec_good a;
select count(distinct a.item_code)
  from dim_ec_good a
 where a.store_id <> 1;
select count(distinct a.item_code)
  from dim_good a
 where a.group_id = 2000
   and not exists
 (select 1 from dim_ec_good b where a.item_code = b.item_code);

SELECT distinct a.group_id, a.group_name FROM Dim_Good a;
SELECT COUNT(DISTINCT A.ITEM_CODE)
  FROM DIM_GOOD A
 WHERE A.GROUP_ID NOT IN (1000, 2000);
SELECT DISTINCT A.POSTING_DATE_KEY
  FROM FACT_GOODS_SALES A
 WHERE NOT EXISTS (SELECT 1
          FROM (select distinct a.item_code
                  from dim_good a
                 where a.group_id = 2000
                   and not exists
                 (select 1
                          from dim_ec_good b
                         where a.item_code = b.item_code)) B
         WHERE A.GOODS_COMMON_KEY = B.ITEM_CODE);
--5118556662
SELECT A.MEMBER_KEY,
       A.ORDER_KEY,
       A.ORDER_DATE_KEY,
       A.POSTING_DATE_KEY,
       A.ORDER_STATE,
       A.GOODS_COMMON_KEY,
       A.ORDER_AMOUNT
  FROM FACT_GOODS_SALES A
 WHERE A.MEMBER_KEY = 1105532572
 ORDER BY 2;

SELECT DISTINCT a.m_label_id, A.m_label_name, A.m_label_desc
  FROM MEMBER_LABEL_LINK_V A;

SELECT * FROM MEMBER_LABEL_HEAD FOR UPDATE;

--1168
SELECT * FROM MEMBER_LABEL_HEAD ORDER BY M_LABEL_ID FOR UPDATE;
SELECT A.m_label_id, A.m_label_name, A.m_label_desc, COUNT(1)
  FROM MEMBER_LABEL_LINK_V A
 WHERE A.m_label_name LIKE 'FIRST_ORDER%'
 GROUP BY A.m_label_id, A.m_label_name, A.m_label_desc
 ORDER BY A.m_label_id;
SELECT *
  FROM W_ETL_LOG A
 WHERE A.PROC_NAME LIKE 'MEMBER_LABEL_PKG.FIRST_ORDER%'
 ORDER BY A.START_TIME DESC;

SELECT A.MEMBER_KEY, COUNT(1)
  FROM MEMBER_LABEL_LINK A
 WHERE A.M_LABEL_ID BETWEEN 42 AND 47
 GROUP BY A.MEMBER_KEY
HAVING COUNT(1) > 1;
SELECT *
  FROM MEMBER_LABEL_LINK_V A
 WHERE A.M_LABEL_ID BETWEEN 42 AND 47
   AND A.member_key IN (1101196655);
SELECT * FROM MEMBER_LABEL_LINK_BAK;

DELETE MEMBER_LABEL_LINK A WHERE A.M_LABEL_ID BETWEEN 42 AND 47;
COMMIT;

SELECT *
  from member_label_link_v a
 where a.m_label_id between 42 and 47
 order by a.last_update_date desc;

SELECT count(1)
  from member_label_link_v a
 where a.m_label_id between 42 and 47;

SELECT a.member_key, count(1)
  from member_label_link_v a
 where a.m_label_id between 42 and 47
 group by a.member_key
having count(1) > 1;

SELECT *
  FROM MEMBER_LABEL_LINK_V A
 WHERE A.member_key = 1610734215
   AND A.m_label_id BETWEEN 42 AND 47;
