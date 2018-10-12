DROP INDEX DW_USER.DATA_ACQUISITION_ITEM_BASE_I1;
CREATE INDEX DW_USER.DATA_ACQUISITION_ITEM_BASE_I1 ON DW_USER.DATA_ACQUISITION_ITEM_BASE
(PERIOD) LOCAL
NOLOGGING
TABLESPACE DWDATA00
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

ALTER INDEX DW_USER.DATA_ACQUISITION_ITEM_BASE_I1
  MONITORING USAGE;