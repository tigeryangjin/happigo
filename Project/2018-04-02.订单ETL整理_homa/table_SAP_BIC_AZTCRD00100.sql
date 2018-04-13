-- Create table
create table SAP_BIC_AZTCRD00100
(
  crm_obj_id       VARCHAR2(100),
  crm_numint       VARCHAR2(100),
  recordmode       VARCHAR2(100),
  "/BIC/ZEAMC008"  VARCHAR2(100),
  crm_ohguid       VARCHAR2(100),
  crm_itmgui       VARCHAR2(100),
  crm_prctyp       VARCHAR2(100),
  "/BIC/ZCRMD023"  VARCHAR2(100),
  crm_itmtyp       VARCHAR2(100),
  "/BIC/ZTCMC002"  VARCHAR2(100),
  "/BIC/ZTCMC006"  VARCHAR2(100),
  salesorg         VARCHAR2(100),
  distr_chan       VARCHAR2(100),
  sales_off        VARCHAR2(100),
  division         VARCHAR2(100),
  "/BIC/ZMATERIAL" VARCHAR2(100),
  "/BIC/ZEAMC027"  VARCHAR2(100),
  "/BIC/ZLIFNR"    VARCHAR2(100),
  crm_endcst       VARCHAR2(100),
  "/BIC/ZTCMC016"  VARCHAR2(100),
  age              VARCHAR2(100),
  "/BIC/ZTCMC020"  VARCHAR2(100),
  crm_soldto       VARCHAR2(100),
  "/BIC/ZKUNNR_L1" VARCHAR2(100),
  "/BIC/ZKUNNR_L2" VARCHAR2(100),
  "/BIC/ZTHRC015"  VARCHAR2(100),
  bp_emplo         VARCHAR2(100),
  "/BIC/ZTHRC016"  VARCHAR2(100),
  "/BIC/ZTHRC017"  VARCHAR2(100),
  "/BIC/ZESDC113"  VARCHAR2(100),
  crmpostdat       VARCHAR2(100),
  "/BIC/ZPST_TIM"  VARCHAR2(100),
  "/BIC/ZGZ_TIME"  VARCHAR2(100),
  "/BIC/ZCRMD001"  VARCHAR2(100),
  crm_usstat       VARCHAR2(100),
  crm_stsma        VARCHAR2(100),
  crm_ctd_by       VARCHAR2(100),
  crm_crd_at       VARCHAR2(100),
  crea_time        VARCHAR2(100),
  "/BIC/ZEAMC001"  VARCHAR2(100),
  "/BIC/ZEAMC010"  VARCHAR2(100),
  "/BIC/ZEAMC011"  VARCHAR2(100),
  "/BIC/ZEAMC012"  VARCHAR2(100),
  "/BIC/ZEAMC037"  VARCHAR2(100),
  "/BIC/ZEAMC013"  VARCHAR2(100),
  "/BIC/ZEAMC014"  VARCHAR2(100),
  "/BIC/ZTCMC021"  VARCHAR2(100),
  "/BIC/ZTCMC022"  VARCHAR2(100),
  "/BIC/ZTCMC027"  VARCHAR2(100),
  "/BIC/ZTCMC026"  VARCHAR2(100),
  "/BIC/ZTCMC030"  VARCHAR2(100),
  "/BIC/ZTCMC007"  VARCHAR2(100),
  "/BIC/ZTCMC008"  VARCHAR2(100),
  "/BIC/ZTCMC009"  VARCHAR2(100),
  "/BIC/ZTCMC023"  VARCHAR2(100),
  "/BIC/ZTCMC024"  VARCHAR2(100),
  "/BIC/ZTCMC025"  VARCHAR2(100),
  "/BIC/ZCRMD015"  VARCHAR2(100),
  "/BIC/ZCRMD016"  VARCHAR2(100),
  "/BIC/ZCRMD017"  VARCHAR2(100),
  "/BIC/ZCRMD018"  VARCHAR2(100),
  "/BIC/ZCR_ON"    VARCHAR2(100),
  "/BIC/ZOBJ_CC"   VARCHAR2(100),
  "/BIC/ZDSXD"     VARCHAR2(100),
  "/BIC/ZJSJF_YN"  VARCHAR2(100),
  "/BIC/ZCRMD025"  VARCHAR2(100),
  "/BIC/ZCRMD020"  VARCHAR2(100),
  "/BIC/ZCRMD021"  VARCHAR2(100),
  "/BIC/ZTCRMC01"  VARCHAR2(100),
  "/BIC/ZTCRMC02"  VARCHAR2(100),
  "/BIC/ZTCRMC03"  VARCHAR2(100),
  "/BIC/ZTCRMC04"  VARCHAR2(100),
  "/BIC/ZTCRMC05"  VARCHAR2(100),
  unit             VARCHAR2(100),
  netvalord        VARCHAR2(100),
  crm_taxamo       VARCHAR2(100),
  grsvalord        VARCHAR2(100),
  "/BIC/ZAMK0011"  VARCHAR2(100),
  "/BIC/ZAMK0010"  VARCHAR2(100),
  "/BIC/ZCRMK006"  VARCHAR2(100),
  "/BIC/ZCRMK007"  VARCHAR2(100),
  "/BIC/ZCRMK009"  VARCHAR2(100),
  crm_srvkb        VARCHAR2(100),
  "/BIC/ZCRMK003"  VARCHAR2(100),
  "/BIC/ZCRMK004"  VARCHAR2(100),
  "/BIC/ZCRMK005"  VARCHAR2(100),
  "/BIC/ZYF_PAY"   VARCHAR2(100),
  "/BIC/ZXY_PAY"   VARCHAR2(100),
  "/BIC/ZNPT_ATM"  VARCHAR2(100),
  crm_numofi       VARCHAR2(100),
  "/BIC/ZAMK0024"  VARCHAR2(100),
  "/BIC/ZCRMK008"  VARCHAR2(100),
  sales_unit       VARCHAR2(100),
  currency         VARCHAR2(100),
  crm_curren       VARCHAR2(100),
  "/BIC/ZCRMD031"  VARCHAR2(100),
  "/BIC/ZEHRC012"  VARCHAR2(100),
  "/BIC/ZCRMD048"  VARCHAR2(100),
  "/BIC/ZCRMD086"  VARCHAR2(100),
  "/BIC/ZCRMD019"  VARCHAR2(100),
  "/BIC/ZTHRC027"  VARCHAR2(100),
  "/BIC/ZTHRC026"  VARCHAR2(100),
  "/BIC/ZTHRC025"  VARCHAR2(100),
  "/BIC/ZTCRMC11"  VARCHAR2(100),
  "/BIC/ZCRMD199"  VARCHAR2(100),
  "/BIC/ZTLEC001"  VARCHAR2(100),
  "/BIC/ZCONDK001" VARCHAR2(100),
  "/BIC/ZCRMD120"  VARCHAR2(100),
  changed_by       VARCHAR2(100),
  "/BIC/ZMATER2"   VARCHAR2(100),
  "/BIC/ZZTRANSF"  VARCHAR2(100),
  "/BIC/ZTMSTAMP"  VARCHAR2(100)
)
tablespace ODSDATA01
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table SAP_BIC_AZTCRD00100
  is 'CRM订购单';
