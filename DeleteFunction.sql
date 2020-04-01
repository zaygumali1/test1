select * from dbo.receipts
declare  @i int 
set @i =1
while @i<=10


select * into dbo.tempreceipts1 from dbo.receipts

select * into dbo.tempreceipts2 from dbo.receipts

select * into dbo.tempreceipts3 from dbo.receipts

select * into dbo.tempreceipts4 from dbo.receipts


-----
select * from sys.sysusers


create function checkTemp(@username varchar(20),@tbtype varchar(20))
returns @table table
(tablename nvarchar(max),
 createdBy nvarchar(max),
 createddate nvarchar(max)
 )
 as
 begin
 With tbllist(TblName,CreatedBy,Date)
   as 
   (
      
     select so.name,su.name,so.crdate from sysobjects so join sys.sysusers su on so.uid=su.uid  where SO.xtype='U'
	 su.name like '%'+@username+'%' and so.name like @tbtype +'%'
	 
   )
     insert into @table
	 select * from tbllist
	 return
 end

 select * from sys.sysusers

 DROP TABLE tempp
 
 select * from checkTemp('dbo','temp') 
DECLARE @TBNAME NVARCHAR(MAX)
DECLARE @SQL NVARCHAR(MAX)
WHILE EXISTS (SELECT * from sys.tables t cross apply checkTemp('dbo','temp') tt where t.name=tt.tablename)
BEGIN
SET @TBNAME=(SELECT   TOP 1 T.name from sys.tables t cross apply checkTemp('dbo','temp') tt where t.name=tt.tablename)
SET @SQL='DROP TABLE '+ @TBNAME
    EXEC SP_EXECUTESQL @SQL
END




SELECT * FROM SYSOBJECTS WHERE NAME LIKE '%TEMP%'




 select * from sys.sysusers

select * from sysobjects so join sys.sysusers su on so.uid=su.uid where so.name



