----------------------------------------
-- (0) LOAD XML DATA FROM STAGE
-- https://docs.snowflake.com/en/sql-reference/sql/copy-into-table.html
----------------------------------------
USE CADORS;
COPY INTO XML_DATA FROM @"PUBLIC"."STAGE_CADORS_XML";