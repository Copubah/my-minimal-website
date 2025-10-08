#!/bin/bash

# Script to update Jenkinsfile with your S3 bucket details
# Usage: ./update-jenkinsfile.sh BUCKET_NAME REGION

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${RED} Usage: ./update-jenkinsfile.sh BUCKET_NAME REGION${NC}"
    echo -e "${YELLOW}Example: ./update-jenkinsfile.sh my-minimal-website-12345 us-east-1${NC}"
    exit 1
fi

BUCKET_NAME=$1
REGION=$2

echo -e "${YELLOW} Updating Jenkinsfile with your S3 details...${NC}"

# Update Jenkinsfile
sed -i "s/AWS_DEFAULT_REGION = 'us-east-1'/AWS_DEFAULT_REGION = '$REGION'/" Jenkinsfile
sed -i "s/S3_BUCKET = 'my-minimal-website-12345'/S3_BUCKET = '$BUCKET_NAME'/" Jenkinsfile

echo -e "${GREEN}Jenkinsfile updated successfully!${NC}"
echo -e "${YELLOW} Updated values:${NC}"
echo -e "   Bucket: $BUCKET_NAME"
echo -e "   Region: $REGION"

echo -e "${YELLOW} Ready to commit and push changes!${NC}"