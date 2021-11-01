# cadors_for_snowflake

- Sign into the Snowflake portal with SYSADMIN role.
- Execute the 'setup_env.sql' script.
- In another browser logon as 'USER_CADORS | PASSWORD' and reset the password.
- 

### Additional Requirements
The SnowSQL command line application.

Create *%USERPROFILE%\.snowsql\config* file:
```
accountname = <account.region.cloud>
username = USER_CADORS
password = <the updated password>
```