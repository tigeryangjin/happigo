???create or replace procedure dw_user.processpuvrealtime is
  s_etl       w_etl_log%rowtype;
  sp_name     s_parameters2.pname%type;
  s_parameter s_parameters1.parameter_value%type;
  insert_rows number;
  -- s_startpoint fact_session.id%type;
  --s_endpoint   fact_session.id%type;
  /*
  功能说明：调度对SBI层W_SESSION_F表格数据进行增量抽取
       
  
  作者时间：liqiao  2015-05-12
  */
begin
  sp_name          := 'processpuvrealtime'; --需要手工填入所写PROCEDURE的名称
  s_etl.table_name := 'stats_online_puv_minute'; --此处需要手工录入该PROCEDURE操作的表格
  s_etl.proc_name  := sp_name;
  s_etl.start_time := sysdate;
  s_parameter      := 0;

  begin
    sp_parameter_two(sp_name, s_parameter);
    if s_parameter = '0' then
      s_etl.err_msg := '没有找到对应的过程加载类型数据';
      sp_sbi_w_etl_log(s_etl);
      return;
    end if;
  end;
  --select min(a.id) into s_startpoint from fact_session a where a.Visitor_Key = 0;
  --select max(a.id) into s_endpoint from fact_session a where a.Visitor_Key = 0;
  --select  to_char(to_date('2015-09-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')+1/24/60,'yyyy-mm-dd hh24:mi' ) from dual

  declare
    i  date;
    i1 varchar2(100);
  
  begin
  
    select nvl(max(t.end_time),
               to_date('2016-07-19 00:00:00', 'yyyy-mm-dd hh24:mi:ss'))
      into i
      from stats_online_puv_minute t;
  
    select to_char(max(visit_date), 'yyyymmddhh24mi')
      into i1
      from fact_page_view;
  
    loop
      --exit when to_number(to_char(i, 'yyyymmddhh24mi')) >= to_number(i1);
      exit when to_number(to_char(i + 10 / 24 / 60, 'yyyymmddhh24mi')) >= to_number(i1);
    
      insert into stats_online_puv_minute
        (id,
         statdate,
         stathour,
         statminute,
         start_time,
         end_time,
         application_key,
         application_name,
         pv,
         uv,
         rangepv,
         rangeuv)
        select w_statpuv_d_s.nextval as id,
               to_number(to_char(i + 10 / 24 / 60, 'yyyymmdd')) as statdate,
               to_number(to_char(i + 10 / 24 / 60, 'hh24')) as stathour,
               to_number(to_char(i + 10 / 24 / 60, 'mi')) as statminute,
               
               to_date(to_char(i, 'yyyy-mm-dd hh24:mi'),
                       'yyyy-mm-dd hh24:mi:ss') as start_time,
               to_date(to_char(i + 10 / 24 / 60, 'yyyy-mm-dd hh24:mi'),
                       'yyyy-mm-dd hh24:mi:ss') as end_time,
               
               x1.application_key,
               x1.application_name,
               x1.rangepv,
               x1.rangeuv,
               x2.pv,
               x2.uv
          from (select n.application_key,
                       n.application_name,
                       count(vid) as rangepv,
                       count(distinct vid) as rangeuv
                  from fact_page_view n
                 where n.visit_date >= i
                   and n.visit_date < i + 10 / 24 / 60
                 group by n.application_key, n.application_name) x1,
               
               (select n.application_key,
                       n.application_name,
                       nvl(count(vid), 0) as pv,
                       nvl(count(distinct vid), 0) as uv
                  from fact_page_view n
                 where n.visit_date >=trunc(sysdate)-- to_date(i, 'yyyy-mm-dd')
                   and n.visit_date < i + 10 / 24 / 60
                 group by n.application_key, n.application_name) x2
         where x1.application_name = x2.application_name
           and x1.application_key = x2.application_key;
    
      commit;
    
      i := i + 10 / 24 / 60;
    
    end loop;
  
  end;

  /*日志记录模块*/
  s_etl.end_time       := sysdate;
  s_etl.etl_record_ins := insert_rows;
  s_etl.etl_status     := 'SUCCESS';
  s_etl.etl_duration   := trunc((s_etl.end_time - s_etl.start_time) * 86400);
  sp_sbi_w_etl_log(s_etl);
exception
  when others then
    s_etl.end_time   := sysdate;
    s_etl.etl_status := 'FAILURE';
    s_etl.err_msg    := sqlerrm;
    sp_sbi_w_etl_log(s_etl);
    return;
  
end processpuvrealtime;
/
