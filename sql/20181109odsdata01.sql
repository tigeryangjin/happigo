--1.
SELECT A.TABLESPACE_NAME,
       A.FILE_ID,
       COUNT(1) CNT,
       SUM(A.BYTES) / 1024 / 1024 MB_BYTES
  FROM DBA_FREE_SPACE A
 WHERE A.TABLESPACE_NAME IN
       ('ODSDATA01')
 GROUP BY A.TABLESPACE_NAME, A.FILE_ID
 ORDER BY 1, 4 desc, 2;
 
SELECT * FROM DBA_TABLESPACE_FSFI_V;

--2.
select mapping.file_id,
       mapping.block_id,
       mapping.blocks,
       (mapping.blocks * tbs.block_size) / 1024 / 1024 size_mb,
       mapping.segment_name,
       mapping.segment_type,
       mapping.partition_name
  from (select file_id,
               block_id,
               blocks,
               segment_name,
               segment_type,
               partition_name,
               tablespace_name
          from dba_extents
         where tablespace_name = 'ODSDATA01'
        union all
        select file_id,
               block_id,
               blocks,
               'Free Space',
               'Free Space',
               'Free Space',
               tablespace_name
          from dba_free_space
         where tablespace_name = 'ODSDATA01') mapping,
       dba_tablespaces tbs
 where tbs.tablespace_name = mapping.tablespace_name
   and mapping.file_id = 24
 order by mapping.file_id, mapping.block_id desc;

--3.��ͨ��
SELECT B.COL1, B.OWNER, B.TABLE_NAME, B.COL2
  FROM (SELECT 1 COL1,
                A.owner,
                A.TABLE_NAME,
                'ALTER TABLE ' || A.OWNER || '.' || A.TABLE_NAME ||
                ' MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;' COL2
           FROM DBA_TABLES A
          WHERE /*A.tablespace_name = 'BDUDATA00'
            AND*/ A.PARTITIONED = 'NO'
         UNION ALL
         SELECT 2 COL1,
                A.owner,
                A.TABLE_NAME,
                'ALTER INDEX ' || A.OWNER || '.' || A.index_name ||
                ' REBUILD PARALLEL(DEGREE 4) NOLOGGING;' COL2
           FROM DBA_INDEXES A
          WHERE /*A.tablespace_name = 'BDUDATA00'                                                                                                                                                             AND*/
          A.partitioned = 'NO'
       AND A.INDEX_TYPE = 'NORMAL'
         UNION ALL
         SELECT 3 COL1,
                A.owner,
                A.TABLE_NAME,
                'ALTER INDEX ' || A.OWNER || '.' || A.index_name ||
                ' NOPARALLEL;' COL2
           FROM DBA_INDEXES A
          WHERE /*A.tablespace_name = 'BDUDATA00'
                                                                                                                                                                             AND*/
          A.partitioned = 'NO'
       AND A.INDEX_TYPE = 'NORMAL') B
 WHERE B.TABLE_NAME = 'ODS_ZTSDD101'
 ORDER BY B.OWNER, B.TABLE_NAME, B.COL1; 
 
--4.
--ODS_PAGEVIEW
ALTER TABLE ODSHAPPIGO.ODS_PAGEVIEW MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ISPROCESSED_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_PAGEVIEW_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ISPROCESSED_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ODS_PAGEVIEW_ID NOPARALLEL;

--SAP_BIC_AZTCRD00100
ALTER TABLE ODSHAPPIGO.SAP_BIC_AZTCRD00100 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZTCRMC01_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC022 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC021 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ITEM REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_SAP_BIC_ZTCRMC02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_AZTCRD001_01_TP_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC022 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC021 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZTCRMC01_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_SAP_BIC_ZTCRMC02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_BIC_AZTCRD001_01_TP_ID NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ITEM NOPARALLEL;
 
--ODS_ORDER
ALTER TABLE ODSHAPPIGO.ODS_ORDER MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_ORDER_I1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCRMD001 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC008 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC026 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_OBJ_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRM_ITMTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRDAT_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCR_ON REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC008 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC026 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCRMD001 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRM_ITMTYP NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRDAT_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCR_ON NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ODS_ORDER_I1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_OBJ_IDX NOPARALLEL;

