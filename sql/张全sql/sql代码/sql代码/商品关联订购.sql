---v6
select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=226570)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;
---���
select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=204838)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;
---ʩ����

select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=223654)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;
-----cc ����
select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=225012)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;

-----����
select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=224799)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;

-----������
select * from (
select GOODS_COMMON_KEY,count(1) from fact_goods_sales where POSTING_DATE_KEY >20170101
and MEMBER_KEY in(
select MEMBER_KEY from fact_goods_sales where POSTING_DATE_KEY >20170101
and GOODS_COMMON_KEY=211135)
group by GOODS_COMMON_KEY) a join (select * from dim_good where CURRENT_FLG='Y'
and item_code in (select ITEM_CODE from fact_daily_goodzaijia where CREATE_DATE_KEY=20170928)) b on a.GOODS_COMMON_KEY=b.item_code;
