create table odshappigo.ods_order_yj as
select distinct t.crm_obj_id,
                t.crm_numint,
                t.zeamc008,
                t.crm_ohguid,
                t.crm_itmgui,
                t.crm_prctyp,
                t.zcrmd023,
                t.crm_itmtyp,
                t.ztcmc002,
                t.ztcmc006,
                t.salesorg,
                t.distr_chan,
                t.sales_off,
                t.division,
                t.zmaterial,
                t.zeamc027,
                t.zlifnr,
                t.crm_endcst,
                t.ztcmc016,
                t.age,
                t.ztcmc020,
                t.crm_soldto,
                t.zkunnr_l1,
                t.zkunnr_l2,
                t.zthrc015,
                t.bp_emplo,
                t.zthrc016,
                t.zthrc017,
                t.zesdc113,
                t.crmpostdat,
                t.zpst_tim,
                t.zgz_time,
                t.zcrmd001,
                t.crm_usstat,
                t.crm_stsma,
                t.crm_ctd_by,
                t.crm_crd_at,
                t.crea_time,
                t.zeamc001,
                t.zeamc010,
                t.zeamc011,
                t.zeamc012,
                t.zeamc037,
                t.zeamc013,
                t.zeamc014,
                t.ztcmc021,
                t.ztcmc022,
                t.ztcmc027,
                t.ztcmc026,
                t.ztcmc030,
                t.ztcmc007,
                t.ztcmc008,
                t.ztcmc009,
                t.ztcmc023,
                t.ztcmc024,
                t.ztcmc025,
                t.zcrmd015,
                t.zcrmd016,
                t.zcrmd017,
                t.zcrmd018,
                t.zcr_on,
                t.zobj_cc,
                t.zdsxd,
                t.zjsjf_yn,
                t.zcrmd025,
                t.zcrmd020,
                t.zcrmd021,
                t.ztcrmc01,
                t.ztcrmc02,
                t.ztcrmc03,
                t.ztcrmc04,
                t.ztcrmc05,
                t.netvalord,
                t.crm_taxamo,
                t.grsvalord,
                t.zamk0011,
                t.zamk0010,
                t.zcrmk006,
                t.zcrmk007,
                t.zcrmk009,
                t.crm_srvkb,
                t.zcrmk003,
                t.zcrmk004,
                t.zcrmk005,
                t.zyf_pay,
                t.zxy_pay,
                t.znpt_atm,
                t.crm_numofi,
                t.zamk0024,
                t.zcrmk008,
                t.sales_unit,
                t.currency,
                t.crm_curren,
                t.zcrmd031,
                t.zehrc012,
                t.zcrmd048,
                t.zcrmd086,
                t.zcrmd019,
                t.zthrc027,
                t.zthrc026,
                t.zthrc025,
                t.ztcrmc11,
                t.zcrmd199,
                t.ztlec001,
                t.zcondk001,
                t.zcrmd120,
                t.changed_by,
                t.zmater2,
                t.zztransf,
                t.ztmstamp
  from ODSHAPPIGO.ODS_ORDER t
 WHERE t.crmpostdat = 20180408;

delete ODSHAPPIGO.ODS_ORDER t WHERE t.crmpostdat = 20180408;