--OD_ORDER_ITEM
ALTER TABLE ODSHAPPIGO.OD_ORDER_ITEM MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_INSERT_ID_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER_ITEM REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_06 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_03 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_06 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_03 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_INSERT_ID_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER_ITEM NOPARALLEL;

--ODS_ZBPARTNER
ALTER TABLE ODSHAPPIGO.ODS_ZBPARTNER MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CH_ON_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZBPARTNER_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZTHRC011_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZBPARTNER_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.CREATEDON_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.CH_ON_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ZTHRC011_IDX NOPARALLEL;

--OD_ORDER
ALTER TABLE ODSHAPPIGO.OD_ORDER MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_03 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_05 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_03 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_05 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER NOPARALLEL;

--ODS_ZMATERIAL
ALTER TABLE ODSHAPPIGO.ODS_ZMATERIAL MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_ERP_CODE2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_ITEM_CODE2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_KEY2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.MD_KEY2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_ERP_CODE2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_ITEM_CODE2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_KEY2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.MD_KEY2 NOPARALLEL;

--ODS_SEARCH
ALTER TABLE ODSHAPPIGO.ODS_SEARCH MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SEARCH_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SEARCH_ID NOPARALLEL;

--ODS_SHOPPINGCAR
ALTER TABLE ODSHAPPIGO.ODS_SHOPPINGCAR MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SHOPPINGCAR_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SHOPPINGCAR_ID NOPARALLEL;

--SAP_BIC_AZTCRD00100_MODIFY_TP
ALTER TABLE ODSHAPPIGO.SAP_BIC_AZTCRD00100_MODIFY_TP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ZTAM_BD_BR_FRAMESCHE
ALTER TABLE ODSHAPPIGO.ZTAM_BD_BR_FRAMESCHE MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--OD_ORDER_ITEM_TEMP1
ALTER TABLE ODSHAPPIGO.OD_ORDER_ITEM_TEMP1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_ORDER_ITEM_TEMP1_1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_ORDER_ITEM_TEMP1_1 NOPARALLEL;

--ODS_ORDER_CANCEL
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCR_ON REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_OBJ_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCMC008 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCRMD001 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_PRCTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCMC008 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCRMD001 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_PRCTYP NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCR_ON NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_OBJ_ID NOPARALLEL;

--OD_ORDER_TEMP1
ALTER TABLE ODSHAPPIGO.OD_ORDER_TEMP1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_GOOD_MD
ALTER TABLE ODSHAPPIGO.ODS_GOOD_MD MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_ITEMCODE_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_MD_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_ITEMCODE_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.OGM_MD_IDX NOPARALLEL;

--ODS_VENDOR
ALTER TABLE ODSHAPPIGO.ODS_VENDOR MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--W_ETL_LOG
ALTER TABLE ODSHAPPIGO.W_ETL_LOG MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_TOTAL
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_TOTAL MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_YJ
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_YJ MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_CM003
ALTER TABLE ODSHAPPIGO.ODS_CM003 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--OD_REASON_CODE
ALTER TABLE ODSHAPPIGO.OD_REASON_CODE MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_2
ALTER TABLE ODSHAPPIGO.ODS_ORDER_2 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD104
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD104 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_2
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_2 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_RESEAON_2
ALTER TABLE ODSHAPPIGO.ODS_RESEAON_2 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_RESEAON_1
ALTER TABLE ODSHAPPIGO.ODS_RESEAON_1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_PAY
ALTER TABLE ODSHAPPIGO.ODS_ORDER_PAY MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD101
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD101 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDER_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_1
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD101_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD101_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--S_PARAMETERS1
ALTER TABLE ODSHAPPIGO.S_PARAMETERS1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_KPI
ALTER TABLE ODSHAPPIGO.ODS_KPI MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--S_PARAMETERS2
ALTER TABLE ODSHAPPIGO.S_PARAMETERS2 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDERPAY_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDERPAY_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD104_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD104_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZMATERIAL_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZMATERIAL_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDERS
ALTER TABLE ODSHAPPIGO.ODS_ORDERS MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ID NOPARALLEL;

