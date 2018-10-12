--1.
SELECT 'alter database datafile ''' || A.FILE_NAME || ''' resize ' ||
       ROUND(A.FILESIZE - (A.FILESIZE - C.HWMSIZE - 100) * 0.8) || 'M;' S,
       A.FILESIZE AS "数据文件的总大小(M)",
       C.HWMSIZE AS "数据文件的实用大小(M)",
       A.FILESIZE -
       ROUND(A.FILESIZE - (A.FILESIZE - C.HWMSIZE - 100) * 0.8) AS "收缩大小(M)"
  FROM (SELECT FILE_ID, FILE_NAME, ROUND(BYTES / 1024 / 1024) AS FILESIZE
          FROM DBA_DATA_FILES GG
         WHERE GG.TABLESPACE_NAME = 'DB_LOGISTICS') A,
       (SELECT FILE_ID, ROUND(MAX(BLOCK_ID) * 8 / 1024) AS HWMSIZE
          FROM DBA_EXTENTS GGG
         WHERE GGG.TABLESPACE_NAME = 'DB_LOGISTICS'
         GROUP BY FILE_ID) C
 WHERE A.FILE_ID = C.FILE_ID
   AND ROUND(A.FILESIZE - (A.FILESIZE - C.HWMSIZE - 100) * 0.8) > 100
 ORDER BY 4 DESC;

--2.回收站
SELECT * FROM DBA_RECYCLEBIN;

PURGE DBA_RECYCLEBIN;

--tmp
alter database datafile '/data/u01/oradata/bihappigo/logistics03.dbf' resize 29941M;




