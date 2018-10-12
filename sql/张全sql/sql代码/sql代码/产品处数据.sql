---产品规模
---（新增会员、活跃用户比例）
(select REGISTER_APPNAME  APPNAME,count(1) huiyuan,MEMBER_TIME  from  fact_ecmember where  MEMBER_TIME>20170101 
and REGISTER_APPNAME is not null
group by REGISTER_APPNAME,MEMBER_TIME)
select count(1),
APPLICATION_KEY
 from fact_visitor_register  where APPLICATION_KEY>0 group by APPLICATION_KEY
 
 -----流量相关：新增用户,UV、PV、在线时间、新用户比例
select VISIT_DATE_KEY 日期,BONUSRATE 跳出率,NEWVTCOUNT 新增用户,NEWVTRATE 新用户比例,UVCNT UV,PVCNT PV,AVGLIFE_TIME 在线时间,AVGPV 人均浏览量 ,'KLGMPortal'  渠道名称  from fact_daily_3g where VISIT_DATE_KEY>20170101;
select VISIT_DATE_KEY 日期,BONUSRATE 跳出率,NEWVTCOUNT 新增用户,NEWVTRATE 新用户比例,UVCNT UV,PVCNT PV,AVGLIFE_TIME 在线时间,AVGPV 人均浏览量 ,'KLGAPP'  渠道名称   from fact_daily_app where VISIT_DATE_KEY>20170101;
select VISIT_DATE_KEY 日期,BONUSRATE 跳出率,NEWVTCOUNT 新增用户,NEWVTRATE 新用户比例,UVCNT UV,PVCNT PV,AVGLIFE_TIME 在线时间,AVGPV 人均浏览量 ,'KLGPortal' 渠道名称 from fact_daily_pc where VISIT_DATE_KEY>20170101;
select VISIT_DATE_KEY 日期,BONUSRATE 跳出率,NEWVTCOUNT 新增用户,NEWVTRATE 新用户比例,UVCNT UV,PVCNT PV,AVGLIFE_TIME 在线时间,AVGPV 人均浏览量 ,'KLGWX'  渠道名称 from fact_daily_wx where VISIT_DATE_KEY>20170101;

-----访问、订购频率：
select A.APP_NAME,A.nums,NUM2,NUM3 from
(select   (case
  when APPLICATION_KEY = 40  then 'KLGPortal'
  when APPLICATION_KEY =30  then 'KLGMPortal'
  when APPLICATION_KEY =50  then 'KLGWX'
  else 'KLGAPP' end )
    APP_NAME,nums,count(1) num2 from (
select vid,APPLICATION_KEY,count(distinct(START_DATE_KEY)) nums from  fact_session 
where START_DATE_KEY between  to_char(sysdate-7,'yyyymmdd') and  to_char(sysdate-1,'yyyymmdd') 
and APPLICATION_KEY is not null
group by vid,APPLICATION_KEY)
group by (case
  when APPLICATION_KEY = 40  then 'KLGPortal'
  when APPLICATION_KEY =30  then 'KLGMPortal'
  when APPLICATION_KEY =50  then 'KLGWX'
  else 'KLGAPP' end ),nums) A LEFT JOIN 

(select nums,(case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end ) APP_NAME ,count(1) num3 from (
select   MEMBER_KEY,APP_NAME,count(distinct(add_time)) nums from  factec_order where
add_time between  to_char(sysdate-7,'yyyymmdd') and  to_char(sysdate-1,'yyyymmdd') 
and order_state>10
group by MEMBER_KEY,APP_NAME)
group by  nums,(case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end )) B ON A.APP_NAME=B.APP_NAME AND A.NUMS=B.NUMS


---订单相关：总订单、有效订单、拒退、（数、额）客单价、会员订购频率
select  a.ADD_TIME 日期,a.APP_NAME 渠道名称,ZONGREN 总订购人数,ZONGDAN 总订购单数, zongjin  总订购金额,
YOUREN 有效订购人数,YOUDAN 有效订购单数, YOUjin  有效订购金额,
juREN 拒退人数,juDAN 拒退单数, jujin  拒退金额
 from 
(select count(distinct(MEMBER_KEY)) zongren,count(1) zongdan,
sum(ORDER_AMOUNT) zongjin,APP_NAME,ADD_TIME from factec_order where ADD_TIME>20170101 
group by  APP_NAME,ADD_TIME) a left join 
 
