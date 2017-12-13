SELECT A.MEMBER_KEY,
       A.VID,
       A.OPEN_ID,
       A.CREATE_DATE_KEY,
       A.PUSH_ID,
       COUNT(1)
  FROM DIM_MAPPING_MEM A
 GROUP BY A.MEMBER_KEY, A.VID, A.OPEN_ID, A.CREATE_DATE_KEY, A.PUSH_ID
HAVING COUNT(1) > 1;
