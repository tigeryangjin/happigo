-- Create table
create table OPER_PRODUCT_SCAN_DLY_REPORT
(
  row_id                       NUMBER(10), 
	posting_date_key             NUMBER(10),
  sales_source_name            VARCHAR2(200),
  sales_source_second_name     VARCHAR2(200),
  own_account                  VARCHAR2(9),
  brand_name                   VARCHAR2(100),
  tran_type                    VARCHAR2(20),
  tran_type_name               VARCHAR2(12),
  item_or_gift                 VARCHAR2(6),
  matdlt                       VARCHAR2(100),
  matzlt                       VARCHAR2(100),
  matxlt                       VARCHAR2(100),
  md_person                    NUMBER(10),
  item_code                    NUMBER(10),
  goods_key                    NUMBER(20),
  goods_name                   VARCHAR2(200),
  total_order_amount           NUMBER(10,2) default 0,
  net_order_amount             NUMBER(10,2) default 0,
  effective_order_amount       NUMBER(10,2) default 0,
  cancel_order_amount          NUMBER(10,2) default 0,
  reverse_order_amount         NUMBER(10,2) default 0,
  reject_order_amount          NUMBER(10,2) default 0,
  cancel_reverse_amount        NUMBER(10,2) default 0,
  cancel_reject_amount         NUMBER(10,2) default 0,
  total_sales_amount           NUMBER(10,2) default 0,
  net_sales_amount             NUMBER(10,2) default 0,
  effective_sales_amount       NUMBER(10,2) default 0,
  total_order_member_count     NUMBER(10,2) default 0,
  net_order_member_count       NUMBER(10,2) default 0,
  effective_order_member_count NUMBER(10,2) default 0,
  cancel_order_member_count    NUMBER(10,2) default 0,
  reverse_member_count         NUMBER(10,2) default 0,
  reject_member_count          NUMBER(10,2) default 0,
  cancel_reverse_member_count  NUMBER(10,2) default 0,
  cancel_reject_member_count   NUMBER(10,2) default 0,
  total_order_count            NUMBER(10,2) default 0,
  net_order_count              NUMBER(10,2) default 0,
  effective_order_count        NUMBER(10,2) default 0,
  cancel_order_count           NUMBER(10,2) default 0,
  reverse_count                NUMBER(10,2) default 0,
  reject_count                 NUMBER(10,2) default 0,
  cancel_reverse_count         NUMBER(10,2) default 0,
  cancel_reject_count          NUMBER(10,2) default 0,
  gross_profit_amount          NUMBER(10,2) default 0,
  net_profit_amount            NUMBER(10,2) default 0,
  effective_profit_amount      NUMBER(10,2) default 0,
  gross_profit_rate            NUMBER(10,2) default 0,
  net_profit_rate              NUMBER(10,2) default 0,
  effective_profit_rate        NUMBER(10,2) default 0,
  total_order_qty              NUMBER(10,2) default 0,
  net_order_qty                NUMBER(10,2) default 0,
  effective_order_qty          NUMBER(10,2) default 0,
  cancel_order_qty             NUMBER(10,2) default 0,
  reverse_qty                  NUMBER(10,2) default 0,
  reject_qty                   NUMBER(10,2) default 0,
  cancel_reverse_qty           NUMBER(10,2) default 0,
  cancel_reject_qty            NUMBER(10,2) default 0,
  net_order_cust_price         NUMBER(10,2) default 0,
  effective_order_cust_price   NUMBER(10,2) default 0,
  net_order_unit_price         NUMBER(10,2) default 0,
  effective_order_unit_price   NUMBER(10,2) default 0,
  total_purchase_amount        NUMBER(10,2) default 0,
  net_purchase_amount          NUMBER(10,2) default 0,
  effective_purchase_amount    NUMBER(10,2) default 0,
  profit_amount                NUMBER(10,2) default 0,
  coupons_amount               NUMBER(10,2) default 0,
  freight_amount               NUMBER(10,2) default 0,
  product_avg_price            NUMBER(10,2) default 0,
  reject_amount                NUMBER(10,2) default 0,
  live_or_replay               VARCHAR2(10)
)
tablespace DWDATA00
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPER_PRODUCT_SCAN_DLY_REPORT
  is '新媒体中心数据日报-扫码购
by yangjin
2018-03-16';
-- Add comments to the columns 
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.posting_date_key
  is '过账日期key';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.sales_source_name
  is '销售一级组织名称';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.sales_source_second_name
  is '销售二级组织名称';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.own_account
  is '是否自营';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.brand_name
  is '品牌';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.tran_type
  is '交易类型';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.tran_type_name
  is '交易类型说明';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.item_or_gift
  is '主赠品';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.matdlt
  is '物料大类';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.matzlt
  is '物料中类';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.matxlt
  is '物料小类';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.md_person
  is 'MD工号';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.item_code
  is '商品短编码';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.goods_key
  is '商品长编码';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.goods_name
  is '商品名称';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_order_amount
  is '总订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_amount
  is '净订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_amount
  is '有效订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_order_amount
  is '取消订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reverse_order_amount
  is '退货订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reject_order_amount
  is '拒收订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reverse_amount
  is '退货取消订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reject_amount
  is '拒收取消订购金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_sales_amount
  is '总售价金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_sales_amount
  is '净售价金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_sales_amount
  is '有效售价金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_order_member_count
  is '总订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_member_count
  is '净订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_member_count
  is '有效订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_order_member_count
  is '取消订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reverse_member_count
  is '退货订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reject_member_count
  is '拒收订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reverse_member_count
  is '退货取消订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reject_member_count
  is '拒收取消订购人数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_order_count
  is '总订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_count
  is '净订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_count
  is '有效订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_order_count
  is '取消订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reverse_count
  is '退货订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reject_count
  is '拒收订购单数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reverse_count
  is '退货取消订购件数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reject_count
  is '拒收取消订购件数';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.gross_profit_amount
  is '还原后总毛利额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_profit_amount
  is '还原后净毛利额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_profit_amount
  is '还原后有效毛利额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.gross_profit_rate
  is '还原后总毛利率';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_profit_rate
  is '还原后净毛利率';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_profit_rate
  is '还原后有效毛利率';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_order_qty
  is '总订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_qty
  is '净订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_qty
  is '有效订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_order_qty
  is '取消订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reverse_qty
  is '退货订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reject_qty
  is '拒收订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reverse_qty
  is '退货取消订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.cancel_reject_qty
  is '拒收取消订购数量';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_cust_price
  is '净订购客单价';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_cust_price
  is '有效订购客单价';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_order_unit_price
  is '净订购件单价';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_order_unit_price
  is '有效订购件单价';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.total_purchase_amount
  is '总订购成本';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.net_purchase_amount
  is '净订购成本';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.effective_purchase_amount
  is '有效订购成本';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.profit_amount
  is '折扣金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.coupons_amount
  is '优惠券金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.freight_amount
  is '运费';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.product_avg_price
  is '商品平均售价';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.reject_amount
  is '拒退金额';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.live_or_replay
  is '直播重播';
comment on column OPER_PRODUCT_SCAN_DLY_REPORT.row_id
  is '行记录ID';
-- Create/Recreate indexes 
create index OPER_PRODUCT_SCAN_DLY_RRT_I1 on OPER_PRODUCT_SCAN_DLY_REPORT (POSTING_DATE_KEY)
  tablespace DWDATA00
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
grant select on OPER_PRODUCT_SCAN_DLY_REPORT to BDPUSER;
grant select on OPER_PRODUCT_SCAN_DLY_REPORT to YUNYING;
