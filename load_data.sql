----------------------------------------
-- (0) LOAD XML DATA FROM STAGE
----------------------------------------
USE CADORS;
COPY INTO XML_DATA FROM @"PUBLIC"."STAGE_CADORS_XML";