echo "Capturing schema state and log history before deployment"
"C:\Program Files\Red Gate\Schema Compare for Oracle 5\sco.exe" /source HR/Redgate1@localhost/dev1_shadow{HR} /target C:\VCSRepositories\OracleState{HR} /deploy /indirect
"C:\Program Files\Red Gate\Data Compare for Oracle 5\dco.exe" /source HR/Redgate1@localhost/dev1_shadow{HR} /target C:\VCSRepositories\OracleState{HR} /deploy /indirect

echo "Deploying changes"
flyway migrate exit code:%ERRORLEVEL%
IF %ERRORLEVEL% (
    echo ========================================================================================================
    echo == High Severity Warnings Detected! Aborting the build. 
    echo == Review the deployment script and consider deploying manually.
    echo ========================================================================================================
    echo "Rolling back"
    "C:\Program Files\Red Gate\Schema Compare for Oracle 5\sco.exe" /target HR/Redgate1@localhost/dev1_shadow{HR} /source C:\VCSRepositories\OracleState{HR} /deploy /indirect
    "C:\Program Files\Red Gate\Data Compare for Oracle 5\dco.exe" /target HR/Redgate1@localhost/dev1_shadow{HR} /source C:\VCSRepositories\OracleState{HR} /deploy /indirect
)