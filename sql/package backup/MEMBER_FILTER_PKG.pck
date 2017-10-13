CREATE OR REPLACE PACKAGE MEMBER_FILTER_PKG IS

  -- AUTHOR  : YANGJIN
  -- CREATED : 2017-08-03
  -- PURPOSE : MEMBER SMS POOL PACKAGE

  PROCEDURE SYNC_MEMBER_LABEL_HEAD(IN_SYNC_DATE_KEY IN NUMBER);
  /*
  功能名:       SYNC_MEMBER_LABEL_HEAD
  目的:         MEMBER_LABEL_HEAD同步
  作者:         yangjin
  创建时间：    2017/10/10
  最后修改人：
  最后更改日期：
  */

  PROCEDURE SYNC_MEMBER_LABEL_LINK(IN_SYNC_DATE_KEY IN NUMBER);
  /*
  功能名:       SYNC_MEMBER_LABEL_LINK
  目的:         MEMBER_LABEL_HEAD同步
  作者:         yangjin
  创建时间：    2017/10/10
  最后修改人：
  最后更改日期：
  */

END MEMBER_FILTER_PKG;
/
CREATE OR REPLACE PACKAGE BODY MEMBER_FILTER_PKG IS

  PROCEDURE SYNC_MEMBER_LABEL_HEAD(IN_SYNC_DATE_KEY IN NUMBER) IS
    S_ETL        W_ETL_LOG%ROWTYPE;
    SP_NAME      S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER  S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS  NUMBER;
    UPDATE_ROWS  NUMBER;
    IN_SYNC_DATE DATE;
    /*
       目的:      同步27上的member_label_head
       作者:      yangjin
       创建时间:  2017/10/10
    */
  BEGIN
    SP_NAME          := 'MEMBER_FILTER_PKG.SYNC_MEMBER_LABEL_HEAD'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'MEMBER_LABEL_HEAD'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
    IN_SYNC_DATE     := TO_DATE(IN_SYNC_DATE_KEY, 'YYYYMMDD');
  
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
    /*同步MEMBER_LABEL_HEAD*/
    /*先插入到临时表*/
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MEMBER_LABEL_HEAD_TMP';
    INSERT INTO MEMBER_LABEL_HEAD_TMP
      SELECT A.M_LABEL_ID,
             A.M_LABEL_NAME,
             A.M_LABEL_DESC,
             A.M_LABEL_TYPE_ID,
             A.M_LABEL_FATHER_ID,
             A.CREATE_DATE,
             A.CREATE_USER_ID,
             A.LAST_UPDATE_DATE,
             A.LAST_UPDATE_USER_ID,
             A.CURRENT_FLAG,
             A.SORT_FIELD
        FROM MEMBER_LABEL_HEAD@DW27 A
       WHERE TRUNC(A.LAST_UPDATE_DATE) = TRUNC(IN_SYNC_DATE);
    COMMIT;
  
    /*分析临时表*/
    DBMS_STATS.GATHER_TABLE_STATS('ML', 'MEMBER_LABEL_HEAD_TMP');
  
    /*插入到正式表*/
    MERGE /*+APPEND*/
    INTO MEMBER_LABEL_HEAD T
    USING MEMBER_LABEL_HEAD_TMP S
    ON (T.M_LABEL_ID = S.M_LABEL_ID)
    WHEN MATCHED THEN
      UPDATE
         SET T.M_LABEL_NAME        = S.M_LABEL_NAME,
             T.M_LABEL_DESC        = S.M_LABEL_DESC,
             T.M_LABEL_TYPE_ID     = S.M_LABEL_TYPE_ID,
             T.M_LABEL_FATHER_ID   = S.M_LABEL_FATHER_ID,
             T.CREATE_DATE         = S.CREATE_DATE,
             T.CREATE_USER_ID      = S.CREATE_USER_ID,
             T.LAST_UPDATE_DATE    = S.LAST_UPDATE_DATE,
             T.LAST_UPDATE_USER_ID = S.LAST_UPDATE_USER_ID,
             T.CURRENT_FLAG        = S.CURRENT_FLAG,
             T.SORT_FIELD          = S.SORT_FIELD
    WHEN NOT MATCHED THEN
      INSERT
        (T.M_LABEL_ID,
         T.M_LABEL_NAME,
         T.M_LABEL_DESC,
         T.M_LABEL_TYPE_ID,
         T.M_LABEL_FATHER_ID,
         T.CREATE_DATE,
         T.CREATE_USER_ID,
         T.LAST_UPDATE_DATE,
         T.LAST_UPDATE_USER_ID,
         T.CURRENT_FLAG,
         T.SORT_FIELD)
      VALUES
        (S.M_LABEL_ID,
         S.M_LABEL_NAME,
         S.M_LABEL_DESC,
         S.M_LABEL_TYPE_ID,
         S.M_LABEL_FATHER_ID,
         S.CREATE_DATE,
         S.CREATE_USER_ID,
         S.LAST_UPDATE_DATE,
         S.LAST_UPDATE_USER_ID,
         S.CURRENT_FLAG,
         S.SORT_FIELD);
    INSERT_ROWS := SQL%ROWCOUNT;
    COMMIT;
  
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_UPD := UPDATE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数:IN_SYNC_DATE_KEY:' ||
                            TO_CHAR(IN_SYNC_DATE_KEY);
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
  END SYNC_MEMBER_LABEL_HEAD;

  PROCEDURE SYNC_MEMBER_LABEL_LINK(IN_SYNC_DATE_KEY IN NUMBER) IS
    S_ETL        W_ETL_LOG%ROWTYPE;
    SP_NAME      S_PARAMETERS2.PNAME%TYPE;
    S_PARAMETER  S_PARAMETERS1.PARAMETER_VALUE%TYPE;
    INSERT_ROWS  NUMBER;
    UPDATE_ROWS  NUMBER;
    IN_SYNC_DATE DATE;
    /*
       目的:      同步27上的member_label_link
       作者:      yangjin
       创建时间:  2017/10/10
    */
  BEGIN
    SP_NAME          := 'MEMBER_FILTER_PKG.SYNC_MEMBER_LABEL_LINK'; --需要手工填入所写PROCEDURE的名称
    S_ETL.TABLE_NAME := 'MEMBER_LABEL_LINK'; --此处需要手工录入该PROCEDURE操作的表格
    S_ETL.PROC_NAME  := SP_NAME;
    S_ETL.START_TIME := SYSDATE;
    S_PARAMETER      := 0;
    IN_SYNC_DATE     := TO_DATE(IN_SYNC_DATE_KEY, 'YYYYMMDD');
  
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
    /*同步MEMBER_LABEL_LINK数据*/
    /*先插入临时表*/
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MEMBER_LABEL_LINK_TMP';
    INSERT INTO MEMBER_LABEL_LINK_TMP
      SELECT A.ROW_ID,
             A.MEMBER_KEY,
             A.M_LABEL_ID,
             A.M_LABEL_TYPE_ID,
             A.CREATE_DATE,
             A.CREATE_USER_ID,
             A.LAST_UPDATE_DATE,
             A.LAST_UPDATE_USER_ID
        FROM MEMBER_LABEL_LINK@DW27 A
       WHERE A.ROW_ID IS NOT NULL
         AND TRUNC(A.LAST_UPDATE_DATE) = TRUNC(IN_SYNC_DATE);
    COMMIT;
  
    /*分析临时表*/
    DBMS_STATS.GATHER_TABLE_STATS('ML', 'MEMBER_LABEL_LINK_TMP');
  
    /*插入到正式表*/
    MERGE /*+APPEND*/
    INTO MEMBER_LABEL_LINK T
    USING MEMBER_LABEL_LINK_TMP S
    ON (T.ROW_ID = S.ROW_ID)
    WHEN MATCHED THEN
      UPDATE
         SET T.MEMBER_KEY          = S.MEMBER_KEY,
             T.M_LABEL_ID          = S.M_LABEL_ID,
             T.M_LABEL_TYPE_ID     = S.M_LABEL_TYPE_ID,
             T.CREATE_DATE         = S.CREATE_DATE,
             T.CREATE_USER_ID      = S.CREATE_USER_ID,
             T.LAST_UPDATE_DATE    = S.LAST_UPDATE_DATE,
             T.LAST_UPDATE_USER_ID = S.LAST_UPDATE_USER_ID
    WHEN NOT MATCHED THEN
      INSERT
        (T.ROW_ID,
         T.MEMBER_KEY,
         T.M_LABEL_ID,
         T.M_LABEL_TYPE_ID,
         T.CREATE_DATE,
         T.CREATE_USER_ID,
         T.LAST_UPDATE_DATE,
         T.LAST_UPDATE_USER_ID)
      VALUES
        (S.ROW_ID,
         S.MEMBER_KEY,
         S.M_LABEL_ID,
         S.M_LABEL_TYPE_ID,
         S.CREATE_DATE,
         S.CREATE_USER_ID,
         S.LAST_UPDATE_DATE,
         S.LAST_UPDATE_USER_ID);
    INSERT_ROWS := SQL%ROWCOUNT;
    COMMIT;
  
    /*日志记录模块*/
    S_ETL.END_TIME       := SYSDATE;
    S_ETL.ETL_RECORD_INS := INSERT_ROWS;
    S_ETL.ETL_RECORD_UPD := UPDATE_ROWS;
    S_ETL.ETL_STATUS     := 'SUCCESS';
    S_ETL.ERR_MSG        := '输入参数:IN_SYNC_DATE_KEY:' ||
                            TO_CHAR(IN_SYNC_DATE_KEY);
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
  END SYNC_MEMBER_LABEL_LINK;

END MEMBER_FILTER_PKG;
/
