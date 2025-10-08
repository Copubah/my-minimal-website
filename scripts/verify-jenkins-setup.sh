#!/bin/bash

# Jenkins Setup Verification Script
# Verifies Jenkins installation, plugins, and configuration
# Usage: ./verify-jenkins-setup.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE} Jenkins Setup Verification${NC}"
echo "=================================="

# Check Jenkins is running
echo -e "${YELLOW}1. Checking Jenkins service...${NC}"
if systemctl is-active --quiet jenkins; then
    echo -e "${GREEN} Jenkins is running${NC}"
else
    echo -e "${RED} Jenkins is not running${NC}"
    exit 1
fi

# Check Jenkins web interface
echo -e "${YELLOW}2. Checking Jenkins web interface...${NC}"
if curl -s http://localhost:8080 > /dev/null; then
    echo -e "${GREEN} Jenkins web interface accessible${NC}"
else
    echo -e "${RED} Jenkins web interface not accessible${NC}"
fi

# Check if plugins directory exists and has content
echo -e "${YELLOW}3. Checking installed plugins...${NC}"
PLUGIN_COUNT=$(sudo ls /var/lib/jenkins/plugins/ 2>/dev/null | wc -l)
if [ $PLUGIN_COUNT -gt 0 ]; then
    echo -e "${GREEN} $PLUGIN_COUNT plugins installed${NC}"
    
    # Check for specific required plugins
    if sudo ls /var/lib/jenkins/plugins/ | grep -q "github"; then
        echo -e "${GREEN}   GitHub plugin found${NC}"
    else
        echo -e "${YELLOW}    GitHub plugin not found${NC}"
    fi
    
    if sudo ls /var/lib/jenkins/plugins/ | grep -q "pipeline"; then
        echo -e "${GREEN}   Pipeline plugins found${NC}"
    else
        echo -e "${YELLOW}    Pipeline plugins not found${NC}"
    fi
else
    echo -e "${RED} No plugins found${NC}"
fi

# Check if credentials exist
echo -e "${YELLOW}4. Checking credentials configuration...${NC}"
if sudo test -f /var/lib/jenkins/credentials.xml; then
    echo -e "${GREEN} Credentials file exists${NC}"
else
    echo -e "${YELLOW}  No credentials configured yet${NC}"
fi

# Check if jobs exist
echo -e "${YELLOW}5. Checking for pipeline jobs...${NC}"
JOB_COUNT=$(sudo ls /var/lib/jenkins/jobs/ 2>/dev/null | wc -l)
if [ $JOB_COUNT -gt 0 ]; then
    echo -e "${GREEN} $JOB_COUNT job(s) configured${NC}"
    sudo ls /var/lib/jenkins/jobs/ 2>/dev/null | while read job; do
        echo -e "${GREEN}   Job: $job${NC}"
    done
else
    echo -e "${YELLOW}  No jobs configured yet${NC}"
fi

echo ""
echo -e "${BLUE} Next Steps:${NC}"
echo "1. Open Jenkins: http://localhost:8080"
echo "2. Follow: scripts/jenkins-step-by-step.md"
echo "3. Install missing plugins if any"
echo "4. Add AWS credentials"
echo "5. Create pipeline job"

echo ""
echo -e "${BLUE} Quick Links:${NC}"
echo "Jenkins: http://localhost:8080"
echo "Your Website: http://opuba236.s3-website-us-east-1.amazonaws.com"
echo "GitHub Repo: https://github.com/Copubah/my-minimal-website"