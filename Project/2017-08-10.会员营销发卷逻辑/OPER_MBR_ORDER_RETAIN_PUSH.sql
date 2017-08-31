-- Create table
create table OPER_MBR_ORDER_RETAIN_PUSH
(
  member_key          NUMBER(20),
  record_date_key     NUMBER(20),
  order_date_key      NUMBER(20),
  actual_order_amount NUMBER(10,2),
  order_frequency     NUMBER(5),
  amount_level        NUMBER(1),
  day_without_order   NUMBER(5),
  insert_dt           DATE,
  update_dt           DATE,
  processed           NUMBER(1) default 0
)
tablespace BDUDATAORDER
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
comment on table OPER_MBR_ORDER_RETAIN_PUSH
  is '会员发券-会员留存
by yangjin';
-- Add comments to the columns 
comment on column OPER_MBR_ORDER_RETAIN_PUSH.member_key
  is '会员编号';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.record_date_key
  is '记录日期';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.order_date_key
  is '订购日期';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.actual_order_amount
  is '实际订购金额';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.order_frequency
  is '订购次数';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.amount_level
  is '有效订购1次，15天内无重复订购,实际订购金额等级（1:100以下，2:100以上300以下，3:300以上）
有效订购2次，30天内无重复订购,实际订购金额等级（1:100~189，2:189~500，3:500以上,-1:100以下）
有效订购3次，30天内无重复订购,实际订购金额等级（1:100~189，2:189~800，3:800以上,-1:100以下）';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.day_without_order
  is '未订购天数';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.insert_dt
  is '插入时间';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.update_dt
  is '更新时间';
comment on column OPER_MBR_ORDER_RETAIN_PUSH.processed
  is '已处理标志(0:未处理，1:已处理)';