(select count(distinct(MEMBER_KEY)) youren,count(1) youdan,
sum(ORDER_AMOUNT) youjin,APP_NAME,ADD_TIME from factec_order where ADD_TIME>20170101 
and ORDER_STATE>10
group by  APP_NAME,ADD_TIME) b on a.APP_NAME=b.APP_NAME and a.ADD_TIME=b.ADD_TIME
left join 
(select count(distinct(MEMBER_KEY)) juren,count(1) judan,
sum(ORDER_AMOUNT) jujin,APP_NAME,ADD_TIME from factec_order where ADD_TIME>20170101 
and ORDER_STATE=0 and CANCEL_BEFORE_STATE=0
group by  APP_NAME,ADD_TIME) c  on a.APP_NAME=c.APP_NAME and a.ADD_TIME=c.ADD_TIME

---- 漏斗分析

SELECT A.VISIT_DATE_KEY,A.APPLICATION_NAME,NUM1,NUM2,NUM3,NUM4,NUM5 FROM 
(select count(distinct(vid)) num1,visit_date_key,
(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) APPLICATION_NAME

from fact_page_view where visit_date_key between 20170201 and 20170202 
and page_name!='appdownload' and page_name!='TV_QRC'
group by visit_date_key,(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) ) A
LEFT JOIN 
(select count(distinct(vid)) num2,visit_date_key ,(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) APPLICATION_NAME
from fact_page_view where visit_date_key between 20170201 and 20170202 
and page_name='Good'
group by visit_date_key,(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) ) B 
 ON A.visit_date_key=B.visit_date_key AND A.APPLICATION_NAME=B.APPLICATION_NAME
LEFT JOIN 

(select count(distinct(vid)) num3,visit_date_key ,(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) APPLICATION_NAME
from fact_page_view where visit_date_key between 20170201 and 20170202 
and page_name='OrderConfirm'
group by visit_date_key,(case
  when APPLICATION_NAME = 'KLGPortal'  then 'KLGPortal'
  when APPLICATION_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APPLICATION_NAME = 'KLGWX' OR  APPLICATION_NAME = 'klgwx' then 'KLGWX'
  else 'KLGAPP' end ) ) C 
 ON A.visit_date_key=C.visit_date_key AND A.APPLICATION_NAME=C.APPLICATION_NAME
 
 
 
 
 left join 
 (
select count(distinct(vid)) num4,add_time, (case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end )  APP_NAME   from factec_order where add_time between 20170201 and 20170202 
group by add_time,(case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end ) 
)  d on a.visit_date_key=d.add_time and a.APPLICATION_NAME=d.APP_NAME left join 


(
select count(distinct(vid)) num5, (case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end )  APP_NAME,add_time from factec_order where add_time between 20170201 and 20170202 
and order_state>10
group by add_time,(case
  when APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end ) 
)   e on a.visit_date_key=e.add_time and a.APPLICATION_NAME=e.APP_NAME
 
 
select  a.ADD_TIME 日期,
(case
  when A.APP_NAME = 'KLGPortal'  then 'KLGPortal'
  when A.APP_NAME = 'KLGMPortal'  then 'KLGMPortal'
  when A.APP_NAME = 'KLGWX'  then 'KLGWX'
  else 'KLGAPP' end ) 
 渠道名称,ZONGREN 总订购人数,ZONGDAN 总订购单数, zongjin  总订购金额,
YOUREN 有效订购人数,YOUDAN 有效订购单数, YOUjin  有效订购金额,
juREN 拒退人数,juDAN 拒退单数, jujin  拒退金额
 from 
(select count(distinct(MEMBER_KEY)) zongren,count(1) zongdan,
sum(ORDER_AMOUNT) zongjin,APP_NAME,ADD_TIME from factec_order where ADD_TIME     between  to_char(sysdate-15,'yyyymmdd') and  to_char(sysdate-1,'yyyymmdd') 
group by  APP_NAME,ADD_TIME) a left join 
 
(select count(distinct(MEMBER_KEY)) youren,count(1) youdan,
sum(ORDER_AMOUNT) youjin,APP_NAME,ADD_TIME from factec_order where ADD_TIME     between  to_char(sysdate-15,'yyyymmdd') and  to_char(sysdate-1,'yyyymmdd') 
and ORDER_STATE>10
group by  APP_NAME,ADD_TIME) b on a.APP_NAME=b.APP_NAME and a.ADD_TIME=b.ADD_TIME
left join 
(select count(distinct(MEMBER_KEY)) juren,count(1) judan,
sum(ORDER_AMOUNT) jujin,APP_NAME,ADD_TIME from factec_order where ADD_TIME     between  to_char(sysdate-15,'yyyymmdd') and  to_char(sysdate-1,'yyyymmdd') 
and ORDER_STATE=0 and CANCEL_BEFORE_STATE=0
group by  APP_NAME,ADD_TIME) c  on a.APP_NAME=c.APP_NAME and a.ADD_TIME=c.ADD_TIME;
