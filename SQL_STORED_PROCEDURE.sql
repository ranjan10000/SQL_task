USE [ENBD_VER_2]
GO

/****** Object:  StoredProcedure [dbo].[sp_disposition_insert]    Script Date: 06/06/2023 16:49:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
 -- INSERT STORED PROCEDURE --

CREATE procedure [dbo].[sp_disposition_insert] (                
@JSON NVARCHAR(MAX)                
)                
AS                
BEGIN                
DECLARE @id VARCHAR(100)                
DECLARE @output NVARCHAR(max)                
                
    --select * from widget_category_list            
SET @id = (SELECT * FROM OPENJSON(@JSON)                
 WITH (id VARCHAR(50)));                
                
INSERT INTO insert_disposition               
 SELECT *  FROM OPENJSON(@JSON)                
 WITH (  
    disposition_name varchar(200),                
    disposition_status varchar(200),                
    discription varchar(200)      
)      
                
set @output= N'{                
 "id":"' + @id+ '",                
 "status":"Success",                
 "description":"Category Details Added Successfully"                
}'                
                
  SELECT @output AS responseJson                
END 
GO

exec sp_disposition_update @JSON='{"id":"37","disposition_name":"RANJU","disposition_status":"UPDATE","discription":"UPDATE"}'



-- DELETE STORED PROCEDURE --

USE [ENBD_VER_2]
GO

/****** Object:  StoredProcedure [dbo].[sp_disposition_delete]    Script Date: 07/06/2023 11:10:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_disposition_delete](@JSON nvarchar(max))  
 as  
 begin  
  Declare @id nvarchar(50)=''  
  Declare @response nvarchar(500)=''  
  Select @id =id from OPENJSON(@JSON)WITH(id nvarchar(50))  
  
  delete from insert_disposition where id=@id  
  
  set @response=N'{  
  "ref_id":"'+@id+'",  
  "status":"Success",  
  "description":"Category table row deleted successfully"  
  }'  
  
  Select @response as responseJson  
 end  
GO

-- UPDATE STORED PROCEDURE -- 

USE [ENBD_VER_2]
GO

/****** Object:  StoredProcedure [dbo].[sp_disposition_update]    Script Date: 07/06/2023 11:10:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_disposition_update](@JSON nvarchar(max))  
 as  
 begin  
 Declare @id varchar(200)=''  
 Declare @disposition_name nvarchar(50)=''  
 Declare @disposition_status nvarchar(500)=''  
 Declare @discription nvarchar(500)='' 
 Declare @response nvarchar(500)='' 
 Select @id =id from OPENJSON(@JSON)WITH(id nvarchar(50))  

UPDATE c
SET

c.disposition_name=J.disposition_name,
c.disposition_status=J.disposition_status,
c.discription=J.discription

FROM insert_disposition AS c

JOIN OPENJSON(@JSON) WITH (id varchar(200) ,disposition_name varchar(200),disposition_status varchar(200),discription varchar(200)) J on J.id=c.id
  
 set @response=N'{  
 "id":"'+@id+'",  
 "status":"Success",  
 "description":"Category Details updated successfully"  
 }'  
  
 Select @response as responseJson  
 end 
GO


