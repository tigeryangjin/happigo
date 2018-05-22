CREATE TABLE `g_activity_goods` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '����',
  `group_id` int(10) unsigned NOT NULL COMMENT '�����id',
  `goods_name` varchar(50) NOT NULL DEFAULT '' COMMENT '��Ʒ����',
  `goods_commonid` varchar(20) NOT NULL DEFAULT '' COMMENT '��Ʒ���',
  `item_code` varchar(150) NOT NULL DEFAULT '' COMMENT '��Ʒ����',
  `goods_jingle` varchar(200) NOT NULL DEFAULT '1' COMMENT '��Ʒ�ȵ�1',
  `goods_jingle2` varchar(200) NOT NULL DEFAULT '' COMMENT '��Ʒ�ȵ�2',
  `goods_reduction` varchar(50) NOT NULL DEFAULT '' COMMENT '�����İ�',
  `superscript_image` varchar(200) DEFAULT NULL COMMENT 'EC�Ǳ�·��',
  `goods_image` varchar(200) NOT NULL COMMENT '��ƷͼƬ',
  `goods_promotion_price` varchar(10) NOT NULL COMMENT '��Ʒ������',
  `goods_marketprice` varchar(10) DEFAULT '' COMMENT '��Ʒ�г���',
  `goods_storage` int(11) NOT NULL DEFAULT '0' COMMENT '��Ʒ���',
  `goods_state` int(11) NOT NULL DEFAULT '0' COMMENT '��Ʒ״̬ 0�¼ܣ�1������10Υ�棨���ۣ�',
  `goods_sales` int(11) NOT NULL DEFAULT '0' COMMENT '�����',
  `enable` tinyint(4) NOT NULL DEFAULT '0' COMMENT '�Ƿ����� 1 ���� 0 ������',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '����ţ�ֵԽ��Խ��ǰ��',
  `sales_sort` int(11) DEFAULT '0' COMMENT '��������',
  `sync_status` tinyint(1) DEFAULT '0' COMMENT '1:�ɹ���0����ͬ����-1��ʧ��',
  `sync_time` datetime DEFAULT NULL COMMENT 'ͬ��ʱ��',
  `sync_enable` tinyint(1) DEFAULT '1' COMMENT '1:ͬ�� 0 ��ͬ��',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5264 DEFAULT CHARSET=utf8;

CREATE TABLE G_ACTIVITY_GOODS_TMP
	(ID_COL NUMBER(20),
	GROUP_ID NUMBER(10),
	GOODS_NAME VARCHAR2(150),
	GOODS_COMMONID VARCHAR2(60),
	ITEM_CODE VARCHAR2(450),
	GOODS_JINGLE VARCHAR2(600),
	GOODS_JINGLE2 VARCHAR2(600),
	GOODS_REDUCTION VARCHAR2(150),
	SUPERSCRIPT_IMAGE VARCHAR2(600),
	GOODS_IMAGE VARCHAR2(600),
	GOODS_PROMOTION_PRICE VARCHAR2(30),
	GOODS_MARKETPRICE VARCHAR2(30),
	GOODS_STORAGE NUMBER(10),
	GOODS_STATE NUMBER(10),
	GOODS_SALES NUMBER(10),
	ENABLE_COL NUMBER(4),
	CREATE_TIME DATE,
	UPDATE_TIME DATE,
	SORT_COL NUMBER(10),
	SALES_SORT NUMBER(10),
	SYNC_STATUS NUMBER(1),
	SYNC_TIME DATE,
	SYNC_ENABLE NUMBER(1));