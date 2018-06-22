--1.添加商品计算标签
begin
  -- Call the procedure
  goods_label_pkg.create_goods_label(in_g_label_name      => 'GOODS_EVALUATION_COST_PERFORMANCE_LOW',
                                     in_g_label_desc      => '商品的用户口碑标签(性价比)_低',
                                     in_g_label_type_id   => 1,
                                     in_is_leaf_node      => 1, /*是否叶节点*/
                                     in_g_label_father_id => 1110);
end;
/

  SELECT * FROM GOODS_LABEL_HEAD A ORDER BY A.G_LABEL_ID DESC FOR UPDATE;

SELECT * FROM GOODS_LABEL_HEAD_LEVEL_V A WHERE A.LV1_ID = 1080;

--2.
/*
版型/款式STYLE
包装PACKING
保暖性WARMTH_RETENTION
功能FUNCTION
卖家服务SELLER_SERVICE
面料/材质MATERIAL
物流LOGISTICS
性价比COST_PERFORMANCE
*/

--3.

SELECT D.ITEM_CODE,
       D.ASPECT_CATEGORY,
       E.LV2_NAME || '_' || D.EVA_LEVEL G_LABEL_NAME,
       D.EVA_COUNT,
       D.EVA_POSITIVE_COUNT,
       D.EVA_NEGATIVE_COUNT
  FROM (SELECT C.ITEM_CODE,
               C.ASPECT_CATEGORY,
               C.EVA_COUNT,
               C.EVA_POSITIVE_COUNT,
               C.EVA_NEGATIVE_COUNT,
               CASE
                 WHEN C.EVA_POSITIVE_PER < 0.7 THEN
                  'LOW'
                 WHEN C.EVA_POSITIVE_PER >= 0.7 AND C.EVA_POSITIVE_PER < 0.9 THEN
                  'MEDIUM'
                 WHEN C.EVA_POSITIVE_PER >= 0.7 THEN
                  'HIGH'
               END EVA_LEVEL
          FROM (SELECT B.ITEM_CODE,
                       B.ASPECT_CATEGORY,
                       COUNT(1) EVA_COUNT,
                       SUM(B.COL1) EVA_POSITIVE_COUNT,
                       SUM(B.COL2) EVA_NEGATIVE_COUNT,
                       ROUND(SUM(B.COL1) / COUNT(1), 2) EVA_POSITIVE_PER
                  FROM (SELECT A.GEVAL_GOODSID ITEM_CODE,
                               A.ASPECT_CATEGORY,
                               A.ASPECT_POLARITY,
                               CASE
                                 WHEN A.ASPECT_POLARITY = '正' THEN
                                  1
                                 ELSE
                                  0
                               END COL1,
                               CASE
                                 WHEN A.ASPECT_POLARITY = '负' THEN
                                  1
                                 ELSE
                                  0
                               END COL2
                          FROM FACT_GOODS_EVALUATE_ALIYUN A) B
                 GROUP BY B.ITEM_CODE, B.ASPECT_CATEGORY) C
         WHERE C.EVA_COUNT >= 10 /*评论数大于10才打商品标签*/
        ) D,
       (SELECT DISTINCT F.LV2_NAME,
                        SUBSTR(F.LV2_DESC,
                               INSTR(F.LV2_DESC, '(', 1) + 1,
                               INSTR(F.LV2_DESC, ')', 1) -
                               INSTR(F.LV2_DESC, '(', 1) - 1) ASPECT_CATEGORY
          FROM GOODS_LABEL_HEAD_LEVEL_V F
         WHERE F.LV1_ID = 1080) E
 WHERE D.ASPECT_CATEGORY = E.ASPECT_CATEGORY;

--tmp.
SELECT DISTINCT F.LV2_NAME,
                SUBSTR(F.LV2_DESC,
                       INSTR(F.LV2_DESC, '(', 1) + 1,
                       INSTR(F.LV2_DESC, ')', 1) - INSTR(F.LV2_DESC, '(', 1) - 1) ASPECT_CATEGORY
  FROM GOODS_LABEL_HEAD_LEVEL_V F
 WHERE F.LV1_ID = 1080;
SELECT A.GEVAL_ID, COUNT(1)
  FROM FACT_GOODS_EVALUATE_ALIYUN A
 GROUP BY A.GEVAL_ID
 ORDER BY COUNT(1) DESC;
SELECT * FROM FACT_GOODS_EVALUATE_ALIYUN A WHERE A.GEVAL_ID = 836905;
SELECT * FROM FACT_GOODS_EVALUATE A WHERE A.GEVAL_ID = 836905;
SELECT DISTINCT A.ASPECT_CATEGORY, A.ASPECT_TERM
  FROM FACT_GOODS_EVALUATE_ALIYUN A
 ORDER BY 1, 2;

SELECT DISTINCT A.ASPECT_CATEGORY
  FROM FACT_GOODS_EVALUATE_ALIYUN A
 ORDER BY 1;
