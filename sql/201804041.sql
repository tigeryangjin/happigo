SELECT "0CRM_OBJ_ID" CRM_OBJ_ID,
       "0CRM_NUMINT" CRM_NUMINT,
       NULL RECORDMODE,
       ZEAMC008 "/BIC/ZEAMC008",
       "0CRM_OHGUID" CRM_OHGUID,
       "0CRM_ITMGUI" CRM_ITMGUI,
       "0CRM_PRCTYP" CRM_PRCTYP,
       ZCRMD023 "/BIC/ZCRMD023",
       "0CRM_ITMTYP" CRM_ITMTYP,
       NULL "/BIC/ZTCMC002",
       '0000000000' "/BIC/ZTCMC006",
       "0SALESORG" SALESORG,
       "0DISTR_CHAN" DISTR_CHAN,
       "0SALES_OFF" SALES_OFF,
       "0DIVISION" DIVISION,
       ZMATERIAL "/BIC/ZMATERIAL",
       ZEAMC027 "/BIC/ZEAMC027",
       ZLIFNR "/BIC/ZLIFNR",
       "0CRM_ENDCST" CRM_ENDCST,
       ZTCMC016 "/BIC/ZTCMC016",
       '000' AGE,
       ZTCMC020 "/BIC/ZTCMC020",
       "0CRM_SOLDTO" CRM_SOLDTO,
       SUBSTR("0CRM_SOLDTO", 1, 3) "/BIC/ZKUNNR_L1", --ZESDD121
       "0CRM_SOLDTO" "/BIC/ZKUNNR_L2", --ZESDD121
       '00000000' "/BIC/ZTHRC015" /*HR所属部门*/,
       "0BP_EMPLO" BP_EMPLO,
       '00000000' "/BIC/ZTHRC016" /*HR所属班组*/,
       '00000000' "/BIC/ZTHRC017" /*HR所属处室*/,
       "0CRMPOSTDAT" "/BIC/ZESDC113", --
       SUBSTR("0CRMPOSTDAT", 1, 8) CRMPOSTDAT,
       ZPST_TIM "/BIC/ZPST_TIM",
       ZGZ_TIME "/BIC/ZGZ_TIME",
       ZCRMD001 "/BIC/ZCRMD001",
       "0CRM_USSTAT" CRM_USSTAT,
       "0CRM_STSMA" CRM_STSMA,
       "0CRM_CTD_BY" CRM_CTD_BY,
       "0CRM_CRD_AT" CRM_CRD_AT,
       "0CREA_TIME" CREA_TIME,
       ZEAMC001 "/BIC/ZEAMC001",
       NULL "/BIC/ZEAMC010",
       NULL "/BIC/ZEAMC011",
       NULL "/BIC/ZEAMC012",
       NULL "/BIC/ZEAMC037",
       NULL "/BIC/ZEAMC013",
       NULL "/BIC/ZEAMC014",
       '00000000' "/BIC/ZTCMC021",
       '000000' "/BIC/ZTCMC022",
       ZPST_TIM "/BIC/ZTCMC027",
       "0CRMPOSTDAT" "/BIC/ZTCMC026",
       "0BP_EMPLO" "/BIC/ZTCMC030",
       NULL "/BIC/ZTCMC007",
       NULL "/BIC/ZTCMC008",
       NULL "/BIC/ZTCMC009",
       NULL "/BIC/ZTCMC023",
       NULL "/BIC/ZTCMC024",
       NULL "/BIC/ZTCMC025",
       ZCRMD015 "/BIC/ZCRMD015",
       ZCRMD016 "/BIC/ZCRMD016",
       ZCRMD017 "/BIC/ZCRMD017",
       ZCRMD018 "/BIC/ZCRMD018",
       ZCR_ON "/BIC/ZCR_ON",
       ZOBJ_CC "/BIC/ZOBJ_CC",
       ZDSXD "/BIC/ZDSXD",
       ZJSJF_YN "/BIC/ZJSJF_YN",
       ZCRMD025 "/BIC/ZCRMD025",
       ZCRMD020 "/BIC/ZCRMD020",
       ZCRMD021 "/BIC/ZCRMD021",
       "0CRMPOSTDAT" "/BIC/ZTCRMC01",
       ZGZ_TIME "/BIC/ZTCRMC02",
       "0CRMPOSTDAT" "/BIC/ZTCRMC03", --
       "0CRM_OBJ_ID" "/BIC/ZTCRMC04",
       "0CRM_NUMINT" "/BIC/ZTCRMC05",
       NULL UNIT,
       "0NETVALORD" NETVALORD,
       "0CRM_TAXAMO" CRM_TAXAMO,
       "0GRSVALORD" GRSVALORD,
       ZAMK0011 "/BIC/ZAMK0011",
       ZAMK0010 "/BIC/ZAMK0010",
       ZCRMK006 "/BIC/ZCRMK006",
       ZCRMK007 "/BIC/ZCRMK007",
       ZCRMK009 "/BIC/ZCRMK009",
       CASE
         WHEN "0CRM_ITMTYP" IN ('RENN', 'TANN') THEN
          0
         ELSE
          ZAMK0010 * ZCRMK008
       END CRM_SRVKB, --
       ZCRMK003 "/BIC/ZCRMK003",
       ZCRMK004 "/BIC/ZCRMK004",
       ZCRMK005 "/BIC/ZCRMK005",
       ZYF_PAY "/BIC/ZYF_PAY",
       ZXY_PAY "/BIC/ZXY_PAY",
       ZNPT_ATM "/BIC/ZNPT_ATM",
       "0CRM_NUMOFI" CRM_NUMOFI,
       NULL "/BIC/ZAMK0024",
       CASE
         WHEN "0CRM_ITMTYP" IN ('RENN', 'TANN') THEN
          0
         ELSE
          ZCRMK008
       END "/BIC/ZCRMK008", --
       NULL SALES_UNIT,
       NULL CURRENCY,
       NULL CRM_CURREN,
       "0CRM_PRCTYP" "/BIC/ZCRMD031",
       NULL "/BIC/ZEHRC012",
       "0CRM_ITMTYP" "/BIC/ZCRMD048",
       ZCRMD086 "/BIC/ZCRMD086",
       ZCRMD019 "/BIC/ZCRMD019",
       NULL "/BIC/ZTHRC027",
       NULL "/BIC/ZTHRC026",
       NULL "/BIC/ZTHRC025",
       NULL "/BIC/ZTCRMC11",
       ZCRMD199 "/BIC/ZCRMD199",
       ZTLEC001 "/BIC/ZTLEC001",
       ZCONDK001 "/BIC/ZCONDK001",
       NULL "/BIC/ZCRMD120",
       "0CRM_CTD_BY" CHANGED_BY,
       ZMATERIAL "/BIC/ZMATER2" /*对应关联母品*/,
       ZZTRANSF "/BIC/ZZTRANSF",
       ZTMSTAMP "/BIC/ZTMSTAMP"
  FROM (SELECT GUID_H "0CRM_OHGUID",
               GUID_I "0CRM_ITMGUI",
               OBJECT_ID "0CRM_OBJ_ID",
               NUMBER_INT "0CRM_NUMINT",
               DELE_FLAG ZEAMC008,
               PROCESS_TYPE "0CRM_PRCTYP",
               NULL "0CRM_OBJTYP",
               NULL "0CRM_ITOBTP",
               ITM_TYPE "0CRM_ITMTYP",
               NUMBER_UP ZCRMD023,
               NULL "0CRM_SALORG",
               DIS_CHANNEL "0DISTR_CHAN",
               SUBSTR(ZGZ_TIME, 1, 8) "0CRMPOSTDAT", --
               SUBSTR(ZGZ_TIME, 9, 6) ZPST_TIM, --
               DIVISION "0DIVISION",
               NULL "0CRM_SALOFF",
               SUBSTR(CREATED_AT, 1, 8) "0CRM_CRD_AT", --
               SUBSTR(CREATED_AT, 9, 6) "0CREA_TIME", --
               CREATED_BY "0CRM_CTD_BY",
               NULL "0CRM_CHD_AT",
               NULL "0CRM_CHD_BY",
               NULL "0CRM_ITCRAT",
               NULL "0CRM_ITCRBY",
               NULL "0CRM_ITCHAT",
               NULL "0CRM_ITCHBY",
               MEDIA_ORG "0CRM_SOLDTO",
               PARTNER "0CRM_ENDCST",
               ZZTIERLEVEL ZTCMC016,
               CREATED_BY "0BP_EMPLO",
               NULL "0RECORDMODE",
               NULL "0CRM_NUMOFI",
               CURRENCY "0CURRENCY",
               ORDER_AMOUNT "0GRSVALORDH",
               PRODUCT_PROGRAM ZEAMC001,
               ZCC_IDENTIFY ZCRMD015,
               ZZIF_IVR ZCRMD016,
               ORDER_STATUS_S "0CRM_USSTAT",
               STSMA "0CRM_STSMA",
               ORDER_STATUS_U ZCRMD001,
               PAY_STATUS ZCRMD017,
               ZZORDER_ORIGIN ZCRMD018,
               NULL "0SALESORG",
               NULL "0SALES_OFF",
               ORDER_PIECE ZCRMK002,
               AMOUNT_PAYABLE ZCRMK003,
               PAID_AMOUNT ZCRMK004,
               INTEGRAL ZCRMK005,
               NULL "0SALES_UNIT",
               CREATED_AT ZCR_ON,
               NULL ZOBJ_CC,
               ZGZ_TIME,
               NULL ZDSXD,
               JSJF_YN ZJSJF_YN,
               ZYF_PAY ZYF_PAY,
               ZXY_PAY ZXY_PAY,
               NPT_ATM ZNPT_ATM,
               ZDISCOUNT_AMT ZCRMK006,
               ZCOUPON_AMT ZCRMK007,
               FROM_TIME_H ZFROM_H,
               PRODUCT_ID ZMATERIAL, --
               PRODUCT_NUM ZAMK0010,
               DC_AMT * PRODUCT_NUM ZCRMK009, --
               PRODUCT_AMT ZAMK0011,
               NULL "0UNIT",
               NULL ZCRMD019,
               ZLIFNR ZLIFNR,
               ZZTRANSF ZZTRANSF,
               ZZKBETR ZCRMK008,
               LPAD(ZZMPERNR, 8, '0') ZEAMC027,
               NULL ZFROM_I,
               DCDEGREE ZCRMD020,
               NULL ZCRMD021,
               TRANSPZONE ZTCMC020,
               ZZYD_STAMP ZCRMD025,
               ZZNET_VALUE "0NETVALORD",
               ZZTAX_AMOUNT "0CRM_TAXAMO",
               ZZGROSS_VALUE "0GRSVALORD",
               NULL "0CRM_CURREN",
               Z400_FLAG ZCRMD086,
               ZZYDGFLG ZCRMD199,
               TIMESTAMP_H ZTMSTAMP,
               WH_CODE ZTLEC001,
               FREIGHT_AMT ZCONDK001,
               NULL "0CRM_SOLDTO_0COUNTRY",
               NULL "0CRM_SOLDTO_0REGION"
          FROM (SELECT A.ORDER_NO GUID_H,
                       B.ORDER_NO || B.ORDER_GB || B.ORDER_SEQ GUID_I,
                       NVL(B.ECC_ORDER_NO, B.CRM_ORDER_NO) OBJECT_ID,
                       LPAD(B.ORDER_SEQ, 10, '0') NUMBER_INT,
                       B.ORDER_SEQ_REL NUMBER_UP,
                       DECODE(A.ORDER_TYPE,
                              'MM02',
                              'ZA01',
                              'MM03',
                              'ZA02',
                              'MM01',
                              'ZA03',
                              '') AS PROCESS_TYPE,
                       B.ITEM_GB ITM_TYPE,
                       '' ORDER_STATUS_S,
                       B.ORDER_STATE ORDER_STATUS_U,
                       DECODE(B.ISPAY, '0', '10', '1', '30') PAY_STATUS, --状态  --未支付 10;完全支付 30
                       DECODE(A.IVR_FLAG, '1', 'X', '') ZZIF_IVR, --IVR订购
                       LPAD(A.ORDER_ORIGIN, 2, '0') ZZORDER_ORIGIN, --订单来源
                       A.CUST_GRADE ZZTIERLEVEL, --会员等级(od_order中加字段）
                       B.MSALE_CODE MEDIA_ORG, --媒体分区
                       '' SALES_ORG, --销售组织标识
                       '10' DIS_CHANNEL, --分销渠道
                       '01' DIVISION, --部门
                       '' SALES_OFFICE, --销售办事处
                       A.CUST_NO PARTNER, --顾客编号
                       SUM(B.RSALE_AMT) OVER(PARTITION BY B.ORDER_NO) ORDER_AMOUNT, --订单金额
                       SUM(CASE
                             WHEN B.ITEM_GB = 'TAN' THEN
                              B.ORDER_QTY
                             ELSE
                              0
                           END) OVER(PARTITION BY B.ORDER_NO) ORDER_PIECE, --件数
                       B.RSALE_AMT AMOUNT_PAYABLE, --应付金额
                       B.RSALE_AMT PAID_AMOUNT, --已付金额
                       B.JF_AMT INTEGRAL, --使用积分
                       A.INSERT_ID CREATED_BY, --创建人
                       TO_CHAR(A.INSERT_DATE, 'YYYYMMDDHH24MISS') CREATED_AT, --创建时间
                       '' CC_OBJECT_ID, --外呼单号
                       TO_CHAR(B.ORDER_DATE, 'YYYYMMDDHH24MISS') ZGZ_TIME, --过账时间
                       '' ZDSXD, --定时下单时间
                       '' JSJF_YN, --是否已计算积分
                       B.YFK_AMT ZYF_PAY, --预付款金额
                       B.XYK_AMT ZXY_PAY, --心意卡支付金额
                       0 NPT_ATM, --不计积分金额
                       B.DC_AMT ZDISCOUNT_AMT, --折扣金额
                       B.GIFT_AMT ZCOUPON_AMT, --券金额
                       TO_CHAR(B.DELY_HOPE_DATE, 'YYYYMMDDHH24MISS') FROM_TIME_H, --请求交货日期
                       TRUNC(A.INSERT_DATE) CRDAT, --创建日期
                       LPAD(B.ITEM_CODE ||
                            DECODE(B.UNIT_CODE, '999', '', B.UNIT_CODE),
                            18,
                            '0') PRODUCT_ID, --产品 ID
                       B.ORDER_QTY PRODUCT_NUM, --数量
                       B.RSALE_AMT PRODUCT_AMT, --商品支付价
                       B.SALE_PRICE DC_AMT, --商品单价
                       B.RSALE_AMT - B.JF_AMT NPT_AMT, --不计算积分的金额
                       B.PROG_ID PRODUCT_PROGRAM, --商品节目编号
                       B.WH_CODE ZZLOCATION, --发货地点
                       B.VEN_CODE ZLIFNR, --供应商
                       '' ZZTRANSF, --特种配送标记
                       B.BUY_PRICE ZZKBETR, --采购价格(含税) 在OD_order_item表中增加字段
                       B.MD_CODE ZZMPERNR, --MD编号
                       '' FROM_TIME_I, --开始
                       DECODE(B.ORDER_REL_FLAG, '1', 'X', '') ZCC_IDENTIFY, --橱窗标识
                       '' DCDEGREE, --礼券活动编号
                       0 XYKCZ, --虚拟心意卡已自动充值
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDDHH24MISS') TIMESTAMP_H, --时间戳
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDDHH24MISS') TIMESTAMP_I, --时间戳
                       '' QTY_UNIT, --销售单位
                       '' CURRENCY, --货币
                       A.TRANSPZONE TRANSPZONE, --运输区域
                       DECODE(B.ORDER_STATE, 'TA10', 'X', '') ZZYDGFLG, --预订购标记
                       '' DELE_FLAG, --删除标记
                       0 ZZNET_VALUE, --净值
                       0 ZZTAX_AMOUNT, --税额
                       0 ZZGROSS_VALUE, --总值
                       '' ZZFCT_TYPE, --用途归类
                       '' ZZYD_STAMP, --预订购时间戳(UTC+8)
                       '' Z400_FLAG, --400订单标记
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDDHH24MISS') LAST_PROC_DATE,
                       B.FREIGHT_AMT, --运费
                       B.WH_CODE, --仓库
                       CASE
                         WHEN B.ORDER_GB = 'HM20' THEN
                          'ZORDER01'
                         WHEN B.ORDER_GB = 'HM21' THEN
                          'ZORDER05'
                         WHEN B.ORDER_GB IN ('HM30', 'HM31') THEN
                          'ZORDER02'
                         WHEN B.ORDER_GB IN ('HM41', 'HM42', 'HM45', 'HM46') THEN
                          'ZORDER03'
                       END STSMA --状态参数文件
                  FROM ODSHAPPIGO.OD_ORDER A, ODSHAPPIGO.OD_ORDER_ITEM B
                 WHERE A.ORDER_NO = B.ORDER_NO
                   AND B.ORDER_GB = 'HM20'
                   AND (B.ORDER_DATE >=
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') - 2 AND
                       B.ORDER_DATE < TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') OR
                       B.ORDER_DATE >= TO_DATE('20170101', 'YYYYMMDD') AND
                       B.LAST_PROC_DATE >=
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') - 2 AND
                       B.LAST_PROC_DATE <
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD')))) Q
UNION ALL
SELECT "0CRM_OBJ_ID" CRM_OBJ_ID,
       "0CRM_NUMINT" CRM_NUMINT,
       NULL RECORDMODE,
       ZEAMC008 "/BIC/ZEAMC008",
       "0CRM_OHGUID" CRM_OHGUID,
       "0CRM_ITMGUI" CRM_ITMGUI,
       "0CRM_PRCTYP" CRM_PRCTYP,
       ZCRMD023 "/BIC/ZCRMD023",
       "0CRM_ITMTYP" CRM_ITMTYP,
       ZTCMC002 "/BIC/ZTCMC002",
       ZTCMC006 "/BIC/ZTCMC006",
       "0SALESORG" SALESORG,
       "0DISTR_CHAN" DISTR_CHAN,
       NULL SALES_OFF,
       "0DIVISION" DIVISION,
       ZMATERIAL "/BIC/ZMATERIAL",
       ZEAMC027 "/BIC/ZEAMC027",
       ZLIFNR "/BIC/ZLIFNR",
       "0CRM_ENDCST" CRM_ENDCST,
       ZTCMC016 "/BIC/ZTCMC016",
       '000' AGE,
       ZTCMC020 "/BIC/ZTCMC020",
       "0CRM_SOLDTO" CRM_SOLDTO,
       SUBSTR("0CRM_SOLDTO", 1, 3) "/BIC/ZKUNNR_L1", --ZESDD121
       "0CRM_SOLDTO" "/BIC/ZKUNNR_L2", --ZESDD121
       '00000000' "/BIC/ZTHRC015" /*HR所属部门*/,
       "0BP_EMPLO" BP_EMPLO,
       '00000000' "/BIC/ZTHRC016" /*HR所属班组*/,
       '00000000' "/BIC/ZTHRC017" /*HR所属处室*/,
       "0CRMPOSTDAT" "/BIC/ZESDC113", --
       "0CRMPOSTDAT" CRMPOSTDAT,
       ZPST_TIM "/BIC/ZPST_TIM",
       ZGZ_TIME "/BIC/ZGZ_TIME",
       ZCRMD001 "/BIC/ZCRMD001",
       "0CRM_USSTAT" CRM_USSTAT,
       "0CRM_STSMA" CRM_STSMA,
       "0CRM_CTD_BY" CRM_CTD_BY,
       "0CRM_CRD_AT" CRM_CRD_AT,
       "0CREA_TIME" CREA_TIME,
       ZEAMC001 "/BIC/ZEAMC001",
       NULL "/BIC/ZEAMC010",
       NULL "/BIC/ZEAMC011",
       NULL "/BIC/ZEAMC012",
       NULL "/BIC/ZEAMC037",
       NULL "/BIC/ZEAMC013",
       NULL "/BIC/ZEAMC014",
       ZTCMC021 "/BIC/ZTCMC021",
       ZTCMC022 "/BIC/ZTCMC022",
       SUBSTR(B_ZGZ_TIME, 9，6) "/BIC/ZTCMC027",
       SUBSTR(B_ZGZ_TIME, 1，8) "/BIC/ZTCMC026",
       B_CREATED_BY "/BIC/ZTCMC030",
       ZTCMC007 "/BIC/ZTCMC007",
       ZTCMC008 "/BIC/ZTCMC008",
       ZTCMC009 "/BIC/ZTCMC009",
       ZTCMC023 "/BIC/ZTCMC023",
       ZTCMC024 "/BIC/ZTCMC024",
       ZTCMC025 "/BIC/ZTCMC025",
       ZCRMD015 "/BIC/ZCRMD015",
       NULL "/BIC/ZCRMD016",
       NULL "/BIC/ZCRMD017",
       NULL "/BIC/ZCRMD018",
       ZCR_ON "/BIC/ZCR_ON",
       NULL "/BIC/ZOBJ_CC",
       NULL "/BIC/ZDSXD",
       NULL "/BIC/ZJSJF_YN",
       NULL "/BIC/ZCRMD025",
       NULL "/BIC/ZCRMD020",
       NULL "/BIC/ZCRMD021",
       SUBSTR(B_ZGZ_TIME, 1，8) "/BIC/ZTCRMC01",
       B_ZGZ_TIME "/BIC/ZTCRMC02",
       SUBSTR(B_ZGZ_TIME, 1，8) "/BIC/ZTCRMC03",
       ZTCMC002 "/BIC/ZTCRMC04",
       ZTCMC006 "/BIC/ZTCRMC05",
       NULL UNIT,
       "0NETVALORD" NETVALORD,
       "0CRM_TAXAMO" CRM_TAXAMO,
       "0GRSVALORD" GRSVALORD,
       ZAMK0011 "/BIC/ZAMK0011",
       ZAMK0010 "/BIC/ZAMK0010",
       ZCRMK006 "/BIC/ZCRMK006",
       ZCRMK007 "/BIC/ZCRMK007",
       ZCRMK009 "/BIC/ZCRMK009",
       CASE
         WHEN "0CRM_ITMTYP" = 'RENN' THEN
          0
         ELSE
          ZAMK0010 * ZCRMK008
       END CRM_SRVKB, --
       NULL "/BIC/ZCRMK003",
       NULL "/BIC/ZCRMK004",
       NULL "/BIC/ZCRMK005",
       NULL "/BIC/ZYF_PAY",
       NULL "/BIC/ZXY_PAY",
       NULL "/BIC/ZNPT_ATM",
       NULL CRM_NUMOFI,
       NULL "/BIC/ZAMK0024",
       CASE
         WHEN "0CRM_ITMTYP" = 'RENN' THEN
          0
         ELSE
          ZCRMK008
       END "/BIC/ZCRMK008", --
       NULL SALES_UNIT,
       NULL CURRENCY,
       NULL CRM_CURREN,
       ZCRMD031 "/BIC/ZCRMD031",
       NULL "/BIC/ZEHRC012",
       ZCRMD048 "/BIC/ZCRMD048",
       ZCRMD086 "/BIC/ZCRMD086",
       ZCRMD019 "/BIC/ZCRMD019",
       NULL "/BIC/ZTHRC027",
       NULL "/BIC/ZTHRC026",
       NULL "/BIC/ZTHRC025",
       NULL "/BIC/ZTCRMC11",
       ZCRMD199 "/BIC/ZCRMD199",
       NULL "/BIC/ZTLEC001",
       NULL "/BIC/ZCONDK001",
       NULL "/BIC/ZCRMD120", --需接入"/BIC/AZECRD05400"
       "0CHANGED_BY" CHANGED_BY,
       ZMATERIAL "/BIC/ZMATER2" /*对应关联母品*/,
       ZZTRANSF "/BIC/ZZTRANSF",
       ZTMSTAMP "/BIC/ZTMSTAMP"
  FROM (SELECT GUID_H "0CRM_OHGUID",
               GUID_I "0CRM_ITMGUI",
               NULL "0RECORDMODE",
               XDEL ZEAMC008,
               PROCESS_TYPE "0CRM_PRCTYP",
               OBJECT_ID "0CRM_OBJ_ID",
               NUMBER_INT "0CRM_NUMINT",
               NUMBER_UP ZCRMD023,
               POSTING_DATE "0CRMPOSTDAT",
               ZGZ_TIME ZGZ_TIME,
               SUBSTR(ZGZ_TIME, 9, 6) ZPST_TIM, --
               ZZSO_ID ZTCMC002,
               ZZNUMBER_SO ZTCMC006,
               ITM_TYPE "0CRM_ITMTYP",
               STATUS_H "0CRM_USSTAT",
               TXT04 ZCRMD001,
               ZZBFXT ZTCMC007,
               CREATED_BY "0CRM_CTD_BY",
               CREATED_AT ZCR_ON,
               PARTNER "0CRM_ENDCST",
               ZZTIER_LEVEL ZTCMC016,
               NULL "0CRM_SALORG",
               NULL "0SALESORG",
               DIS_CHANNEL "0DISTR_CHAN",
               NULL "0DIVISION",
               STSMA "0CRM_STSMA",
               CURRENCY "0CURRENCY",
               ZCUS_CHANNEL "0CRM_SOLDTO",
               ZCATEGORY1 ZCRMD026,
               ZCATEGORY2 ZCRMD027,
               ZCATEGORY3 ZCRMD028,
               ZZTHLX ZTCMC008,
               ZZXSBJ ZTCMC009,
               SUBSTR(CRDAT, 1, 8) "0CRM_CRD_AT",
               CRTIM "0CREA_TIME",
               AEDAT "0CRM_CHD_AT",
               AENAM "0CHANGED_BY",
               PRODUCT_ID ZMATERIAL,
               PROD_PRICE ZCRMD029,
               ZZRET_AMMOUT ZCRMK010,
               ZDISCOUNT_AMT ZCRMK006,
               ZCOUPON_AMT ZCRMK007,
               ABS(QUANTITY) * ABS(PROD_PRICE) ZCRMK009, --
               QUANTITY ZAMK0010,
               PROD_AMOUNT ZAMK0011,
               NULL "0UNIT",
               ZZHWZT ZTCMC023,
               ZZYJYY ZTCMC024,
               ZZEJYY ZTCMC025,
               ZZPRO_UNIT ZEAMC001,
               NULL ZCRMD019,
               ZLIFNR ZLIFNR,
               ZZTRANSF ZZTRANSF,
               ZZKBETR ZCRMK008,
               LPAD(ZZMPERNR, 8, '0') ZEAMC027,
               ZCC_IDENTIFY ZCRMD015,
               CREATED_BY "0BP_EMPLO",
               TRANSPZONE ZTCMC020,
               NVL(CANCELDATE, '00000000') ZTCMC021,
               NVL(CANCELTIME, '000000') ZTCMC022,
               ZZNET_VALUE "0NETVALORD",
               ZZTAX_AMOUNT "0CRM_TAXAMO",
               ZZGROSS_VALUE "0GRSVALORD",
               NULL "0CRM_CURREN",
               ZZITM_TYPE ZCRMD048,
               ZZPROCESS_TYPE ZCRMD031,
               Z400_FLAG ZCRMD086,
               ZZYDGFLG ZCRMD199,
               TIMESTAMP_H ZTMSTAMP,
               B_ZGZ_TIME,
               B_CREATED_BY
          FROM (SELECT A.ORDER_NO GUID_H, --对象 GUID
                       B.ORDER_NO || B.ORDER_GB || B.ORDER_SEQ GUID_I, --发货前取消订单、退换货和三代服务单行项目
                       DECODE(B.ORDER_GB,
                              'HM21',
                              'ZCR1',
                              'HM30',
                              'ZB01',
                              'HM41',
                              'ZA08',
                              'HM42',
                              'ZA08') PROCESS_TYPE, --事务类型
                       NVL(B.ECC_ORDER_NO, B.CRM_ORDER_NO) OBJECT_ID, --事务编号
                       LPAD(B.ORDER_SEQ, 10, '0') NUMBER_INT, --项目
                       LPAD(B.ORDER_SEQ_REL, 10, '0') NUMBER_UP, --上级项目编号
                       (SELECT NVL(M.ECC_ORDER_NO, M.CRM_ORDER_NO)
                          FROM ODSHAPPIGO.OD_ORDER_ITEM M
                         WHERE M.ORDER_NO = A.ORDER_NO
                           AND M.ORDER_GB = 'HM20'
                           AND ROWNUM = 1) ZZSO_ID, --参考销售订单编号
                       LPAD(B.ORDER_SEQ_REL, 10, '0') ZZNUMBER_SO, --参考销售订单行项目编号
                       DECODE(B.ORDER_GB,
                              'HM41',
                              B.ITEM_GB,
                              DECODE(B.ITEM_GB,
                                     'TAN',
                                     'REN',
                                     'TANN',
                                     'RENN',
                                     B.ITEM_GB)) ITM_TYPE, --项目类别
                       B.DC_AMT ZDISCOUNT_AMT, --折扣金额
                       B.GIFT_AMT ZCOUPON_AMT, --券金额
                       B.RSALE_AMT DC_AMT, --取消和退换货金额
                       TO_CHAR(B.ORDER_DATE, 'YYYYMMDDHH24MISS') ZGZ_TIME, --过账时间
                       CASE
                         WHEN B.ORDER_GB = 'HM21' THEN
                          'E0001'
                         WHEN B.ORDER_GB IN ('HM41', 'HM42') AND
                              B.SYSLAST_QTY > 0 THEN
                          'E0003'
                         WHEN B.ORDER_GB IN ('HM41', 'HM42') AND
                              B.SYSLAST_QTY = 0 THEN
                          'E0004'
                         WHEN B.ORDER_GB = 'HM30' AND B.SYSLAST_QTY > 0 THEN
                          'E0001'
                         WHEN B.ORDER_GB = 'HM30' AND B.SYSLAST_QTY = 0 THEN
                          DECODE(B.GSTATUS, '10', 'E0003', 'E0009')
                       END STATUS_H, --用户状态
                       CASE
                         WHEN B.ORDER_GB = 'HM21' THEN
                          DECODE(B.ORDER_STATE, 'TA10', 'TA10', 'ZC01')
                         WHEN B.ORDER_GB = 'HM30' THEN
                          CASE
                            WHEN B.SYSLAST_QTY > 0 THEN
                             'ZR01'
                            ELSE
                             DECODE(B.GSTATUS, '10', 'ZR05', 'ZR07')
                          END
                         WHEN B.ORDER_GB IN ('HM41', 'HM42') THEN
                          CASE
                            WHEN B.SYSLAST_QTY > 0 THEN
                             'ZR01'
                            ELSE
                             'ZR02'
                          END
                       END TXT04, --状态
                       B.INSERT_ID CREATE_BY, --创建人
                       CASE
                         WHEN B.SYSLAST_QTY > 0 AND
                              B.SYSLAST_QTY < B.ORDER_QTY THEN
                          'X'
                         ELSE
                          ''
                       END ZZBFXT, --部分取消/退货/换货标记
                       A.TRANSPZONE TRANSPZONE, --收货人四级地址编码
                       TO_CHAR(B.ORDER_DATE, 'YYYYMMDD') POSTING_DATE, --过账日期
                       B.INSERT_ID CREATED_BY, --创建人
                       TO_CHAR(B.INSERT_DATE, 'YYYYMMDDHH24MISS') CREATED_AT, --创建时间
                       '' ZOBJECT_ID1, --销售订单号
                       A.CUST_NO PARTNER, --快乐购客户ID
                       A.CUST_GRADE ZZTIER_LEVEL, --会员等级
                       '' SALES_ORG, --销售组织标识
                       '10' DIS_CHANNEL, --分销渠道
                       B.RSALE_AMT ZZRET_AMMOUT, --取消和退换货金额
                       B.MSALE_CODE ZCUS_CHANNEL, --渠道客户
                       '' ZCATEGORY1, --一级分类
                       '' ZCATEGORY2, --二级分类
                       '' ZCATEGORY3, --三级分类
                       B.RETURN_TYPE ZZTHLX, --退货类型
                       DECODE(B.GSTATUS, '60', '20', '70', '10', '') ZZXSBJ, --换货类型
                       TO_CHAR(B.INSERT_DATE, 'YYYYMMDD') CRDAT, --创建日期
                       TO_CHAR(B.INSERT_DATE, 'HH24MISS') CRTIM, --创建时间
                       B.INSERT_ID CRNAM, --创建人
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDD') AEDAT, --更改日期
                       TO_CHAR(B.LAST_PROC_DATE, 'HH24MISS') AETIM, --上次修改时间
                       B.INSERT_ID AENAM, --更改者
                       LPAD(B.ITEM_CODE ||
                            DECODE(B.UNIT_CODE, '999', '', B.UNIT_CODE),
                            18,
                            '0') PRODUCT_ID, --产品 ID
                       B.SALE_PRICE PROD_PRICE, --产品单价
                       B.ORDER_QTY QUANTITY, --数量
                       B.RSALE_AMT PROD_AMOUNT, --产品价格
                       '' ZSTORE_LOC, --快乐购地点
                       DECODE(B.GSTATUS,
                              '05',
                              'X001',
                              '10',
                              'X002',
                              '20',
                              'X003',
                              '30',
                              'X004',
                              '60',
                              'X005',
                              '70',
                              'X006',
                              '') ZZHWZT, --货物状态
                       R.FRONT_CODE ZZYJYY, --一级原因
                       R.CODE_MGROUP ZZEJYY, --二级原因
                       B.PROG_ID ZZPRO_UNIT, --节目ID
                       B.WH_CODE ZZLOCATION, --发货地点
                       LPAD(B.VEN_CODE, 10, '0') ZLIFNR, --供应商编号
                       '' ZZTRANSF, --特种配送标识
                       B.BUY_PRICE ZZKBETR, --采购价（含税）
                       LPAD(B.MD_CODE, 8, '0') ZZMPERNR, --MD编号
                       DECODE(B.ORDER_REL_FLAG, '1', 'X', '') ZCC_IDENTIFY, --橱窗销售标记
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDDHH24MISS') TIMESTAMP_H, --时间戳
                       TO_CHAR(B.LAST_PROC_DATE, 'YYYYMMDDHH24MISS') TIMESTAMP_I, --时间戳
                       '' XDEL, --行项目删除标记
                       '' CURRENCY, --货币
                       '' QTY_UNIT, --销售单位
                       (SELECT TO_CHAR(MIN(T.ORDER_DATE), 'YYYYMMDD')
                          FROM ODSHAPPIGO.OD_ORDER_ITEM T
                         WHERE T.ORDER_NO = B.ORDER_NO
                           AND T.ORDER_GB = DECODE(B.ORDER_GB,
                                                   'HM30',
                                                   'HM31',
                                                   'HM41',
                                                   'HM45',
                                                   'HM42',
                                                   'HM46',
                                                   'HM20',
                                                   'HM21')
                           AND T.ORDER_SEQ_REL = B.ORDER_SEQ
                           AND T.ORDER_DATE >= B.ORDER_DATE) CANCELDATE, --取消日期
                       DECODE(B.ORDER_STATE, 'TA10', 'X', '') ZZYDGFLG, --预订购标记
                       (SELECT TO_CHAR(MIN(T.ORDER_DATE), 'HH24MISS')
                          FROM ODSHAPPIGO.OD_ORDER_ITEM T
                         WHERE T.ORDER_NO = B.ORDER_NO
                           AND T.ORDER_GB = DECODE(B.ORDER_GB,
                                                   'HM30',
                                                   'HM31',
                                                   'HM41',
                                                   'HM45',
                                                   'HM42',
                                                   'HM46',
                                                   'HM20',
                                                   'HM21')
                           AND T.ORDER_SEQ_REL = B.ORDER_SEQ
                           AND T.ORDER_DATE >= B.ORDER_DATE) CANCELTIME, --取消时间
                       '' ZZCANCELDATE, --原单日期
                       '' ZZCANCELTIME, --时间
                       CASE
                         WHEN B.ORDER_GB = 'HM20' THEN
                          'ZORDER01'
                         WHEN B.ORDER_GB = 'HM21' THEN
                          'ZORDER05'
                         WHEN B.ORDER_GB IN ('HM30', 'HM31') THEN
                          'ZORDER02'
                         WHEN B.ORDER_GB IN ('HM41', 'HM42', 'HM45', 'HM46') THEN
                          'ZORDER03'
                       END STSMA, --状态参数文件
                       0 ZZNET_VALUE, --净值
                       0 ZZTAX_AMOUNT, --税额
                       0 ZZGROSS_VALUE, --总值
                       (SELECT DECODE(A.ORDER_TYPE,
                                      'MM02',
                                      'ZA01',
                                      'MM03',
                                      'ZA02',
                                      'MM01',
                                      'ZA03',
                                      '')
                          FROM ODSHAPPIGO.OD_ORDER_ITEM M
                         WHERE M.ORDER_NO = B.ORDER_NO
                           AND M.ORDER_GB = 'HM20'
                           AND M.ORDER_GROUP_SEQ = B.ORDER_GROUP_SEQ
                           AND ROWNUM = 1) ZZPROCESS_TYPE, --事务类型
                       B.ITEM_GB ZZITM_TYPE, --项目类别
                       '' Z400_FLAG, --400订单标记
                       TO_CHAR(A.ORDER_DATE, 'YYYYMMDDHH24MISS') B_ZGZ_TIME,
                       A.INSERT_ID B_CREATED_BY
                  FROM ODSHAPPIGO.OD_ORDER       A,
                       ODSHAPPIGO.OD_ORDER_ITEM  B,
                       ODSHAPPIGO.OD_REASON_CODE R
                 WHERE A.ORDER_NO = B.ORDER_NO
                   AND B.ORDER_GB IN ('HM21', 'HM30', 'HM41', 'HM42')
                   AND B.ORDER_CODE = R.CODE_MGROUP(+)
                   AND (B.ORDER_DATE >=
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') - 2 AND
                       B.ORDER_DATE < TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') OR
                       B.ORDER_DATE >= TO_DATE('20170101', 'YYYYMMDD') AND
                       B.LAST_PROC_DATE >=
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD') - 2 AND
                       B.LAST_PROC_DATE <
                       TO_DATE(&V_TM_YYYYMMDD, 'YYYYMMDD')))) Q
