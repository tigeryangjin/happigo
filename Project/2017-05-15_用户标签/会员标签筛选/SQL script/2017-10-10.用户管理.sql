--mysql
CREATE TABLE `sys_admin` (
  `aid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员表自增id即管理员id',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员账号',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `login_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '账户更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账户创建时间',
  `login_ip` char(15) DEFAULT '''''' COMMENT '登录ip',
  `rid` int(11) unsigned DEFAULT '0' COMMENT '角色id',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理员表';


--oracle
CREATE TABLE ml_user (
  aid number(10) NOT NULL ,
  username varchar2(32) NOT NULL ,
  password varchar2(32) NOT NULL ,
  login_time date NOT NULL ,
  update_time date NOT NULL ,
  create_time date NOT NULL ,
  login_ip varchar2(15) ,
  rid number(10) DEFAULT '0' 
) ;
-- Add comments to the table 
comment on table ml_user
  is '管理员表';
-- Add comments to the columns 
comment on column ml_user.aid
  is '管理员表自增id即管理员id';
comment on column ml_user.username
  is '管理员账号';
comment on column ml_user.password
  is '管理员密码';
comment on column ml_user.login_time
  is '登录时间';
comment on column ml_user.update_time
  is '账户更新时间';
comment on column ml_user.create_time
  is '账户创建时间';
comment on column ml_user.login_ip
  is '登录ip';
comment on column ml_user.rid
  is '角色id';
