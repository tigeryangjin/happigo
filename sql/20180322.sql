--1.
select c.channel, count(c.vid)
  from (select case
                 when a.vid like 'webmport%' then
                  'web_m_port'
                 when a.vid like 'webport%' then
                  'web_port'
                 when a.vid like 'wx%' then
                  'wx'
                 when a.vid like 'android%' then
                  'android'
                 when a.vid like 'iphone%' then
                  'iphone'
               end channel,
               a.vid,
               a.min_visit_date_key,
               b.first_order_date_key
          from kpi_vid_first_visit a, KPI_VID_FIRST_ORDER b
         where a.vid = b.vid(+)
           and b.first_order_date_key is null) c
 where c.channel is not null
 group by c.channel
 order by c.channel;

--2.
select c.channel, count(c.vid)
  from (select case
                 when a.vid like 'webmport%' then
                  'web_m_port'
                 when a.vid like 'webport%' then
                  'web_port'
                 when a.vid like 'wx%' then
                  'wx'
                 when a.vid like 'android%' then
                  'android'
                 when a.vid like 'iphone%' then
                  'iphone'
               end channel,
               a.vid,
               a.min_visit_date_key,
               b.first_order_date_key
          from kpi_vid_first_visit a, KPI_VID_FIRST_ORDER b
         where a.vid = b.vid(+)
           and b.first_order_date_key is not null) c
 where c.channel is not null
 group by c.channel
 order by c.channel;

--3.
select *
  from (select substr(a.min_visit_date_key, 1, 4) year,
               case
                 when a.vid like 'webmport%' then
                  'web_m_port'
                 when a.vid like 'webport%' then
                  'web_port'
                 when a.vid like 'wx%' then
                  'wx'
                 when a.vid like 'android%' then
                  'android'
                 when a.vid like 'iphone%' then
                  'iphone'
               end channel,
               count(1) visit_count
          from kpi_vid_first_visit a
         group by substr(a.min_visit_date_key, 1, 4),
                  case
                    when a.vid like 'webmport%' then
                     'web_m_port'
                    when a.vid like 'webport%' then
                     'web_port'
                    when a.vid like 'wx%' then
                     'wx'
                    when a.vid like 'android%' then
                     'android'
                    when a.vid like 'iphone%' then
                     'iphone'
                  end
         order by substr(a.min_visit_date_key, 1, 4),
                  case
                    when a.vid like 'webmport%' then
                     'web_m_port'
                    when a.vid like 'webport%' then
                     'web_port'
                    when a.vid like 'wx%' then
                     'wx'
                    when a.vid like 'android%' then
                     'android'
                    when a.vid like 'iphone%' then
                     'iphone'
                  end) b
 where b.channel is not null
 order by 1, 2;

select b.month, b.visit_count, c.order_count
  from (select substr(a.min_visit_date_key, 1, 6) month,
               count(1) visit_count
          from kpi_vid_first_visit a
         group by substr(a.min_visit_date_key, 1, 6)) b,
       (select substr(a.first_order_date_key, 1, 6) month,
               count(1) order_count
          from KPI_VID_FIRST_ORDER a
         group by substr(a.first_order_date_key, 1, 6)) c
 where b.month = c.month(+)
 order by b.month;

--4.

select 500*0.05 from dual;
