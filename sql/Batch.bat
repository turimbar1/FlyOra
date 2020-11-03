echo ===================================================================================================== 
echo "====================Capturing schema state and log history before deployment===================="
echo =====================================================================================================
 
"C:\Program Files\Red Gate\Schema Compare for Oracle 5\sco.exe" /source HR/Redgate1@localhost/dev1_shadow{HR} /target C:\VCSRepositories\OracleState{HR} /deploy /indirect
"C:\Program Files\Red Gate\Data Compare for Oracle 5\dco.exe" /source HR/Redgate1@localhost/dev1_shadow{HR} /target C:\VCSRepositories\OracleState{HR} /deploy /indirect

echo ===================================================================================================== 
echo "=================================== Deploying Changes ========================================"
echo =====================================================================================================

flyway migrate 

echo ===================================================================================================== 
echo "====================================== Rolling back ==============================================="
echo =====================================================================================================


"C:\Program Files\Red Gate\Schema Compare for Oracle 5\sco.exe" /target HR/Redgate1@localhost/dev1_shadow{HR} /source C:\VCSRepositories\OracleState{HR} /deploy /indirect
"C:\Program Files\Red Gate\Data Compare for Oracle 5\dco.exe" /target HR/Redgate1@localhost/dev1_shadow{HR} /source C:\VCSRepositories\OracleState{HR} /deploy /indirect