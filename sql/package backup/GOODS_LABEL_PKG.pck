CREATE OR REPLACE PACKAGE GOODS_LABEL_PKG IS

  -- AUTHOR  : YANGJIN
  -- CREATED : 2017-09-21 14:40:49
  -- PURPOSE : ��Ʒ��ǩPACKAGE

  PROCEDURE CREATE_GOODS_LABEL(IN_G_LABEL_NAME      IN VARCHAR2,
                               IN_G_LABEL_DESC      IN VARCHAR2,
                               IN_G_LABEL_TYPE_ID   IN NUMBER,
                               IN_G_LABEL_FATHER_ID IN NUMBER);
  /*
  ������:       CREATE_GOODS_LABEL
  Ŀ��:         �½���ǩ����GOODS_LABEL_HEAD
  ����:         YANGJIN
  ����ʱ�䣺    2017/09/21
  ����޸��ˣ�
  ���������ڣ�
  */

  PROCEDURE DISTRIBUTION_TYPE;
  /*
  ������:       DISTRIBUTION_TYPE
  Ŀ��:         ���ͷ�ʽ(����(���ֹ�)��ֱ����(��Ӧ��))
  ����:         yangjin
  ����ʱ�䣺    2018/04/23
  ����޸��ˣ�
  ���������ڣ�
  */

  PROCEDURE GOOD_PRICE_RANGE;
  /*
  ������:       GOOD_PRICE_RANGE
  Ŀ��:         ���ͷ�ʽ(����(���ֹ�)��ֱ����(��Ӧ��))
  ����:         yangjin
  ����ʱ�䣺    2018/04/23
  ����޸��ˣ�
  ���������ڣ�
  */

END GOODS_LABEL_PKG;
/
CREATE OR REPLACE PACKAGE BODY GOODS_LABEL_PKG IS

  PROCEDURE CREATE_GOODS_LABEL(IN_G_LABEL_NAME      IN VARCHAR2,
                               IN_G_LABEL_DESC      IN VARCHAR2,
                               IN_G_LABEL_TYPE_ID   IN NUMBER,
                               IN_G_LABEL_FATHER_ID IN NUMBER) IS
    /*
    ����˵�����½���ǩ����GOODS_LABEL_HEAD
    ����ʱ�䣺YANGJIN  2017-09-21
    */
  BEGIN
    BEGIN
      INSERT INTO GOODS_LABEL_HEAD
        (G_LABEL_ID,
         G_LABEL_NAME,
         G_LABEL_DESC,
         G_LABEL_TYPE_ID,
         G_LABEL_FATHER_ID,
         CREATE_DATE,
         CREATE_USER_ID,
         LAST_UPDATE_DATE,
         LAST_UPDATE_USER_ID,
         CURRENT_FLAG)
        SELECT GOODS_LABEL_HEAD_SEQ.NEXTVAL, /*M_LABEL_ID*/
               IN_G_LABEL_NAME, /*M_LABEL_NAME*/
               IN_G_LABEL_DESC, /*M_LABEL_DESC*/
               IN_G_LABEL_TYPE_ID, /*M_LABEL_TYPE_ID*/
               IN_G_LABEL_FATHER_ID, /*M_LABEL_FATHER_ID*/
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
    ����˵����  
    ����ʱ�䣺yangjin  2018-04-23
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.DISTRIBUTION_TYPE'; --��Ҫ�ֹ�������дPROCEDURE������
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --�˴���Ҫ�ֹ�¼���PROCEDURE�����ı���
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := 'û���ҵ���Ӧ�Ĺ��̼�����������';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*���ϱ�ǩ*/
      /*
      DISTRIBUTION_TYPE_KLG:���ͷ�ʽ_����(���ֹ�)
      DISTRIBUTION_TYPE_SUPPLIER:���ͷ�ʽ_ֱ����(��Ӧ��)
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
    
      /*ɾ����ǩ/
      /*
      DISTRIBUTION_TYPE_KLG:���ͷ�ʽ_����(���ֹ�)
      DISTRIBUTION_TYPE_SUPPLIER:���ͷ�ʽ_ֱ����(��Ӧ��)
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
    /*��־��¼ģ��*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '���������';
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
    ����˵����  
    ����ʱ�䣺yangjin  2018-04-23
    */
  BEGIN
    SP_NAME          := 'GOODS_LABEL_PKG.GOOD_PRICE_RANGE'; --��Ҫ�ֹ�������дPROCEDURE������
    S_ETL.TABLE_NAME := 'GOODS_LABEL_LINK'; --�˴���Ҫ�ֹ�¼���PROCEDURE�����ı���
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
  
    BEGIN
      SP_PARAMETER_TWO(SP_NAME, S_PARAMETER);
      IF S_PARAMETER = '0'
      THEN
        S_ETL.END_TIME := SYSDATE;
        S_ETL.ERR_MSG  := 'û���ҵ���Ӧ�Ĺ��̼�����������';
        SP_SBI_W_ETL_LOG(S_ETL);
        RETURN;
      END IF;
    END;
  
    BEGIN
      /*���ϱ�ǩ*/
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
    
      /*ɾ����ǩ*/
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
    /*��־��¼ģ��*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_DEL := DELETE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '���������';
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

END GOODS_LABEL_PKG;
/