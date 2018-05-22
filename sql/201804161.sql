with dp as
 (select f.visit_date_key date_key,
         f.channel,
         'Dau' page_name,
         count(f.all_page_view_key) all_pv,
         count(distinct f.all_member_key) all_uv,
         round(avg(f.all_page_stay_time)) all_stay_time,
         count(f.new_page_view_key) new_pv,
         count(distinct f.new_member_key) new_uv,
         round(avg(f.new_page_stay_time)) new_stay_time,
         count(f.old_page_view_key) old_pv,
         count(distinct f.old_member_key) old_uv,
         round(avg(f.old_page_stay_time)) old_stay_time
    from (select e.visit_date_key,
                 e.channel,
                 e.page_view_key all_page_view_key,
                 e.member_key all_member_key,
                 e.page_stay_time all_page_stay_time,
                 case
                   when is_new = 1 then
                    e.page_view_key
                 end new_page_view_key,
                 case
                   when is_new = 0 then
                    e.page_view_key
                 end old_page_view_key,
                 --
                 case
                   when is_new = 1 then
                    e.member_key
                 end new_member_key,
                 case
                   when is_new = 0 then
                    e.member_key
                 end old_member_key,
                 --
                 case
                   when is_new = 1 then
                    e.page_stay_time
                 end new_page_stay_time,
                 case
                   when is_new = 0 then
                    e.page_stay_time
                 end old_page_stay_time
            from (select d.visit_date_key,
                         case
                           when d.application_key in (10, 20) then
                            'APP'
                           when d.application_key = 70 then
                            'С����'
                         end channel,
                         d.page_view_key,
                         d.member_key,
                         d.page_staytime page_stay_time,
                         case
                           when to_date(d.visit_date_key, 'yyyymmdd') >
                                d.first_order_date then
                            0
                           when to_date(d.visit_date_key, 'yyyymmdd') <=
                                d.first_order_date then
                            1
                         end is_new /*�Ƿ��»�Ա��־��1:�»�Ա��0:�ϻ�Ա*/
                    from (select a.visit_date_key,
                                 a.application_key,
                                 a.page_view_key,
                                 a.member_key,
                                 a.page_staytime,
                                 nvl(c.first_order_date, date '2000-01-01') first_order_date /*�׵���������*/
                            from fact_page_view a,
                                 (select b.cust_no member_key,
                                         trunc(min(b.add_time)) first_order_date
                                    from fact_ec_order_2 b
                                   group by b.cust_no) c
                           where a.member_key = c.member_key(+)
                             and a.visit_date_key = 20180412
                                /*APP��С����*/
                             and a.application_key in (10, 20, 70)) d) e) f
   group by f.visit_date_key, f.channel
  union all
  select f.visit_date_key date_key,
         f.channel,
         f.page_name,
         count(f.all_page_view_key) all_pv,
         count(distinct f.all_member_key) all_uv,
         round(avg(f.all_page_stay_time)) all_stay_time,
         count(f.new_page_view_key) new_pv,
         count(distinct f.new_member_key) new_uv,
         round(avg(f.new_page_stay_time)) new_stay_time,
         count(f.old_page_view_key) old_pv,
         count(distinct f.old_member_key) old_uv,
         round(avg(f.old_page_stay_time)) old_stay_time
    from (select e.visit_date_key,
                 e.channel,
                 e.page_name,
                 e.page_view_key all_page_view_key,
                 e.member_key all_member_key,
                 e.page_stay_time all_page_stay_time,
                 case
                   when is_new = 1 then
                    e.page_view_key
                 end new_page_view_key,
                 case
                   when is_new = 0 then
                    e.page_view_key
                 end old_page_view_key,
                 --
                 case
                   when is_new = 1 then
                    e.member_key
                 end new_member_key,
                 case
                   when is_new = 0 then
                    e.member_key
                 end old_member_key,
                 --
                 case
                   when is_new = 1 then
                    e.page_stay_time
                 end new_page_stay_time,
                 case
                   when is_new = 0 then
                    e.page_stay_time
                 end old_page_stay_time
            from (select d.visit_date_key,
                         case
                           when d.application_key in (10, 20) then
                            'APP'
                           when d.application_key = 70 then
                            'С����'
                         end channel,
                         d.page_view_key,
                         d.member_key,
                         d.page_key,
                         d.page_name,
                         d.page_staytime page_stay_time,
                         case
                           when to_date(d.visit_date_key, 'yyyymmdd') >
                                d.first_order_date then
                            0
                           when to_date(d.visit_date_key, 'yyyymmdd') <=
                                d.first_order_date then
                            1
                         end is_new /*�Ƿ��»�Ա��־��1:�»�Ա��0:�ϻ�Ա*/
                    from (select a.visit_date_key,
                                 a.application_key,
                                 a.page_view_key,
                                 a.member_key,
                                 a.page_key,
                                 a.page_name,
                                 a.page_staytime,
                                 nvl(c.first_order_date, date '2000-01-01') first_order_date /*�׵���������*/
                            from fact_page_view a,
                                 (select b.cust_no member_key,
                                         trunc(min(b.add_time)) first_order_date
                                    from fact_ec_order_2 b
                                   group by b.cust_no) c
                           where a.member_key = c.member_key(+)
                             and a.visit_date_key = 20180412
                             and a.application_key in (10, 20, 70)
                             and a.page_name in ('Home',
                                                 'Home_TVLive',
                                                 'TV_home',
                                                 'Channel',
                                                 'Good',
                                                 'Search',
                                                 'Member',
                                                 'PayEnd')) d) e) f
   group by f.visit_date_key, f.channel, f.page_name),
