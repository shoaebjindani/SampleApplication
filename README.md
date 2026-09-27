# Clone the repository with submodules
git clone --recurse-submodules https://github.com/crystaldeveloper2017/SampleApplication

# Navigate to the cloned repository
cd SampleApplication

# Create the Config.yaml file
cat > /home/ubuntu/SampleApplication/src/main/resources/staticyaml/Config.yaml <<EOL
mysqlusername: ""
password: ""
host: "abcdomain.in"
port: "3306"
mySqlPath: "1"
schemaName: Sample_application_staging
projectName: Sample Application
thread_sleep: 0
isAuditEnabled: "true"
copyAttachmentsToBuffer: "false"
persistentPath: "/home/ubuntu/sampleapplication/"
queryLogEnabled: "false"
sendEmail: "false"
EOL

echo "Setup complete. Run your project and visit http://localhost:8080"