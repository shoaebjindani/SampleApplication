# Sample Application

## 1. Clone the Repository

Clone the repository along with its Git submodules:

```bash
git clone --recurse-submodules https://github.com/crystaldeveloper2017/SampleApplication.git
cd SampleApplication
```

## 2. Configure the Application

Create the application configuration file:

```bash
mkdir -p src/main/resources/staticyaml

cat > src/main/resources/staticyaml/Config.yaml <<'EOL'
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
```

### Configuration

Update the following values according to your environment:

| Property | Description |
|---|---|
| `mysqlusername` | MySQL database username |
| `password` | MySQL database password |
| `host` | MySQL server hostname/IP |
| `port` | MySQL server port |
| `schemaName` | MySQL database/schema name |
| `persistentPath` | Directory used for persistent application data |

> **Important:** Do not commit `Config.yaml` if it contains database credentials or other sensitive information.

## 3. Build and Run

Build the application using your configured Maven/Java environment.

For example:

```bash
./mvnw clean package
```

Then deploy or run the generated application according to your server configuration.

## 4. Access the Application

Once the application is running, open:

```text
http://localhost:8080
```

## Setup Complete

The basic application setup is now complete.
