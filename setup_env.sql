----------------------------------------
-- (0) DROP ALL OBJECTS
----------------------------------------
USE ROLE SYSADMIN;
DROP DATABASE IF EXISTS "CADORS";
DROP WAREHOUSE IF EXISTS "WAREHOUSE_CADORS";

USE ROLE SECURITYADMIN;
DROP ROLE IF EXISTS "ROLE_CADORS";
DROP USER IF EXISTS "USER_CADORS";


----------------------------------------
-- (1) CREATE DATABASE
-- https://docs.snowflake.com/en/sql-reference/sql/create-database.html
-- https://docs.snowflake.com/en/sql-reference/sql/create-table.html
-- https://docs.snowflake.com/en/sql-reference/sql/create-file-format.html
----------------------------------------
USE ROLE SYSADMIN;
CREATE DATABASE CADORS COMMENT = "Transport Canada CADORS data.";
CREATE TABLE "CADORS"."PUBLIC"."XML_DATA" ("XML_SRC" VARIANT);

USE CADORS;
CREATE FILE FORMAT "CADORS"."PUBLIC"."CADORS_XML_DATA" 
  TYPE = 'XML' 
  COMPRESSION = 'AUTO' 
  PRESERVE_SPACE = FALSE 
  STRIP_OUTER_ELEMENT = TRUE 
  DISABLE_SNOWFLAKE_DATA = FALSE 
  DISABLE_AUTO_CONVERT = FALSE 
  IGNORE_UTF8_ERRORS = FALSE;

----------------------------------------
-- (2) CREATE WAREHOUSE
-- https://docs.snowflake.com/en/sql-reference/sql/create-warehouse.html
----------------------------------------
CREATE WAREHOUSE WAREHOUSE_CADORS
WITH WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = "Compute warehouse for CADORS.";


----------------------------------------
-- (3) CREATE ROLE AND GRANT PRIVILEGES
-- https://docs.snowflake.com/en/user-guide/security-access-control-considerations.html
-- https://docs.snowflake.com/en/sql-reference/sql/grant-privilege.html
----------------------------------------
USE ROLE SECURITYADMIN;
CREATE ROLE ROLE_CADORS;
GRANT ALL PRIVILEGES ON WAREHOUSE WAREHOUSE_CADORS TO ROLE ROLE_CADORS;
GRANT CREATE SCHEMA, MODIFY, MONITOR, USAGE ON DATABASE CADORS TO ROLE_CADORS;
GRANT USAGE ON DATABASE CADORS TO ROLE_CADORS;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE CADORS TO ROLE_CADORS;
GRANT SELECT ON FUTURE TABLES IN DATABASE CADORS TO ROLE_CADORS;
GRANT SELECT ON FUTURE VIEWS IN DATABASE CADORS TO ROLE_CADORS;
GRANT USAGE ON FUTURE FUNCTIONS IN DATABASE CADORS TO ROLE_CADORS;


----------------------------------------
-- (4) CREATE USER
-- https://docs.snowflake.com/en/sql-reference/sql/create-user.html
----------------------------------------
CREATE USER USER_CADORS
  MUST_CHANGE_PASSWORD = TRUE
  DEFAULT_ROLE = ROLE_CADORS
  DEFAULT_WAREHOUSE = WAREHOUSE_CADORS
  PASSWORD = 'PASSWORD'; 
GRANT ROLE ROLE_CADORS TO USER USER_CADORS;


----------------------------------------
-- (5) VALIDATE THE CONFIGURATION
-- https://docs.snowflake.com/en/sql-reference/sql/show.html
----------------------------------------
USE ROLE SYSADMIN;
SHOW DATABASES LIKE 'CADORS';
SHOW WAREHOUSES LIKE 'WAREHOUSE_CADORS';

USE ROLE SECURITYADMIN;
SHOW ROLES LIKE 'ROLE_CADORS';
SHOW GRANTS TO ROLE ROLE_CADORS;
SHOW GRANTS OF ROLE ROLE_CADORS;
SHOW USERS LIKE 'USER_CADORS';


----------------------------------------
-- (6) CREATE INTERNAL STAGE
-- https://docs.snowflake.com/en/sql-reference/sql/create-stage.html
----------------------------------------
USE ROLE SYSADMIN;
CREATE STAGE IF NOT EXISTS STAGE_CADORS_XML
  FILE_FORMAT = ( FORMAT_NAME  = 'CADORS_XML_DATA' )
  COPY_OPTIONS = ( ON_ERROR = SKIP_FILE )
  COMMENT = 'Internal stage for CADORS XML data files.'