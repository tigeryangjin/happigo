CREATE OR REPLACE PACKAGE GOODS_LABEL_PKG IS

  -- AUTHOR  : YANGJIN
  -- CREATED : 2017-09-21 14:40:49
  -- PURPOSE : 商品标签PACKAGE

  PROCEDURE CREATE_GOODS_LABEL(IN_G_LABEL_NAME      IN VARCHAR2,
                               IN_G_LABEL_DESC      IN VARCHAR2,
                               IN_G_LABEL_TYPE_ID   IN NUMBER,
                               IN_IS_LEAF_NODE      IN NUMBER,
                               IN_G_LABEL_FATHER_ID IN NUMBER);
  /*
  功能名:       CREATE_GOODS_LABEL
  目的:         新建标签插入GOODS_LABEL_HEAD
  作者:         YANGJIN
  创建时间：    2017/09/21
  最后修改人：
  最后更改日期：
  */

  PROCEDURE DISTRIBUTION_TYPE;
  /*
  功能名:       DISTRIBUTION_TYPE
  目的:         配送方式(仓配(快乐购)，直配送(供应商))
  作者:         yangjin
  创建时间：    2018/04/23
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOOD_PRICE_RANGE;
  /*
  功能名:       GOOD_PRICE_RANGE
  目的:         0~50
                50~100
                100~200
                200~300
                300~400
                400~500
                500~600
                600~800
                800~1000
                1000~1500
                1500~2000
                2000~3000
                3000以上
  
  作者:         yangjin
  创建时间：    2018/04/23
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOODS_HOT_SEASON(IN_DATE_KEY IN NUMBER);
  /*
  功能名:       GOODS_HOT_SEASON
  目的:         商品标签-热销季节
              从2016年开始计算，每过完一年，就计算2016到去年的合计。原来的标签全部清除，重新计算。
              GOODS_HOT_SEASON_SPRING,商品热销季节-春,自然年内所属物料细类销量占全年60%以上位于（1~4月）
              GOODS_HOT_SEASON_SUMMER,商品热销季节-夏,自然年内所属物料细类销量占全年60%以上位于（4~7月）
              GOODS_HOT_SEASON_AUTUMN,商品热销季节-秋,自然年内所属物料细类销量占全年60%以上位于（7~10月）
              GOODS_HOT_SEASON_WINTER,商品热销季节-冬,自然年内所属物料细类销量占全年60%以上位于（10~1月）
  作者:         yangjin
  创建时间：    2018/05/24
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOODS_TRAFFIC_LEVEL(IN_DATE_KEY IN NUMBER);
  /*
  功能名:       GOODS_TRAFFIC_LEVEL
  目的:         商品标签-流量情况
                统计最近30天
                HIGH_TRAFFIC-高流量-月度UV超过1000
                MEDIUM_TRAFFIC-一般流量-月度UV介于101~999
                LOW_TRAFFIC-低流量-月度UV低于100
  作者:         yangjin
  创建时间：    2018/05/28
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOODS_CVR(IN_DATE_KEY IN NUMBER);
  /*
  功能名:       GOODS_CVR
  目的:         商品标签-转化率
                统计最近30天
                HIGH_CVR-高转化率-月度转化率高于2.5%
                MEDIUM_CVR-一般转化率-月度转化率介于1.0%~2.5%
                LOW_CVR-低转化率-月度转化率低于1.0%
  作者:         yangjin
  创建时间：    2018/05/28
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOODS_FIRST_ON_SELL_TIME(IN_DATE_KEY IN NUMBER);
  /*
  功能名:       GOODS_FIRST_ON_SELL_TIME
  目的:         商品标签-新品标签
                15_DAYS_TO_30DAYS-商品首次上架时间在（15天以上30天以下）-1073
                7_DAYS_TO_15_DAYS-商品首次上架时间在（7天以上15天以下）-1074
                WITHIN_7_DAYS-商品首次上架时间在（7天以下）-1075
  作者:         yangjin
  创建时间：    2018/05/29
  最后修改人：
  最后更改日期：
  */

  PROCEDURE GOODS_MATXXL_PRICE_LEVEL(IN_DATE_KEY IN NUMBER);
  /*
  功能名:       GOODS_MATXXL_PRICE_LEVEL
  目的:         商品标签-所属细类价格区间
  作者:         yangjin
  创建时间：    2018/05/29
  最后修改人：
  最后更改日期：
  */

