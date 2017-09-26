CREATE TABLE ec_p_mansong (
   mansong_id number(10),
   mansong_name varchar2(150),
   quota_id number(10),
   start_time number(10),
   end_time number(10) ,
   member_id number(10) ,
   store_id number(10) ,
   member_name varchar2(150) ,
   store_name varchar2(150) ,
   state number(1),
   remark varchar2(600),
   mansong_web number(2),
   mansong_app number(2),
   mansong_wx number(2) ,
   mansong_3g number(2) ,
   mansong_num number(10),
   mansong_advertising varchar2(600) ,
   isshop_cart number(2) ,
   isgoods_details number(2) ,
   mat_type number(2) ,
   goods_type number(2),
   min_level number(11),
   min_level_t varchar2(60) ,
   isall_details number(5) ,
   app_minato_single_url varchar2(1500) ,
   web_minato_single_url varchar2(1500) 
 ) ;
-- Add comments to the columns 
comment on column ec_p_mansong.mansong_id
  is '满送活动编号';
comment on column ec_p_mansong.mansong_name
  is '活动名称';
comment on column ec_p_mansong.quota_id
  is '套餐编号';
comment on column ec_p_mansong.start_time
  is '活动开始时间';
comment on column ec_p_mansong.end_time
  is '活动结束时间';
comment on column ec_p_mansong.member_id
  is '用户编号';
comment on column ec_p_mansong.store_id
  is '店铺编号';
comment on column ec_p_mansong.member_name
  is '用户名';
comment on column ec_p_mansong.store_name
  is '店铺名称';
comment on column ec_p_mansong.state
  is '活动状态(1-正常/2-已结束/3-管理员关闭/6-暂停/7-被删除)';
comment on column ec_p_mansong.remark
  is '备注';
comment on column ec_p_mansong.mansong_web
  is '官网判断是否享受满送，1：享受，0：不享受';
comment on column ec_p_mansong.mansong_app
  is 'APP判断是否享受满送，1：享受，0：不享受';
comment on column ec_p_mansong.mansong_wx
  is '微信判断是否享受满送，1：享受，0：不享受';
comment on column ec_p_mansong.mansong_3g
  is '3g判断是否享受满送，1：享受，0：不享受';
comment on column ec_p_mansong.mansong_num
  is '满送次数，0为不限制';
comment on column ec_p_mansong.mansong_advertising
  is '广告语';
comment on column ec_p_mansong.isshop_cart
  is '购物车是否显示广告语';
comment on column ec_p_mansong.isgoods_details
  is '商品详情页是否显示广告语';
comment on column ec_p_mansong.mat_type
  is '满送类目类型，0:无，1:只允许，2:不允许';
comment on column ec_p_mansong.goods_type
  is '满送商品类型，0:无，1:只允许，2:不允许';
comment on column ec_p_mansong.min_level
  is '最低享受等级';
comment on column ec_p_mansong.min_level_t
  is '最低享受等级';
comment on column ec_p_mansong.isall_details
  is '是否显示广告语';
comment on column ec_p_mansong.app_minato_single_url
  is 'APP凑单页面链接';
comment on column ec_p_mansong.web_minato_single_url
  is 'WEB凑单页面链接';
 