-- Add comments to the columns 
comment on column SAP_BIC_AZTCRD00100.crm_obj_id
  is '交易编号';
comment on column SAP_BIC_AZTCRD00100.crm_numint
  is '项目编号订单凭证';
comment on column SAP_BIC_AZTCRD00100.recordmode
  is '更新模式';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC008"
  is '删除标记';
comment on column SAP_BIC_AZTCRD00100.crm_ohguid
  is 'GUID CRM订单对象';
comment on column SAP_BIC_AZTCRD00100.crm_itmgui
  is 'CRM项目全球唯一标识';
comment on column SAP_BIC_AZTCRD00100.crm_prctyp
  is '业务交易类型';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD023"
  is '上级项目编号';
comment on column SAP_BIC_AZTCRD00100.crm_itmtyp
  is '项目交易类型';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC002"
  is 'CRM参考订单号';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC006"
  is 'CRM参考订单行';
comment on column SAP_BIC_AZTCRD00100.salesorg
  is '销售组织';
comment on column SAP_BIC_AZTCRD00100.distr_chan
  is '分销渠道';
comment on column SAP_BIC_AZTCRD00100.sales_off
  is '销售办公室';
comment on column SAP_BIC_AZTCRD00100.division
  is '部门';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZMATERIAL"
  is '商品';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC027"
  is '员工-MD';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZLIFNR"
  is '寄售商品的供应商';
