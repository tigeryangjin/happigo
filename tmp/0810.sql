--电商
SELECT count(1) from dim_good a where a.group_id = 2000;
select count(1) from dim_ec_good a;
SELECT *
  from dim_good a
 where a.group_id = 2000
   and not exists
 (select 1 from dim_ec_good b where a.item_code = b.item_code);
SELECT *
  from dim_good a
 where a.group_id = 2000
   and not exists (select 1
          from dim_ec_good b
         where a.goods_commonid = b.goods_commonid);
SELECT *
  from dim_ec_good a
 where not exists (select 1
          from dim_good b
         where a.item_code = b.item_code
           and b.group_id = 2000);
SELECT *
  from dim_ec_good a
 where not exists (select 1
          from dim_good b
         where a.goods_commonid = b.goods_commonid
           and b.group_id = 2000);
--TV播出非播出
SELECT count(1) from dim_good a where a.group_id = 1000;
SELECT COUNT(1) FROM DIM_TV_GOOD A;
SELECT *
  from dim_good a
 where a.group_id = 1000
   and not exists
 (select 1 from dim_TV_good b where a.item_code = b.item_code);
SELECT *
  from dim_good a
 where a.group_id = 1000
   and not exists (select 1
          from dim_TV_good b
         where a.goods_commonid = b.goods_common_id);
SELECT *
  FROM DIM_TV_GOOD A
 WHERE NOT EXISTS (SELECT 1
          FROM DIM_GOOD B
         WHERE A.ITEM_CODE = B.ITEM_CODE
        /*AND B.GROUP_ID = 1000*/
        );
SELECT *
  FROM DIM_TV_GOOD A
 WHERE NOT EXISTS (SELECT 1
          FROM DIM_GOOD B
         WHERE A.GOODS_COMMON_ID = B.GOODS_COMMONID
        /*AND B.GROUP_ID = 1000*/
        );


--tmp
SELECT * from dim_good a where a.item_code = 205527;
select * from dim_tv_good a where a.item_code = 205527;
select * from dim_ec_good a where a.item_code=205527;
select *
  from odshappigo.ods_zmaterial a
 where a.zmater2 = '000000000000205527';
 
select count(1) from dim_good a where a.goods_commonid is null;

---
select distinct a.OWNER, a.name
  from all_source a
 where lower(a.TEXT) like '%insert into%dim_good%';
