# cadors_for_snowflake

- Sign into the Snowflake portal with SYSADMIN role.
- Execute the 'setup_env.sql' script.
- In another browser logon as 'USER_CADORS | PASSWORD' and reset the password.

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
PUT file://C:\temp\2020Q4\*.xml @"PUBLIC"."STAGE_CADORS_XML";
!exit
```