comment on column SAP_BIC_AZTCRD00100.crm_endcst
  is '终端客户';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC016"
  is '会员等级';
comment on column SAP_BIC_AZTCRD00100.age
  is '以年表示的年龄';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC020"
  is '四级地址_镇编码';
comment on column SAP_BIC_AZTCRD00100.crm_soldto
  is '售达方';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZKUNNR_L1"
  is '渠道客户第一层（通路）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZKUNNR_L2"
  is '渠道客户第二层（子通路）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC015"
  is 'HR所属部门';
comment on column SAP_BIC_AZTCRD00100.bp_emplo
  is '负责员工（BP）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC016"
  is 'HR所属班组';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC017"
  is 'HR所属处室';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZESDC113"
  is '日期（字符）';
comment on column SAP_BIC_AZTCRD00100.crmpostdat
  is '过账日期';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZPST_TIM"
  is '过账时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZGZ_TIME"
  is '过账时间戳（自定义）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD001"
  is '订购状态（订单级）';
comment on column SAP_BIC_AZTCRD00100.crm_usstat
  is '用户状态';
comment on column SAP_BIC_AZTCRD00100.crm_stsma
  is '状态参数文件';
comment on column SAP_BIC_AZTCRD00100.crm_ctd_by
  is '事务创建人';
comment on column SAP_BIC_AZTCRD00100.crm_crd_at
  is '创建日期';
comment on column SAP_BIC_AZTCRD00100.crea_time
  is '时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC001"
  is '单元编号';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC010"
  is '直播/重播';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC011"
  is '单元开始日期';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC012"
  is '单元结束日期';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC037"
  is '单元开始时段';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC013"
  is '单元开始时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEAMC014"
  is '单元结束时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC021"
  is '交换（退货）取消日期';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC022"
  is '交换（退货）取消时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC027"
  is '参考过账时间';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC026"
  is '参考过账日期';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC030"
  is '参考负责员工';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC007"
  is '表示：部分取消/退货/换货';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC008"
  is '退货类型';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC009"
  is '换货类型';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC023"
  is '货物状态';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC024"
  is '一级原因';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCMC025"
  is '二级原因';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD015"
  is '橱窗标识';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD016"
  is 'IVR标识';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD017"
  is '订单支付状态';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD018"
  is '订单来源';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCR_ON"
  is '创建时间戳';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZOBJ_CC"
  is '外呼单号（CRM）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZDSXD"
  is '定时下单时间戳（自定义）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZJSJF_YN"
  is '标示：已计算积分';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD025"
  is '预定购时间戳';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD020"
  is '礼券活动编号（CRM）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD021"
  is '标示：虚拟心意卡已自动充值';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC01"
  is 'CRM订购日期（权责制）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC02"
  is 'CRM订购时间戳（权责制）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC03"
  is 'CRM订购日期字符（权责制）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC04"
  is 'CRM订单编号（权责制）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC05"
  is 'CRM订购单行项目（权责制）';
comment on column SAP_BIC_AZTCRD00100.unit
  is '计量单位';
comment on column SAP_BIC_AZTCRD00100.netvalord
  is '订单：净值';
comment on column SAP_BIC_AZTCRD00100.crm_taxamo
  is '税金额';
comment on column SAP_BIC_AZTCRD00100.grsvalord
  is '总值';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZAMK0011"
  is '订购金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZAMK0010"
  is '订购数量';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK006"
  is '折扣金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK007"
  is '券金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK009"
  is '售价金额';
