select MEMBER_KEY,a.skw,APPLICATION_NAME,APPLICATION_NAME,MEMBER_AGE,MEMBER_AGENDA,
MEMBER_LEVEL,REGISTER_RESOURCE,CLV_TYPE,CLV_TYPE_W,MEMBER_ZONE,MEMBER_LAST_ZONE from fact_search  a  
 
 left join dim_member s on a.member_key=s.member_bp  
 where 
 a.CREATE_DATE_KEY between 20161201 and 20161231 
 
 group by MEMBER_KEY,APPLICATION_NAME,APPLICATION_NAME,MEMBER_AGE,MEMBER_AGENDA,
MEMBER_LEVEL,REGISTER_RESOURCE,CLV_TYPE,CLV_TYPE_W,MEMBER_ZONE,MEMBER_LAST_ZONE,skw