buv as
 (select f3.start_date_key date_key,
         f3.channel,
         g3.page_name,
         count(f3.member_key) all_bounce_uv,
         count(f3.new_member_key) new_bounce_uv,
         count(f3.old_member_key) old_bounce_uv
    from (select e3.start_date_key,
                 e3.channel,
                 e3.left_page_key,
                 e3.member_key,
                 case
                   when e3.is_new = 1 then
                    member_key
                 end new_member_key,
                 case
                   when e3.is_new = 0 then
                    member_key
                 end old_member_key
            from (select d3.start_date_key,
                         case
                           when d3.application_key in (10, 20) then
                            'APP'
                           when d3.application_key = 70 then
                            'С����'
                         end channel,
                         d3.member_key,
                         d3.left_page_key,
                         case
                           when to_date(d3.start_date_key, 'yyyymmdd') >
                                d3.first_order_date then
                            0
                           when to_date(d3.start_date_key, 'yyyymmdd') <=
                                d3.first_order_date then
                            1
                         end is_new /*�Ƿ��»�Ա��־��1:�»�Ա��0:�ϻ�Ա*/
                    from (select a3.start_date_key,
                                 a3.member_key,
                                 a3.application_key,
                                 a3.left_page_key,
                                 nvl(c3.first_order_date, date '2000-01-01') first_order_date /*�׵���������*/
                            from fact_session a3,
                                 (select b3.cust_no member_key,
                                         trunc(min(b3.add_time)) first_order_date
                                    from fact_ec_order_2 b3
                                   group by b3.cust_no) c3
                           where a3.member_key = c3.member_key(+)
                             and a3.start_date_key = 20180412
                             and a3.application_key in (10, 20, 70)) d3) e3) f3,
         dim_page g3
   where f3.left_page_key = g3.page_key
     and g3.page_name in ('Home',
                          'Home_TVLive',
                          'TV_home',
                          'Channel',
                          'Good',
                          'Search',
                          'Member',
                          'PayEnd')
   group by f3.start_date_key, f3.channel, g3.page_name),
dim as
 (select dim1.date_key, dim2.channel, dim3.page_name
    from (select to_char(date '2018-04-12', 'yyyymmdd') date_key from dual) dim1,
         (select 'APP' channel
            from dual
          union
          select 'С����' channel
            from dual) dim2,
         (select 'Dau' page_name
            from dual
          union
          select 'Home' page_name
            from dual
          union
          select 'Home_TVLive' page_name
            from dual
          union
          select 'TV_home' page_name
            from dual
          union
          select 'Channel' page_name
            from dual
          union
          select 'Good' page_name
            from dual
          union
          select 'Search' page_name
            from dual
          union
          select 'Member' page_name
            from dual
          union
          select 'PayEnd' page_name
            from dual) dim3)
select dim.date_key,
       dim.channel,
       dim.page_name,
       nvl(dp.all_pv, 0) all_pv,
       nvl(dp.all_uv, 0) all_uv,
       nvl(dp.all_stay_time, 0) all_stay_time,
       nvl(buv.all_bounce_uv, 0) all_bounce_uv,
       nvl(dp.new_pv, 0) new_pv,
       nvl(dp.new_uv, 0) new_uv,
       nvl(dp.new_stay_time, 0) new_stay_time,
       nvl(buv.new_bounce_uv, 0) new_bounce_uv,
       nvl(dp.old_pv, 0) old_pv,
       nvl(dp.old_uv, 0) old_uv,
       nvl(dp.old_stay_time, 0) old_stay_time,
       nvl(buv.old_bounce_uv, 0)
  from dim, dp, buv
 where dim.date_key = dp.date_key(+)
   and dim.channel = dp.channel(+)
   and dim.page_name = dp.page_name(+)
   and dim.date_key = buv.date_key(+)
   and dim.channel = buv.channel(+)
   and dim.page_name = buv.page_name(+);