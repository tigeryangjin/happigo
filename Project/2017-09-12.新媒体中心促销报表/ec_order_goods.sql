CREATE TABLE fact_ec_order_goods (
   rec_id number(10) ,
   order_id number(10) ,
   goods_id number(10) ,
   goods_commonid number(10) ,
   erp_code number(10) ,
   supplier_id varchar2(150) ,
   goods_name varchar2(600) ,
   goods_price number(10,2) ,
   apportion_price number(10,2) ,
   goods_num number(5) ,
   return_state number(3) ,
   return_time number(10) ,
   goods_image varchar2(300) ,
   goods_marketprice number(10,2) ,
   goods_pay_price number(10,2) ,
   tv_discount_amount number(10,2) ,
   store_id number(10) ,
   buyer_id number(10) ,
   goods_type number(1) ,
   promotions_id number(10) ,
   xianshi_goods_id number(10) ,
   cps_commission number(4,2) ,
   commis_rate number(5) ,
   gc_id number(10) ,
   extra_point number(3) ,
   pml_title varchar2(60) ,
   pml_id number(10) ,
   pml_discount number(10,2),
   third_skuid number(20) ,
   third_orderid varchar2(150) ,
   wangyi_package varchar2(600) ,
   hm_package varchar2(600) ,
   package_process number(3) ,
   package_status number(3) ,
   package_info varchar2(1500) ,
   package_error number(3) ,
   joinin_commis_rate varchar2(150) 
 ) ;
-- Add comments to the columns 
comment on column fact_ec_order_goods.rec_id
  is '订单商品表索引id';
comment on column fact_ec_order_goods.order_id
  is '订单id';
comment on column fact_ec_order_goods.goods_id
  is '商品id';
comment on column fact_ec_order_goods.goods_commonid
  is '公共商品编号';
comment on column fact_ec_order_goods.erp_code
  is 'CRM中商品对应的SKU号';
comment on column fact_ec_order_goods.supplier_id
  is '商品供应商编号';
comment on column fact_ec_order_goods.goods_name
  is '商品名称';
comment on column fact_ec_order_goods.goods_price
  is '商品价格';
comment on column fact_ec_order_goods.apportion_price
  is '供应商分摊金额';
comment on column fact_ec_order_goods.goods_num
  is '商品数量';
comment on column fact_ec_order_goods.return_state
  is '后续状态 默认0   -1取消退货 1退货申请  5退货中  10退货完成';
comment on column fact_ec_order_goods.return_time
  is '最后反向操作时间';
comment on column fact_ec_order_goods.goods_image
  is '商品图片';
comment on column fact_ec_order_goods.goods_marketprice
  is '';
comment on column fact_ec_order_goods.goods_pay_price
  is '商品实际成交价';
comment on column fact_ec_order_goods.tv_discount_amount
  is 'TV直播立减金额';
comment on column fact_ec_order_goods.store_id
  is '店铺ID';
comment on column fact_ec_order_goods.buyer_id
  is '买家ID';
comment on column fact_ec_order_goods.goods_type
  is '1默认2团购商品3限时折扣商品4组合套装5赠品6,满送商品。7,tv商品';
comment on column fact_ec_order_goods.promotions_id
  is '促销活动ID（团购ID/限时折扣ID/优惠套装ID）与goods_type搭配使用';
comment on column fact_ec_order_goods.xianshi_goods_id
  is '限时商品编号';
comment on column fact_ec_order_goods.cps_commission
  is 'cps佣金比例';
comment on column fact_ec_order_goods.commis_rate
  is '佣金比例';
comment on column fact_ec_order_goods.gc_id
  is '商品最底级分类ID';
comment on column fact_ec_order_goods.extra_point
  is '额外积分倍数';
comment on column fact_ec_order_goods.pml_title
  is '活动名称/标题';
comment on column fact_ec_order_goods.pml_id
  is '活动ID';
comment on column fact_ec_order_goods.pml_discount
  is '促销额';
comment on column fact_ec_order_goods.third_skuid
  is '第三方商品编号';
comment on column fact_ec_order_goods.third_orderid
  is '第三方订单号';
comment on column fact_ec_order_goods.wangyi_package
  is '严选包裹单号';
comment on column fact_ec_order_goods.hm_package
  is '河马包裹单号';
comment on column fact_ec_order_goods.package_process
  is '网易包裹单号处理进度';
comment on column fact_ec_order_goods.package_status
  is '网易包裹单号处理状态';
comment on column fact_ec_order_goods.package_info
  is '网易包裹单错误记录';
comment on column fact_ec_order_goods.package_error
  is '网易包裹单错误次数';
comment on column fact_ec_order_goods.joinin_commis_rate
  is '入驻商家佣金';
