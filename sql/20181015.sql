ALTER INDEX DW_USER.FACT_PAGE_VIEW_IP_INT
  RENAME SUBPARTITION FPV2018_FPV201701
  TO FPV201801;
	
ALTER INDEX DW_USER.FPV_DATETIME
  RENAME SUBPARTITION FPV2017_FPV201701
  TO FPV201701;
	
ALTER INDEX DW_USER.FPV_DATETIME
  RENAME SUBPARTITION FPV2018_FPV201701
  TO FPV201801;
	
ALTER INDEX DW_USER.IPGEO_KEY_IDX
  RENAME SUBPARTITION FPV2017_FPV201701
  TO FPV201701;

ALTER INDEX DW_USER.IPGEO_KEY_IDX
  RENAME SUBPARTITION FPV2018_FPV201701
  TO FPV201801;