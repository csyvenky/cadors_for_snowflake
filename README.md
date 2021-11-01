# cadors_for_snowflake

1. Sign into the Snowflake portal with SYSADMIN role.
2. Execute the 'setup_env.sql' script.
3. In another browser logon as 'USER_CADORS | PASSWORD' and reset the password.
4. Execute the steps from the *Upload XML Data Files* section below.
5. Execute the 'load_data.sql' script.

### Additional Requirements
The SnowSQL command line application.

Create $env:USERPROFILE\.snowsql\config file:
```
accountname = <account.region.cloud>
username = USER_CADORS
password = <the updated password>
```

### Upload XML Data Files (to internal stage)
```
# Connect with CLI
snowsql --dbname CADORS --config $env:USERPROFILE\.snowsql\config
# https://docs.snowflake.com/en/sql-reference/sql/put.html
PUT $$file://C:\Users\cory\OneDrive - Force 1024\Attachments\cadors_xml\*.xml$$ @"PUBLIC"."STAGE_CADORS_XML"; 
!exit
```