END GOODS_LABEL_PKG;
/
CREATE OR REPLACE PACKAGE BODY GOODS_LABEL_PKG IS

  PROCEDURE CREATE_GOODS_LABEL(IN_G_LABEL_NAME      IN VARCHAR2,
                               IN_G_LABEL_DESC      IN VARCHAR2,
                               IN_G_LABEL_TYPE_ID   IN NUMBER,
                               IN_IS_LEAF_NODE      IN NUMBER,
                               IN_G_LABEL_FATHER_ID IN NUMBER) IS
    /*
    功能说明：新建标签插入GOODS_LABEL_HEAD
    作者时间：YANGJIN  2017-09-21
    */
  BEGIN
    BEGIN
      INSERT INTO GOODS_LABEL_HEAD
        (G_LABEL_ID,
         G_LABEL_NAME,
         G_LABEL_DESC,
         G_LABEL_TYPE_ID,
         IS_LEAF_NODE,
         G_LABEL_FATHER_ID,
         CREATE_DATE,
         CREATE_USER_ID,
         LAST_UPDATE_DATE,
         LAST_UPDATE_USER_ID,
         CURRENT_FLAG)
        SELECT GOODS_LABEL_HEAD_SEQ.NEXTVAL, /*G_LABEL_ID*/
               IN_G_LABEL_NAME, /*G_LABEL_NAME*/
               IN_G_LABEL_DESC, /*G_LABEL_DESC*/
               IN_G_LABEL_TYPE_ID, /*G_LABEL_TYPE_ID*/
               IN_IS_LEAF_NODE, /*是否叶节点*/
               IN_G_LABEL_FATHER_ID, /*G_LABEL_FATHER_ID*/
               SYSDATE, /*CREATE_DATE*/
               'yangjin', /*CREATE_USER_ID*/
               SYSDATE, /*LAST_UPDATE_DATE*/
               'yangjin', /*LAST_UPDATE_USER_ID*/
               1 /*CURRENT_FLAG*/
          FROM DUAL;
      COMMIT;
    END;
  END CREATE_GOODS_LABEL;

  PROCEDURE DISTRIBUTION_TYPE IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-04-23
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.DISTRIBUTION_TYPE'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*打上标签*/
      /*
      DISTRIBUTION_TYPE_KLG:配送方式_仓配(快乐购)
      DISTRIBUTION_TYPE_SUPPLIER:配送方式_直配送(供应商)
      */
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID BETWEEN 22 AND 23) T
      USING (SELECT B.ITEM_CODE,
                    C.G_LABEL_ID,
                    C.G_LABEL_TYPE_ID,
                    SYSDATE CREATE_DATE,
                    'yangjin' CREATE_USER_ID,
                    SYSDATE LAST_UPDATE_DATE,
                    'yangjin' LAST_UPDATE_USER_ID
               FROM (SELECT A.ITEM_CODE,
                            CASE
                              WHEN A.IS_SHIPPING_SELF = 1 THEN
                               'DISTRIBUTION_TYPE_KLG'
                              WHEN A.IS_SHIPPING_SELF = 0 THEN
                               'DISTRIBUTION_TYPE_SUPPLIER'
                            END DISTRIBUTION_TYPE
                       FROM DIM_EC_GOOD A
                      WHERE A.IS_SHIPPING_SELF IS NOT NULL) B,
                    GOODS_LABEL_HEAD C
              WHERE B.DISTRIBUTION_TYPE = C.G_LABEL_NAME) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           1,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除标签/
      /*
      DISTRIBUTION_TYPE_KLG:配送方式_仓配(快乐购)
      DISTRIBUTION_TYPE_SUPPLIER:配送方式_直配送(供应商)
      */
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID BETWEEN 22 AND 23
         AND NOT EXISTS (SELECT 1
                FROM (SELECT A.ITEM_CODE,
                             CASE
                               WHEN A.IS_SHIPPING_SELF = 1 THEN
                                22
                               WHEN A.IS_SHIPPING_SELF = 0 THEN
                                23
                             END G_LABEL_ID
                        FROM DIM_EC_GOOD A
                       WHERE A.IS_SHIPPING_SELF IS NOT NULL) B
               WHERE A.ITEM_CODE = B.ITEM_CODE
                 AND A.G_LABEL_ID = B.G_LABEL_ID);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '无输入参数';
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END DISTRIBUTION_TYPE;

  PROCEDURE GOOD_PRICE_RANGE IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-04-23
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOOD_PRICE_RANGE'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*打上标签*/
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID IN (25,
                                    26,
                                    27,
                                    28,
                                    29,
																		999,
                                    1000,
                                    1001,
                                    1002,
                                    1003,
                                    1004,
                                    1005,
                                    1006)) T
      USING (SELECT B.ITEM_CODE,
                    C.G_LABEL_ID,
                    C.G_LABEL_TYPE_ID,
                    SYSDATE CREATE_DATE,
                    'yangjin' CREATE_USER_ID,
                    SYSDATE LAST_UPDATE_DATE,
                    'yangjin' LAST_UPDATE_USER_ID
               FROM (SELECT A.ITEM_CODE,
                            A.GOODS_PRICE,
                            CASE
                              WHEN A.GOODS_PRICE >= 0 AND A.GOODS_PRICE < 50 THEN
                               'GOODS_PRICE_RANGE_0_50'
                              WHEN A.GOODS_PRICE >= 50 AND A.GOODS_PRICE < 100 THEN
                               'GOODS_PRICE_RANGE_50_100'
                              WHEN A.GOODS_PRICE >= 100 AND
                                   A.GOODS_PRICE < 200 THEN
                               'GOODS_PRICE_RANGE_100_200'
                              WHEN A.GOODS_PRICE >= 200 AND
                                   A.GOODS_PRICE < 300 THEN
                               'GOODS_PRICE_RANGE_200_300'
                              WHEN A.GOODS_PRICE >= 300 AND
                                   A.GOODS_PRICE < 400 THEN
                               'GOODS_PRICE_RANGE_300_400'
                              WHEN A.GOODS_PRICE >= 400 AND
                                   A.GOODS_PRICE < 500 THEN
                               'GOODS_PRICE_RANGE_400_500'
                              WHEN A.GOODS_PRICE >= 500 AND
                                   A.GOODS_PRICE < 600 THEN
                               'GOODS_PRICE_RANGE_500_600'
                              WHEN A.GOODS_PRICE >= 600 AND
                                   A.GOODS_PRICE < 800 THEN
                               'GOODS_PRICE_RANGE_600_800'
                              WHEN A.GOODS_PRICE >= 800 AND
                                   A.GOODS_PRICE < 1000 THEN
                               'GOODS_PRICE_RANGE_800_1000'
                              WHEN A.GOODS_PRICE >= 1000 AND
                                   A.GOODS_PRICE < 1500 THEN
                               'GOODS_PRICE_RANGE_1000_1500'
                              WHEN A.GOODS_PRICE >= 1500 AND
                                   A.GOODS_PRICE < 2000 THEN
                               'GOODS_PRICE_RANGE_1500_2000'
                              WHEN A.GOODS_PRICE >= 2000 AND
                                   A.GOODS_PRICE < 3000 THEN
                               'GOODS_PRICE_RANGE_2000_3000'
                              WHEN A.GOODS_PRICE >= 3000 THEN
                               'GOODS_PRICE_RANGE_MORE_THAN_3000'
                            END GOODS_PRICE_RANGE
                       FROM DIM_EC_GOOD A) B,
                    GOODS_LABEL_HEAD C
              WHERE B.GOODS_PRICE_RANGE = C.G_LABEL_NAME) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           1,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除标签*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN
             (25, 26, 27, 28, 29, 1000, 1001, 1002, 1003, 1004, 1005, 1006)
         AND NOT EXISTS
       (SELECT 1
                FROM (SELECT B.ITEM_CODE, C.G_LABEL_ID
                        FROM (SELECT A.ITEM_CODE,
                                     A.GOODS_PRICE,
                                     CASE
                                       WHEN A.GOODS_PRICE >= 0 AND
                                            A.GOODS_PRICE < 50 THEN
                                        'GOODS_PRICE_RANGE_0_50'
                                       WHEN A.GOODS_PRICE >= 50 AND
                                            A.GOODS_PRICE < 100 THEN
                                        'GOODS_PRICE_RANGE_50_100'
                                       WHEN A.GOODS_PRICE >= 100 AND
                                            A.GOODS_PRICE < 200 THEN
                                        'GOODS_PRICE_RANGE_100_200'
                                       WHEN A.GOODS_PRICE >= 200 AND
                                            A.GOODS_PRICE < 300 THEN
                                        'GOODS_PRICE_RANGE_200_300'
                                       WHEN A.GOODS_PRICE >= 300 AND
                                            A.GOODS_PRICE < 400 THEN
                                        'GOODS_PRICE_RANGE_300_400'
                                       WHEN A.GOODS_PRICE >= 400 AND
                                            A.GOODS_PRICE < 500 THEN
                                        'GOODS_PRICE_RANGE_400_500'
                                       WHEN A.GOODS_PRICE >= 500 AND
                                            A.GOODS_PRICE < 600 THEN
                                        'GOODS_PRICE_RANGE_500_600'
                                       WHEN A.GOODS_PRICE >= 600 AND
                                            A.GOODS_PRICE < 800 THEN
                                        'GOODS_PRICE_RANGE_600_800'
                                       WHEN A.GOODS_PRICE >= 800 AND
                                            A.GOODS_PRICE < 1000 THEN
                                        'GOODS_PRICE_RANGE_800_1000'
                                       WHEN A.GOODS_PRICE >= 1000 AND
                                            A.GOODS_PRICE < 1500 THEN
                                        'GOODS_PRICE_RANGE_1000_1500'
                                       WHEN A.GOODS_PRICE >= 1500 AND
                                            A.GOODS_PRICE < 2000 THEN
                                        'GOODS_PRICE_RANGE_1500_2000'
                                       WHEN A.GOODS_PRICE >= 2000 AND
                                            A.GOODS_PRICE < 3000 THEN
                                        'GOODS_PRICE_RANGE_2000_3000'
                                       WHEN A.GOODS_PRICE >= 3000 THEN
                                        'GOODS_PRICE_RANGE_MORE_THAN_3000'
                                     END GOODS_PRICE_RANGE
                                FROM DIM_EC_GOOD A) B,
                             GOODS_LABEL_HEAD C
                       WHERE B.GOODS_PRICE_RANGE = C.G_LABEL_NAME) B
               WHERE A.ITEM_CODE = B.ITEM_CODE
                 AND A.G_LABEL_ID = B.G_LABEL_ID);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '无输入参数';
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOOD_PRICE_RANGE;

  PROCEDURE GOODS_HOT_SEASON(IN_DATE_KEY IN NUMBER) IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    IN_YEAR_KEY NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-04-23
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOODS_HOT_SEASON'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
    /*上一年key*/
    IN_YEAR_KEY := TO_CHAR(TRUNC(TO_DATE(IN_DATE_KEY, 'YYYYMMDD'), 'YYYY') - 1,
                           'YYYY');
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*中间表*/
      DELETE GOODS_LABEL_1041_STAGE A WHERE A.YEAR_KEY = IN_YEAR_KEY;
      COMMIT;
    
      INSERT INTO GOODS_LABEL_1041_STAGE
        (YEAR_KEY, MONTH_KEY, MATL_GROUP, QTY, W_INSERT_DT, W_UPDATE_DT)
        SELECT C.YEAR_KEY,
               C.MONTH_KEY,
               E.MATL_GROUP,
               SUM(C.QTY) QTY,
               SYSDATE W_INSERT_DT,
               SYSDATE W_UPDATE_DT
          FROM (SELECT TO_CHAR(A.ADD_TIME, 'YYYY') YEAR_KEY,
                       TO_CHAR(A.ADD_TIME, 'MM') MONTH_KEY,
                       B.GOODS_COMMONID,
                       SUM(B.GOODS_NUM) QTY
                  FROM FACT_EC_ORDER_2 A, FACT_EC_ORDER_GOODS B
                 WHERE A.ORDER_ID = B.ORDER_ID
                   AND A.ORDER_STATE >= 20
                   AND TO_CHAR(A.ADD_TIME, 'YYYY') = IN_YEAR_KEY
                 GROUP BY TO_CHAR(A.ADD_TIME, 'YYYY'),
                          TO_CHAR(A.ADD_TIME, 'MM'),
                          B.GOODS_COMMONID) C,
               (SELECT D.ITEM_CODE, D.GOODS_COMMONID, D.MATL_GROUP
                  FROM DIM_GOOD D
                 WHERE D.CURRENT_FLG = 'Y'
                   AND D.GOODS_COMMONID <> 0) E
         WHERE C.GOODS_COMMONID = E.GOODS_COMMONID
         GROUP BY C.YEAR_KEY, C.MONTH_KEY, E.MATL_GROUP
         ORDER BY C.YEAR_KEY, C.MONTH_KEY, E.MATL_GROUP;
      COMMIT;
    
      /*中间表A*/
      EXECUTE IMMEDIATE 'TRUNCATE TABLE GOODS_LABEL_1041_STAGE_A';
    
      INSERT INTO GOODS_LABEL_1041_STAGE_A
        (MATL_GROUP, COL1, COL2, COL3, COL4, W_INSERT_DT, W_UPDATE_DT)
        SELECT C.MATL_GROUP,
               CASE
                 WHEN C.SPRING_QTY >= C.TOTAL_QTY * 0.6 THEN
                  'GOODS_HOT_SEASON_SPRING'
               END COL1,
               CASE
                 WHEN C.SUMMER_QTY >= C.TOTAL_QTY * 0.6 THEN
                  'GOODS_HOT_SEASON_SUMMER'
               END COL2,
               CASE
                 WHEN C.AUTUMN_QTY >= C.TOTAL_QTY * 0.6 THEN
                  'GOODS_HOT_SEASON_AUTUMN'
               END COL3,
               CASE
                 WHEN C.WINTER_QTY >= C.TOTAL_QTY * 0.6 THEN
                  'GOODS_HOT_SEASON_WINTER'
               END COL4,
               SYSDATE W_INSERT_DT,
               SYSDATE W_UPDATE_DT
          FROM (SELECT B.MATL_GROUP,
                       SUM(SPRING_QTY) SPRING_QTY,
                       SUM(SUMMER_QTY) SUMMER_QTY,
                       SUM(AUTUMN_QTY) AUTUMN_QTY,
                       SUM(WINTER_QTY) WINTER_QTY,
                       SUM(TOTAL_QTY) TOTAL_QTY
                  FROM (SELECT A.MATL_GROUP,
                               CASE
                                 WHEN A.MONTH_KEY IN ('01', '02', '03', '04') THEN
                                  A.QTY
                                 ELSE
                                  0
                               END SPRING_QTY,
                               CASE
                                 WHEN A.MONTH_KEY IN ('04', '05', '06', '07') THEN
                                  A.QTY
                                 ELSE
                                  0
                               END SUMMER_QTY,
                               CASE
                                 WHEN A.MONTH_KEY IN ('07', '08', '09', '10') THEN
                                  A.QTY
                                 ELSE
                                  0
                               END AUTUMN_QTY,
                               CASE
                                 WHEN A.MONTH_KEY IN ('10', '11', '12', '01') THEN
                                  A.QTY
                                 ELSE
                                  0
                               END WINTER_QTY,
                               A.QTY TOTAL_QTY
                          FROM GOODS_LABEL_1041_STAGE A) B
                 GROUP BY B.MATL_GROUP) C
         ORDER BY C.MATL_GROUP;
    
      /*插入商品标签表*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN (1042, 1043, 1044, 1045);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      INSERT INTO GOODS_LABEL_LINK
        (ITEM_CODE,
         G_LABEL_ID,
         G_LABEL_TYPE_ID,
         CREATE_DATE,
         CREATE_USER_ID,
         LAST_UPDATE_DATE,
         LAST_UPDATE_USER_ID,
         ROW_ID)
        SELECT G.ITEM_CODE,
               H.G_LABEL_ID,
               H.G_LABEL_TYPE_ID,
               SYSDATE CREATE_DATE,
               'yangjin' CREATE_USER_ID,
               SYSDATE LAST_UPDATE_DATE,
               'yangjin' LAST_UPDATE_USER_ID,
               GOODS_LABEL_LINK_SEQ.NEXTVAL
          FROM (SELECT F.ITEM_CODE, E.COL1
                  FROM (SELECT A.MATL_GROUP, A.COL1
                          FROM GOODS_LABEL_1041_STAGE_A A
                         WHERE A.COL1 IS NOT NULL
                        UNION ALL
                        SELECT B.MATL_GROUP, B.COL2
                          FROM GOODS_LABEL_1041_STAGE_A B
                         WHERE B.COL2 IS NOT NULL
                        UNION ALL
                        SELECT C.MATL_GROUP, C.COL3
                          FROM GOODS_LABEL_1041_STAGE_A C
                         WHERE C.COL3 IS NOT NULL
                        UNION ALL
                        SELECT D.MATL_GROUP, D.COL4
                          FROM GOODS_LABEL_1041_STAGE_A D
                         WHERE D.COL4 IS NOT NULL) E,
                       DIM_GOOD F
                 WHERE E.MATL_GROUP = F.MATL_GROUP
                   AND F.CURRENT_FLG = 'Y') G,
               GOODS_LABEL_HEAD H
         WHERE G.COL1 = H.G_LABEL_NAME;
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数IN_DATE_KEY:' || IN_DATE_KEY;
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOODS_HOT_SEASON;

  PROCEDURE GOODS_TRAFFIC_LEVEL(IN_DATE_KEY IN NUMBER) IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-05-28
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOODS_TRAFFIC_LEVEL'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*中间表*/
      EXECUTE IMMEDIATE 'TRUNCATE TABLE GOODS_LABEL_1050_STAGE';
    
      INSERT INTO GOODS_LABEL_1050_STAGE
        (ITEM_CODE, G_LABEL_ID, G_LABEL_TYPE_ID, W_INSERT_DT, W_UPDATE_DT)
        SELECT C.ITEM_CODE,
               D.G_LABEL_ID,
               D.G_LABEL_TYPE_ID,
               SYSDATE           W_INSERT_DT,
               SYSDATE           W_UPDATE_DT
          FROM (SELECT B.ITEM_CODE,
                       B.UV,
                       CASE
                         WHEN B.UV BETWEEN 0 AND 100 THEN
                          'LOW_TRAFFIC'
                         WHEN B.UV BETWEEN 101 AND 999 THEN
                          'MEDIUM_TRAFFIC'
                         WHEN B.UV >= 1000 THEN
                          'HIGH_TRAFFIC'
                       END TRAFFIC_LEVEL
                  FROM (SELECT A.PAGE_VALUE ITEM_CODE,
                               COUNT(DISTINCT A.VID) UV
                          FROM FACT_PAGE_VIEW A
                         WHERE A.VISIT_DATE_KEY BETWEEN
                               TO_CHAR(TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 30,
                                       'YYYYMMDD') AND IN_DATE_KEY /*最近一个月*/
                           AND UPPER(A.PAGE_NAME) = 'GOOD'
                              /*商品编码长度：6*/
                           AND LENGTH(A.PAGE_VALUE) = 6
                              /*全数字*/
                           AND A.PAGE_VALUE =
                               TRANSLATE(A.PAGE_VALUE,
                                         '0' || TRANSLATE(A.PAGE_VALUE,
                                                          '#0123456789',
                                                          '#'),
                                         '0')
                         GROUP BY A.PAGE_VALUE) B) C,
               GOODS_LABEL_HEAD D
         WHERE C.TRAFFIC_LEVEL = D.G_LABEL_NAME;
      COMMIT;
    
      /*Merge商品标签表*/
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID IN (1051, 1052, 1053)) T
      USING (SELECT ITEM_CODE, G_LABEL_ID, G_LABEL_TYPE_ID
               FROM GOODS_LABEL_1050_STAGE) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           S.G_LABEL_TYPE_ID,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除商品标签,如果商品没有流量则删除标签*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN (1051, 1052, 1053)
         AND NOT EXISTS (SELECT 1
                FROM GOODS_LABEL_1050_STAGE B
               WHERE A.ITEM_CODE = B.ITEM_CODE);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数IN_DATE_KEY:' || IN_DATE_KEY;
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOODS_TRAFFIC_LEVEL;

  PROCEDURE GOODS_CVR(IN_DATE_KEY IN NUMBER) IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-05-28
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOODS_CVR'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*中间表*/
      EXECUTE IMMEDIATE 'TRUNCATE TABLE GOODS_LABEL_1059_STAGE';
    
      INSERT INTO GOODS_LABEL_1059_STAGE
        (ITEM_CODE, CVR, CVR_LEVEL, W_INSERT_DT, W_UPDATE_DT)
        SELECT H.ITEM_CODE,
               G.CVR,
               CASE
                 WHEN G.CVR BETWEEN 0 AND 0.01 THEN
                  'GOODS_LOW_CVR'
                 WHEN G.CVR BETWEEN 0.01 AND 0.025 THEN
                  'GOODS_MEDIUM_CVR'
                 WHEN G.CVR > 0.025 THEN
                  'GOODS_HIGH_CVR'
               END CVR_LEVEL,
               SYSDATE W_INSERT_DT,
               SYSDATE W_UPDATE_DT
          FROM (SELECT E.GOODS_COMMONID,
                       E.UV,
                       NVL(F.ORDER_MEMBER_CNT, 0),
                       ROUND(NVL(F.ORDER_MEMBER_CNT, 0) / E.UV, 2) CVR
                  FROM (SELECT B.GOODS_COMMONID, B.UV
                          FROM (SELECT A.PAGE_VALUE GOODS_COMMONID,
                                       COUNT(DISTINCT A.VID) UV
                                  FROM FACT_PAGE_VIEW A
                                 WHERE A.VISIT_DATE_KEY BETWEEN
                                       TO_CHAR(TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 30,
                                               'YYYYMMDD') AND IN_DATE_KEY
                                   AND UPPER(A.PAGE_NAME) = 'GOOD'
                                   AND A.PAGE_VALUE =
                                       TRANSLATE(A.PAGE_VALUE,
                                                 '0' || TRANSLATE(A.PAGE_VALUE,
                                                                  '#0123456789',
                                                                  '#'),
                                                 '0')
                                 GROUP BY A.PAGE_VALUE) B) E,
                       (SELECT D.GOODS_COMMONID,
                               COUNT(DISTINCT C.CUST_NO) ORDER_MEMBER_CNT
                          FROM FACT_EC_ORDER_2 C, FACT_EC_ORDER_GOODS D
                         WHERE C.ORDER_ID = D.ORDER_ID
                           AND C.ORDER_STATE >= 20
                           AND C.ADD_TIME BETWEEN
                               TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 30 AND
                               TO_DATE(IN_DATE_KEY, 'YYYYMMDD')
                         GROUP BY D.GOODS_COMMONID) F
                 WHERE E.GOODS_COMMONID = F.GOODS_COMMONID(+)) G,
               DIM_EC_GOOD H
         WHERE G.GOODS_COMMONID = H.GOODS_COMMONID
           AND H.STORE_ID = 1;
      COMMIT;
    
      /*Merge商品标签表*/
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID IN (1060, 1061, 1062)) T
      USING (SELECT B.ITEM_CODE, C.G_LABEL_ID, C.G_LABEL_TYPE_ID
               FROM GOODS_LABEL_1059_STAGE B, GOODS_LABEL_HEAD C
              WHERE B.CVR_LEVEL = C.G_LABEL_NAME
                AND C.G_LABEL_ID IN (1060, 1061, 1062)) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           S.G_LABEL_TYPE_ID,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除商品标签,如果商品没有流量则删除标签*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN (1060, 1061, 1062)
         AND NOT EXISTS (SELECT 1
                FROM GOODS_LABEL_1059_STAGE B
               WHERE A.ITEM_CODE = B.ITEM_CODE);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数IN_DATE_KEY:' || IN_DATE_KEY;
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOODS_CVR;

  PROCEDURE GOODS_FIRST_ON_SELL_TIME(IN_DATE_KEY IN NUMBER) IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-05-28
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOODS_FIRST_ON_SELL_TIME'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*中间表*/
      EXECUTE IMMEDIATE 'TRUNCATE TABLE GOODS_LABEL_1072_STAGE';
    
      INSERT INTO GOODS_LABEL_1072_STAGE
        (ITEM_CODE, FIRSTONSELLTIME, FIRST_LEVEL, W_INSERT_DT, W_UPDATE_DT)
        SELECT A.ITEM_CODE,
               TRUNC(A.FIRSTONSELLTIME) FIRSTONSELLTIME,
               CASE
                 WHEN TRUNC(A.FIRSTONSELLTIME) >
                      TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 7 THEN
                  'WITHIN_7_DAYS'
                 WHEN TRUNC(A.FIRSTONSELLTIME) <=
                      TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 7 AND
                      TRUNC(A.FIRSTONSELLTIME) >=
                      TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 15 THEN
                  '7_DAYS_TO_15_DAYS'
                 WHEN TRUNC(A.FIRSTONSELLTIME) <
                      TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 15 AND
                      TRUNC(A.FIRSTONSELLTIME) >=
                      TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 30 THEN
                  '15_DAYS_TO_30DAYS'
               END FIRST_LEVEL,
               SYSDATE W_INSERT_DT,
               SYSDATE W_UPDATE_DT
          FROM FACT_EC_GOODS_COMMON A
         WHERE TRUNC(A.FIRSTONSELLTIME) >=
               TO_DATE(IN_DATE_KEY, 'YYYYMMDD') - 30;
      COMMIT;
    
      /*Merge商品标签表*/
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID IN (1073, 1074, 1075)) T
      USING (SELECT B.ITEM_CODE, C.G_LABEL_ID, C.G_LABEL_TYPE_ID
               FROM GOODS_LABEL_1072_STAGE B, GOODS_LABEL_HEAD C
              WHERE B.FIRST_LEVEL = C.G_LABEL_NAME
                AND C.G_LABEL_ID IN (1073, 1074, 1075)) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           S.G_LABEL_TYPE_ID,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除商品标签,如果商品没有流量则删除标签*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN (1073, 1074, 1075)
         AND NOT EXISTS (SELECT 1
                FROM GOODS_LABEL_1059_STAGE B
               WHERE A.ITEM_CODE = B.ITEM_CODE);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数IN_DATE_KEY:' || IN_DATE_KEY;
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOODS_FIRST_ON_SELL_TIME;

  PROCEDURE GOODS_MATXXL_PRICE_LEVEL(IN_DATE_KEY IN NUMBER) IS
    S_ETL       W_ETL_LOG%ROWTYPE;
    SP_NAME     S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS NUMBER;
    DELETE_ROWS NUMBER;
    /*
    功能说明：  
    作者时间：yangjin  2018-05-28
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOODS_MATXXL_PRICE_LEVEL'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := '没有找到对应的过程加载类型数据';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
    
      /*Merge商品标签表*/
      MERGE /*+APPEND*/
      INTO (SELECT A.ROW_ID,
                   A.ITEM_CODE,
                   A.G_LABEL_ID,
                   A.G_LABEL_TYPE_ID,
                   A.CREATE_DATE,
                   A.CREATE_USER_ID,
                   A.LAST_UPDATE_DATE,
                   A.LAST_UPDATE_USER_ID
              FROM GOODS_LABEL_LINK A
             WHERE A.G_LABEL_ID IN (1077, 1078, 1079)) T
      USING (SELECT C.ITEM_CODE, D.G_LABEL_ID, D.G_LABEL_TYPE_ID
               FROM (SELECT B.ITEM_CODE,
                            B.GOOD_PRICE_LEVEL || '_MATXXL_PRICE_LEVEL' GOODS_MATXXL_PRICE_LEVEL
                       FROM DIM_GOOD B
                      WHERE B.CURRENT_FLG = 'Y'
                        AND B.GOOD_PRICE_LEVEL IS NOT NULL) C,
                    GOODS_LABEL_HEAD D
              WHERE C.GOODS_MATXXL_PRICE_LEVEL = D.G_LABEL_NAME
                AND D.G_LABEL_ID IN (1077, 1078, 1079)) S
      ON (T.ITEM_CODE = S.ITEM_CODE)
      WHEN MATCHED THEN
        UPDATE
           SET T.G_LABEL_ID          = S.G_LABEL_ID,
               T.G_LABEL_TYPE_ID     = S.G_LABEL_TYPE_ID,
               T.LAST_UPDATE_DATE    = SYSDATE,
               T.LAST_UPDATE_USER_ID = 'yangjin'
      WHEN NOT MATCHED THEN
        INSERT
          (T.ROW_ID,
           T.ITEM_CODE,
           T.G_LABEL_ID,
           T.G_LABEL_TYPE_ID,
           T.CREATE_DATE,
           T.CREATE_USER_ID,
           T.LAST_UPDATE_DATE,
           T.LAST_UPDATE_USER_ID)
        VALUES
          (GOODS_LABEL_LINK_SEQ.NEXTVAL,
           S.ITEM_CODE,
           S.G_LABEL_ID,
           S.G_LABEL_TYPE_ID,
           SYSDATE,
           'yangjin',
           SYSDATE,
           'yangjin');
      INSERT_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
      /*删除商品标签,如果商品没有流量则删除标签*/
      DELETE GOODS_LABEL_LINK A
       WHERE A.G_LABEL_ID IN (1073, 1074, 1075)
         AND NOT EXISTS
       (SELECT 1
                FROM (SELECT C.ITEM_CODE, D.G_LABEL_ID, D.G_LABEL_TYPE_ID
                        FROM (SELECT B.ITEM_CODE,
                                     B.GOOD_PRICE_LEVEL ||
                                     '_MATXXL_PRICE_LEVEL' GOODS_MATXXL_PRICE_LEVEL
                                FROM DIM_GOOD B
                               WHERE B.CURRENT_FLG = 'Y'
                                 AND B.GOOD_PRICE_LEVEL IS NOT NULL) C,
                             GOODS_LABEL_HEAD D
                       WHERE C.GOODS_MATXXL_PRICE_LEVEL = D.G_LABEL_NAME
                         AND D.G_LABEL_ID IN (1077, 1078, 1079)) E
               WHERE A.ITEM_CODE = E.ITEM_CODE);
      DELETE_ROWS := SQL%ROWCOUNT;
      COMMIT;
    
    END;
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数IN_DATE_KEY:' || IN_DATE_KEY;
    S_ETL.ETL_DURATION   := TRUNC((S_ETL.END_TIME - S_ETL.START_TIME) *
                                  86400);
    SP_SBI_W_ETL_LOG(S_ETL);
  EXCEPTION
    WHEN OTHERS THEN
      S_ETL.END_TIME   := SYSDATE;
      S_ETL.ETL_STATUS := 'FAILURE';
      S_ETL.ERR_MSG    := SQLERRM;
      SP_SBI_W_ETL_LOG(S_ETL);
      RETURN;
  END GOODS_MATXXL_PRICE_LEVEL;

END GOODS_LABEL_PKG;
/
