#!/bin/bash

# Complete Jenkins Setup Script for Steps B, C, D

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Jenkins Complete Setup Script${NC}"
echo "=================================="

# Step B: Check plugins
echo -e "${YELLOW}Step B: Checking required plugins...${NC}"

JENKINS_HOME="/var/lib/jenkins"
PLUGINS_NEEDED=("pipeline-aws" "aws-java-sdk" "http_request")
MISSING_PLUGINS=()

for plugin in "${PLUGINS_NEEDED[@]}"; do
    if sudo ls "$JENKINS_HOME/plugins/" 2>/dev/null | grep -q "^${plugin}"; then
        echo -e "${GREEN}Found: $plugin${NC}"
    else
        echo -e "${RED}Missing: $plugin${NC}"
        MISSING_PLUGINS+=("$plugin")
    fi
done

if [ ${#MISSING_PLUGINS[@]} -gt 0 ]; then
    echo -e "${YELLOW}You need to install these plugins manually in Jenkins:${NC}"
    for plugin in "${MISSING_PLUGINS[@]}"; do
        echo "  - $plugin"
    done
    echo -e "${YELLOW}Go to: http://localhost:8080 -> Manage Jenkins -> Manage Plugins${NC}"
fi

# Step C: Check if we can create credentials via CLI
echo -e "${YELLOW}Step C: AWS Credentials setup...${NC}"

# Get current AWS credentials
AWS_ACCESS_KEY=$(aws configure get aws_access_key_id)
AWS_SECRET_KEY=$(aws configure get aws_secret_access_key)

if [ -n "$AWS_ACCESS_KEY" ] && [ -n "$AWS_SECRET_KEY" ]; then
    echo -e "${GREEN}AWS credentials found in local config${NC}"
    echo "Access Key: ${AWS_ACCESS_KEY:0:8}..."
    echo -e "${YELLOW}You'll need to add these to Jenkins manually:${NC}"
    echo "1. Go to: http://localhost:8080"
    echo "2. Manage Jenkins -> Manage Credentials"
    echo "3. System -> Global credentials -> Add Credentials"
    echo "4. Kind: AWS Credentials"
    echo "5. ID: aws-s3-credentials"
    echo "6. Access Key: $AWS_ACCESS_KEY"
    echo "7. Secret Key: [Your secret key]"
else
    echo -e "${RED}No AWS credentials found. Please configure AWS CLI first.${NC}"
fi

# Step D: Create Jenkins job configuration
echo -e "${YELLOW}Step D: Creating Jenkins job configuration...${NC}"

JOB_CONFIG_XML="<?xml version='1.1' encoding='UTF-8'?>
<flow-definition plugin=\"workflow-job@2.40\">
  <actions/>
  <description>Automated deployment of minimal website to AWS S3</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin=\"github@1.34.1\">
      <projectUrl>https://github.com/Copubah/my-minimal-website/</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <com.cloudbees.jenkins.GitHubPushTrigger plugin=\"github@1.34.1\">
          <spec></spec>
        </com.cloudbees.jenkins.GitHubPushTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class=\"org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition\" plugin=\"workflow-cps@2.87\">
    <scm class=\"hudson.plugins.git.GitSCM\" plugin=\"git@4.8.2\">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/Copubah/my-minimal-website.git</url>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/main</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class=\"list\"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
    <lightweight>true</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>"

# Create job directory and config
JOB_DIR="$JENKINS_HOME/jobs/my-website-deployment"
sudo mkdir -p "$JOB_DIR"
echo "$JOB_CONFIG_XML" | sudo tee "$JOB_DIR/config.xml" > /dev/null
sudo chown -R jenkins:jenkins "$JOB_DIR"

echo -e "${GREEN}Jenkins job configuration created!${NC}"

# Restart Jenkins to load new job
echo -e "${YELLOW}Restarting Jenkins to load new configuration...${NC}"
sudo systemctl restart jenkins

echo -e "${GREEN}Setup completed!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Wait for Jenkins to restart (30 seconds)"
echo "2. Go to: http://localhost:8080"
echo "3. Install missing plugins if any"
echo "4. Add AWS credentials manually"
echo "5. Test the pipeline: my-website-deployment -> Build Now"

echo ""
echo -e "${BLUE}Your pipeline job 'my-website-deployment' has been created!${NC}"