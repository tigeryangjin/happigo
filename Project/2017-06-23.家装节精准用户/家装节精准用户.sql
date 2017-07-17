--在6月对附件表单中商品有购买/加购物车行为的用户明细明细具体字段要求有BP号最后的结果有两个字段（BP号 订购渠道（10，20，30））
--订购
select distinct a.member_key, a.sales_source_key
  from fact_goods_sales a
 where a.posting_date_key between 20170601 and 20170630
   and a.order_state = 1
   and a.goods_common_key in (217442,
                              209785,
                              216991,
                              217467,
                              216992,
                              219547,
                              217443,
                              215650,
                              187788,
                              202855,
                              202854,
                              208884,
                              219548,
                              215651,
                              193935,
                              208883,
                              217464,
                              219545,
                              194926,
                              215553,
                              203145,
                              193914,
                              202852,
                              202857,
                              193923,
                              202853,
                              202858,
                              207521,
                              217444,
                              219549,
                              219620,
                              219621,
                              219622,
                              219623,
                              221398,
                              221399,
                              221410,
                              221411,
                              207509,
                              216953,
                              216956,
                              218053,
                              204322,
                              216952,
                              218052,
                              190912,
                              214966,
                              214967,
                              182321,
                              182322,
                              190913,
                              214965,
                              204321,
                              216955,
                              214964,
                              201030,
                              217769,
                              215983,
                              215982,
                              202367,
                              202380,
                              200372,
                              201029,
                              201040,
                              201041,
                              200765,
                              200766,
                              196919,
                              196920,
                              196909,
                              196930,
                              199825,
                              199358,
                              199359,
                              201868,
                              196919,
                              216816,
                              216817,
                              216818,
                              216830,
                              216831,
                              216832,
                              216833,
                              216834,
                              216836,
                              216837,
                              216839,
                              216840,
                              216842,
                              216843,
                              216637,
                              216635,
                              217758,
                              217800,
                              217804,
                              214709,
                              214704,
                              196930,
                              196909,
                              209037,
                              189550,
                              189551,
                              189553,
                              212090,
                              208117,
                              215511,
                              188885,
                              219348,
                              219350,
                              219354,
                              217771,
                              217770,
                              216577,
                              218552,
                              220031,
                              216620,
                              216579,
                              216578,
                              214703,
                              214704,
                              214708,
                              214709,
                              196930,
                              196920,
                              196919,
                              196909,
                              217843,
                              201030,
                              217839,
                              203735,
                              189550,
                              212090,
                              189553,
                              189551,
                              213793,
                              213790,
                              213791,
                              205110,
                              214053,
                              220353,
                              220354,
                              206576,
                              219237,
                              216617,
                              215103,
                              216618,
                              218201,
                              215519,
                              218200,
                              216988,
                              214970,
                              214971,
                              216986,
                              219115,
                              216733,
                              222110,
                              222111,
                              222112,
                              222113,
                              222114,
                              222115,
                              222116,
                              222117,
                              222118,
                              222119,
                              222120,
                              222121,
                              222122,
                              222123,
                              222124,
                              222125,
                              222126,
                              222127,
                              222128,
                              222129,
                              222130,
                              222131,
                              222132,
                              222133)
 order by 1, 2;

--加购物车
select distinct a.member_key, a.application_key
  from fact_shoppingcar a
 where a.create_date_key between 20170601 and 20170630
   and a.scgid in (select b.goods_commonid
                     from dim_good b
                    where b.item_code in (217442,
                                          209785,
                                          216991,
                                          217467,
                                          216992,
                                          219547,
                                          217443,
                                          215650,
                                          187788,
                                          202855,
                                          202854,
                                          208884,
                                          219548,
                                          215651,
                                          193935,
                                          208883,
                                          217464,
                                          219545,
                                          194926,
                                          215553,
                                          203145,
                                          193914,
                                          202852,
                                          202857,
                                          193923,
                                          202853,
                                          202858,
                                          207521,
                                          217444,
                                          219549,
                                          219620,
                                          219621,
                                          219622,
                                          219623,
                                          221398,
                                          221399,
                                          221410,
                                          221411,
                                          207509,
                                          216953,
                                          216956,
                                          218053,
                                          204322,
                                          216952,
                                          218052,
                                          190912,
                                          214966,
                                          214967,
                                          182321,
                                          182322,
                                          190913,
                                          214965,
                                          204321,
                                          216955,
                                          214964,
                                          201030,
                                          217769,
                                          215983,
                                          215982,
                                          202367,
                                          202380,
                                          200372,
                                          201029,
                                          201040,
                                          201041,
                                          200765,
                                          200766,
                                          196919,
                                          196920,
                                          196909,
                                          196930,
                                          199825,
                                          199358,
                                          199359,
                                          201868,
                                          196919,
                                          216816,
                                          216817,
                                          216818,
                                          216830,
                                          216831,
                                          216832,
                                          216833,
                                          216834,
                                          216836,
                                          216837,
                                          216839,
                                          216840,
                                          216842,
                                          216843,
                                          216637,
                                          216635,
                                          217758,
                                          217800,
                                          217804,
                                          214709,
                                          214704,
                                          196930,
                                          196909,
                                          209037,
                                          189550,
                                          189551,
                                          189553,
                                          212090,
                                          208117,
                                          215511,
                                          188885,
                                          219348,
                                          219350,
                                          219354,
                                          217771,
                                          217770,
                                          216577,
                                          218552,
                                          220031,
                                          216620,
                                          216579,
                                          216578,
                                          214703,
                                          214704,
                                          214708,
                                          214709,
                                          196930,
                                          196920,
                                          196919,
                                          196909,
                                          217843,
                                          201030,
                                          217839,
                                          203735,
                                          189550,
                                          212090,
                                          189553,
                                          189551,
                                          213793,
                                          213790,
                                          213791,
                                          205110,
                                          214053,
                                          220353,
                                          220354,
                                          206576,
                                          219237,
                                          216617,
                                          215103,
                                          216618,
                                          218201,
                                          215519,
                                          218200,
                                          216988,
                                          214970,
                                          214971,
                                          216986,
                                          219115,
                                          216733,
                                          222110,
                                          222111,
                                          222112,
                                          222113,
                                          222114,
                                          222115,
                                          222116,
                                          222117,
                                          222118,
                                          222119,
                                          222120,
                                          222121,
                                          222122,
                                          222123,
                                          222124,
                                          222125,
                                          222126,
                                          222127,
                                          222128,
                                          222129,
                                          222130,
                                          222131,
                                          222132,
                                          222133))
 order by 1, 2;

