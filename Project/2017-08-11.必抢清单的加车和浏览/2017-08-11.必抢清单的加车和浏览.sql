SELECT DISTINCT D.MEMBER_KEY
  FROM ( /*���*/
        SELECT /*+PARALLEL(16)*/
        DISTINCT A.MEMBER_KEY
          FROM FACT_PAGE_VIEW A
         WHERE A.VISIT_DATE_KEY BETWEEN 20170701 AND 20170810
           AND A.PAGE_NAME IN ('good', 'Good')
           AND A.PAGE_VALUE IN
               (SELECT TO_CHAR(A1.GOODS_COMMONID)
                  FROM DIM_GOOD A1
                 WHERE A1.ITEM_CODE IN (220337,
                                        224347,
                                        224346,
                                        202607,
                                        221264,
                                        222410,
                                        220089,
                                        220084,
                                        222417,
                                        190493,
                                        202350,
                                        221807,
                                        222411,
                                        222412,
                                        217855,
                                        222629,
                                        214261,
                                        207655,
                                        223330,
                                        204323,
                                        208745,
                                        212207,
                                        202608,
                                        218214,
                                        222066,
                                        218216,
                                        221265,
                                        220090,
                                        222609,
                                        211715,
                                        220091,
                                        222416,
                                        222408,
                                        199821,
                                        211191,
                                        210214,
                                        202358,
                                        202357,
                                        201278,
                                        204255,
                                        222062,
                                        221255,
                                        199744,
                                        205370,
                                        205371,
                                        201595,
                                        223853,
                                        213821,
                                        213822,
                                        218215,
                                        218658,
                                        218226,
                                        224399,
                                        224397,
                                        224394,
                                        224393,
                                        224395,
                                        218622,
                                        220051,
                                        190715,
                                        190714,
                                        204256,
                                        220909,
                                        210215,
                                        205374,
                                        192298,
                                        208292,
                                        203009,
                                        208293,
                                        222942,
                                        212345,
                                        222413,
                                        222414,
                                        222409,
                                        218219,
                                        221257,
                                        215379,
                                        220052,
                                        214266,
                                        222418,
                                        207941,
                                        207942,
                                        207940,
                                        207939,
                                        210440,
                                        217854,
                                        215398,
                                        215400,
                                        224398,
                                        209433,
                                        223852,
                                        218617,
                                        219510,
                                        215399,
                                        223209,
                                        209434)
                   AND A1.GOODS_COMMONID IS NOT NULL)
        UNION ALL
        /*�ӳ�*/
        SELECT /*+PARALLEL(16)*/
        DISTINCT B.MEMBER_KEY
          FROM FACT_SHOPPINGCAR B
         WHERE B.CREATE_DATE BETWEEN DATE '2017-07-01' AND DATE '2017-08-10'
        /*AND B.SCGID IN (SELECT B1.GOODS_COMMONID
         FROM DIM_GOOD B1
        WHERE B1.ITEM_CODE IN (220337,
                               224347,
                               224346,
                               202607,
                               221264,
                               222410,
                               220089,
                               220084,
                               222417,
                               190493,
                               202350,
                               221807,
                               222411,
                               222412,
                               217855,
                               222629,
                               214261,
                               207655,
                               223330,
                               204323,
                               208745,
                               212207,
                               202608,
                               218214,
                               222066,
                               218216,
                               221265,
                               220090,
                               222609,
                               211715,
                               220091,
                               222416,
                               222408,
                               199821,
                               211191,
                               210214,
                               202358,
                               202357,
                               201278,
                               204255,
                               222062,
                               221255,
                               199744,
                               205370,
                               205371,
                               201595,
                               223853,
                               213821,
                               213822,
                               218215,
                               218658,
                               218226,
                               224399,
                               224397,
                               224394,
                               224393,
                               224395,
                               218622,
                               220051,
                               190715,
                               190714,
                               204256,
                               220909,
                               210215,
                               205374,
                               192298,
                               208292,
                               203009,
                               208293,
                               222942,
                               212345,
                               222413,
                               222414,
                               222409,
                               218219,
                               221257,
                               215379,
                               220052,
                               214266,
                               222418,
                               207941,
                               207942,
                               207940,
                               207939,
                               210440,
                               217854,
                               215398,
                               215400,
                               224398,
                               209433,
                               223852,
                               218617,
                               219510,
                               215399,
                               223209,
                               209434))*/
        ) D
 ORDER BY D.MEMBER_KEY;