--ODS_ORDER_GOODS
ALTER TABLE ODSHAPPIGO.ODS_ORDER_GOODS MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_GOODS_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.REC_ID_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_GOODS_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.REC_ID_IDX NOPARALLEL;

--ODS_ZBPARTNER_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZBPARTNER_TEMP MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_1
ALTER TABLE ODSHAPPIGO.ODS_ORDER_1 MOVE TABLESPACE EXDATA PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_OBJ_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRM_ITMTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCMC026 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRDAT_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCMC026 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_CRDAT_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_OBJ_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_CRM_ITMTYP NOPARALLEL;

--************************************************************************************************************************
--************************************************************************************************************************
--************************************************************************************************************************
--5.ODSDATA
--ODS_PAGEVIEW
ALTER TABLE ODSHAPPIGO.ODS_PAGEVIEW MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ISPROCESSED_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_PAGEVIEW_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ISPROCESSED_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ODS_PAGEVIEW_ID NOPARALLEL;

--SAP_BIC_AZTCRD00100
ALTER TABLE ODSHAPPIGO.SAP_BIC_AZTCRD00100 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZTCRMC01_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC022 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC021 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ITEM REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_SAP_BIC_ZTCRMC02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_AZTCRD001_01_TP_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC022 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ZTCMC021 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_BIC_ZTCRMC01_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_SAP_BIC_ZTCRMC02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_BIC_AZTCRD001_01_TP_ID NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.SAP_AZTCRD001_01_TP_ITEM NOPARALLEL;
 
--ODS_ORDER
ALTER TABLE ODSHAPPIGO.ODS_ORDER MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_ORDER_I1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCRMD001 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC008 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC026 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_OBJ_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRM_ITMTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_CRDAT_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCR_ON REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC008 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZTCMC026 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCRMD001 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRM_ITMTYP NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_CRDAT_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_ZCR_ON NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ODS_ORDER_I1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERS_OBJ_IDX NOPARALLEL;

--OD_ORDER_ITEM
ALTER TABLE ODSHAPPIGO.OD_ORDER_ITEM MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_INSERT_ID_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER_ITEM REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_06 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_03 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_06 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_03 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_ITEM_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_INSERT_ID_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER_ITEM NOPARALLEL;

--ODS_ZBPARTNER
ALTER TABLE ODSHAPPIGO.ODS_ZBPARTNER MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CH_ON_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZBPARTNER_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZTHRC011_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ZBPARTNER_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.CREATEDON_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.CH_ON_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ZTHRC011_IDX NOPARALLEL;

--OD_ORDER
ALTER TABLE ODSHAPPIGO.OD_ORDER MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_02 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_03 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_05 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_01 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_01 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_02 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_03 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.IDX_OD_ORDER_05 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.PK_OD_ORDER NOPARALLEL;

--ODS_ZMATERIAL
ALTER TABLE ODSHAPPIGO.ODS_ZMATERIAL MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_ERP_CODE2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_ITEM_CODE2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.GOODS_KEY2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.MD_KEY2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.CREATEDON2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_ERP_CODE2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_ITEM_CODE2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.GOODS_KEY2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.MD_KEY2 NOPARALLEL;

--ODS_SEARCH
ALTER TABLE ODSHAPPIGO.ODS_SEARCH MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SEARCH_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SEARCH_ID NOPARALLEL;

--ODS_SHOPPINGCAR
ALTER TABLE ODSHAPPIGO.ODS_SHOPPINGCAR MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SHOPPINGCAR_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ODS_SHOPPINGCAR_ID NOPARALLEL;