comment on column SAP_BIC_AZTCRD00100.crm_srvkb
  is '成本：金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK003"
  is '应付金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK004"
  is '已付金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK005"
  is '使用积分';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZYF_PAY"
  is '预付款金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZXY_PAY"
  is '心意卡支付金额';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZNPT_ATM"
  is '不计积分金额';
comment on column SAP_BIC_AZTCRD00100.crm_numofi
  is '凭证项目数';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZAMK0024"
  is '节目单元延长时长';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMK008"
  is '采购价格（成本价）';
comment on column SAP_BIC_AZTCRD00100.sales_unit
  is '销售单元';
comment on column SAP_BIC_AZTCRD00100.currency
  is '货币';
comment on column SAP_BIC_AZTCRD00100.crm_curren
  is '货币';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD031"
  is '业务交易类型（权责制）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZEHRC012"
  is '历史记录标志';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD048"
  is '原订单项目交易类型(TAN主品,TANN赠品,REN主品退货,RENN赠品退货)';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD086"
  is '400订单标记';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD019"
  is '发货地点（CRM）';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC027"
  is '原HR所属处室';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC026"
  is '原HR所属班组';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTHRC025"
  is '原HR所属部门';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTCRMC11"
  is '原订单_TM';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD199"
  is '预订购标志';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTLEC001"
  is '仓库';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCONDK001"
  is '定价-条件值';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZCRMD120"
  is 'CPS分销商编号';
comment on column SAP_BIC_AZTCRD00100.changed_by
  is '更改人';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZMATER2"
  is '对应关联母品';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZZTRANSF"
  is '标示：特种配送标记';
comment on column SAP_BIC_AZTCRD00100."/BIC/ZTMSTAMP"
  is '时间戳（自定义）';
-- Create/Recreate indexes 
create index IDX_SAP_BIC_ZTCRMC02 on SAP_BIC_AZTCRD00100 ("/BIC/ZTCRMC02")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_AZTCRD001_01_TP_CRMPOSTDAT on SAP_BIC_AZTCRD00100 (CRMPOSTDAT)
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_AZTCRD001_01_TP_ITEM on SAP_BIC_AZTCRD00100 ("/BIC/ZMATERIAL")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_AZTCRD001_01_TP_ZTCMC021 on SAP_BIC_AZTCRD00100 ("/BIC/ZTCMC021")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_AZTCRD001_01_TP_ZTCMC022 on SAP_BIC_AZTCRD00100 ("/BIC/ZTCMC022")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_AZTCRD001_ZTCRMC04 on SAP_BIC_AZTCRD00100 ("/BIC/ZTCRMC04")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_BIC_AZTCRD001_01_TP_ID on SAP_BIC_AZTCRD00100 (CRM_OBJ_ID)
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_BIC_ZKUNNR_L1 on SAP_BIC_AZTCRD00100 ("/BIC/ZKUNNR_L1")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index SAP_BIC_ZTCRMC01_01 on SAP_BIC_AZTCRD00100 ("/BIC/ZTCRMC01")
  tablespace ODSINDEX01
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select, index on SAP_BIC_AZTCRD00100 to dw_user with grant option;
/*grant select on SAP_BIC_AZTCRD00100 to BAS;
grant index on SAP_BIC_AZTCRD00100 to BAS with grant option;
grant select on SAP_BIC_AZTCRD00100 to BSP;
grant select, index on SAP_BIC_AZTCRD00100 to F_HYS with grant option;
grant select on SAP_BIC_AZTCRD00100 to F_SW with grant option;
grant select on SAP_BIC_AZTCRD00100 to F_TJ;
grant select on SAP_BIC_AZTCRD00100 to F_YB with grant option;
grant select on SAP_BIC_AZTCRD00100 to F_YW;
grant select on SAP_BIC_AZTCRD00100 to K_DS;
grant select on SAP_BIC_AZTCRD00100 to K_ZZS;*/
