```bash
# Clone the repository with submodules
git clone --recurse-submodules https://github.com/crystaldeveloper2017/SocietyMaintenence

# Navigate to the cloned repository
cd SocietyMaintenence

# Create the Config.yaml file
mkdir -p ./src/com/crystal/customizedpos/Configuration/

cat > ./src/com/crystal/customizedpos/Configuration/Config.yaml <<EOL
mysqlusername: ""
password: ""
host: "abcdomain.in"
port: "3306"
mySqlPath: "1"
schemaName: society_maintenance_staging
projectName: Akibah Heights
thread_sleep: 0
isAuditEnabled: "true"
copyAttachmentsToBuffer: "false"
persistentPath: "/home/ubuntu/ags_attachments/"
queryLogEnabled: "false"
sendEmail: "false"
EOL

echo "Setup complete. Run your project and visit http://localhost:8080."