--SAP_BIC_AZTCRD00100_MODIFY_TP
ALTER TABLE ODSHAPPIGO.SAP_BIC_AZTCRD00100_MODIFY_TP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ZTAM_BD_BR_FRAMESCHE
ALTER TABLE ODSHAPPIGO.ZTAM_BD_BR_FRAMESCHE MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--OD_ORDER_ITEM_TEMP1
ALTER TABLE ODSHAPPIGO.OD_ORDER_ITEM_TEMP1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_ORDER_ITEM_TEMP1_1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.IDX_ORDER_ITEM_TEMP1_1 NOPARALLEL;

--ODS_ORDER_CANCEL
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCR_ON REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_OBJ_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCMC008 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCRMD001 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_PRCTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDERC_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZTCMC008 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCRMD001 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_PRCTYP NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_ZCR_ON NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDERC_CRM_OBJ_ID NOPARALLEL;

--OD_ORDER_TEMP1
ALTER TABLE ODSHAPPIGO.OD_ORDER_TEMP1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_GOOD_MD
ALTER TABLE ODSHAPPIGO.ODS_GOOD_MD MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_ITEMCODE_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_MD_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.OGM_ITEMCODE_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.OGM_MD_IDX NOPARALLEL;

--ODS_VENDOR
ALTER TABLE ODSHAPPIGO.ODS_VENDOR MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--W_ETL_LOG
ALTER TABLE ODSHAPPIGO.W_ETL_LOG MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_TOTAL
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_TOTAL MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_YJ
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_YJ MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_CM003
ALTER TABLE ODSHAPPIGO.ODS_CM003 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--OD_REASON_CODE
ALTER TABLE ODSHAPPIGO.OD_REASON_CODE MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_2
ALTER TABLE ODSHAPPIGO.ODS_ORDER_2 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD104
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD104 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_2
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_2 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_RESEAON_2
ALTER TABLE ODSHAPPIGO.ODS_RESEAON_2 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_RESEAON_1
ALTER TABLE ODSHAPPIGO.ODS_RESEAON_1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_PAY
ALTER TABLE ODSHAPPIGO.ODS_ORDER_PAY MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD101
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD101 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDER_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_CANCEL_1
ALTER TABLE ODSHAPPIGO.ODS_ORDER_CANCEL_1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD101_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD101_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--S_PARAMETERS1
ALTER TABLE ODSHAPPIGO.S_PARAMETERS1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_KPI
ALTER TABLE ODSHAPPIGO.ODS_KPI MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--S_PARAMETERS2
ALTER TABLE ODSHAPPIGO.S_PARAMETERS2 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDERPAY_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ORDERPAY_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZTSDD104_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZTSDD104_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ZMATERIAL_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZMATERIAL_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDERS
ALTER TABLE ODSHAPPIGO.ODS_ORDERS MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ID REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ID NOPARALLEL;

--ODS_ORDER_GOODS
ALTER TABLE ODSHAPPIGO.ODS_ORDER_GOODS MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_GOODS_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.REC_ID_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_GOODS_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.REC_ID_IDX NOPARALLEL;

--ODS_ZBPARTNER_TEMP
ALTER TABLE ODSHAPPIGO.ODS_ZBPARTNER_TEMP MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;

--ODS_ORDER_1
ALTER TABLE ODSHAPPIGO.ODS_ORDER_1 MOVE TABLESPACE ODSDATA01 PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_OBJ_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRM_ITMTYP REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRMPOSTDAT REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L2 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L1 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCMC026 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCRMC04 REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRDAT_IDX REBUILD PARALLEL(DEGREE 4) NOLOGGING;
ALTER INDEX ODSHAPPIGO.ORDER_CRMPOSTDAT NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L2 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZKUNNR_L1 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCMC026 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_ZTCRMC04 NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_CRDAT_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_OBJ_IDX NOPARALLEL;
ALTER INDEX ODSHAPPIGO.ORDER_CRM_ITMTYP NOPARALLEL;


--tmp
SELECT A.segment_name, A.segment_type, SUM(A.BYTES) / 1024 / 1024 SIZE_MB
  FROM DBA_SEGMENTS A
 WHERE A.tablespace_name = 'ODSDATA01'
 GROUP BY A.segment_name, A.segment_type
 ORDER BY 3 DESC;
SELECT * FROM ODSHAPPIGO.MSEG;
