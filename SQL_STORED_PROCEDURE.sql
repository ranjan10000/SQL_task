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

------------------------------------------------------------------------------------------------------------
CREATE TABLE DEMO(DEMOID VARCHAR(50),FNAME VARCHAR(50),LNAME VARCHAR(50))

INSERT INTO DEMO(DEMOID,FNAME,LNAME)VALUES('1','VIRAT','KHOLI')

SELECT * FROM DEMO

ALTER PROCEDURE INSERTDEMO(@JSON NVARCHAR(MAX))
AS
BEGIN

DECLARE @ID VARCHAR(100)
DECLARE @RESPONSE VARCHAR(100)

--  RESPONSE DATA --
SET @ID = (SELECT * FROM OPENJSON(@JSON)                
 WITH (DEMOID VARCHAR(50)));                
      --**--          
INSERT INTO DEMO              
 SELECT *  FROM OPENJSON(@JSON)                
 WITH (  
    DEMOID varchar(200),                
    FNAME varchar(200),                
    LNAME varchar(200)      
)   
SET @RESPONSE = N'{
"ID":"'+@ID+'",
"STATUS":"SUCCESS"
"DISCRIPTION":"INSERT PROCEDURE"
}'
SELECT @RESPONSE AS responseJson
END
GO


EXEC INSERTDEMO @JSON ='{"DEMOID":"2","FNAME":"MS","LNAME":"DHONI"}'

------------------------------------------------------------------------------------------

USE [INCIDENTTRACK_DB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_new_rolefilter]
    @JSON NVARCHAR(MAX)
AS
BEGIN
    -- Parse JSON to extract criteria
    DECLARE @RoleName NVARCHAR(255);
    DECLARE @FeatureNames NVARCHAR(MAX);
    DECLARE @Status NVARCHAR(255);

    -- Parse JSON input
    SELECT @RoleName = NULLIF(ISNULL(JSON_VALUE(@JSON, '$.RoleName'), ''), ''),
           @FeatureNames = NULLIF(ISNULL(JSON_VALUE(@JSON, '$.FeatureName'), ''), ''),
           @Status = NULLIF(ISNULL(JSON_VALUE(@JSON, '$.Status'), ''), '');

    -- Create a temporary table to store the filtered results
    CREATE TABLE #TEMP (
        ID INT,
        CREATEDBY VARCHAR(255),
        CREATEDON VARCHAR(255),
        ROLENAME VARCHAR(255),
        STATUS VARCHAR(255),
        UPDATEDBY VARCHAR(255),
        UPDATEDON VARCHAR(255),
        ROLEFEATURES VARCHAR(255),
        FEATURES VARCHAR(255)
    );

    -- Split feature names into individual rows
    ;WITH FeatureNameSplit AS (
        SELECT 
            value AS FeatureName
        FROM 
            STRING_SPLIT(@FeatureNames, ',')
    )

    -- Insert filtered data into #TEMP based on the provided filters
    INSERT INTO #TEMP (
        ID, CREATEDBY, CREATEDON, ROLENAME, STATUS, UPDATEDBY, UPDATEDON, ROLEFEATURES, FEATURES
    )
    SELECT DISTINCT
        R.ID,
        R.CREATED_BY, 
        R.CREATED_ON, 
        R.ROLE_NAME,
        R.STATUS,
        R.UPDATED_BY,
        R.UPDATED_ON,
        RF.ROLE_ID AS ROLEFEATURES,
        STUFF((SELECT ', ' + F.FEATURE_NAME
               FROM dbo.ROLE_FEATURES RF1
               INNER JOIN dbo.FEATURES F ON RF1.FEATURE_ID = F.ID
               WHERE RF1.ROLE_ID = R.ID
               FOR XML PATH('')), 1, 2, '') AS FEATURES
    FROM dbo.ROLES R
    INNER JOIN dbo.ROLE_FEATURES RF ON R.ID = RF.ROLE_ID
    WHERE 
        (@FeatureNames IS NULL OR EXISTS (
            SELECT 1
            FROM FeatureNameSplit FNS
            WHERE CHARINDEX(FNS.FeatureName, R.ROLE_NAME) > 0
        ))
        AND
        (@RoleName IS NULL OR R.ROLE_NAME = @RoleName)
        AND
        (@Status IS NULL OR R.STATUS = @Status);

    -- Select the results from the #TEMP table as JSON
    SELECT * FROM #TEMP FOR JSON AUTO;

    -- Drop the #TEMP table after use
    DROP TABLE #TEMP;
END;



DECLARE @JSON NVARCHAR(MAX);
-- Set your JSON input here
SET @JSON = N'{
    "RoleName": "",
    "FeatureName": "Manager Profile ,Role Management",
    "Status": "Active"
}';

-- Execute the stored procedure
EXEC [dbo].[sp_new_rolefilter] @JSON;


Select * from ROLES
select * from FEATURES
Select * from [dbo].[ROLE_FEATURES]




