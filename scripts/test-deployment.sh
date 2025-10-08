#!/bin/bash

# Test deployment script
# Run this after setting up your S3 bucket to test manual deployment

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW} Testing S3 Deployment...${NC}"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED} AWS CLI not found. Please install it first.${NC}"
    exit 1
fi

# Check if bucket name is provided
if [ -z "$1" ]; then
    echo -e "${RED} Usage: ./test-deployment.sh YOUR-BUCKET-NAME${NC}"
    echo -e "${YELLOW}Example: ./test-deployment.sh my-minimal-website-12345${NC}"
    exit 1
fi

BUCKET_NAME=$1
REGION=${2:-us-east-1}

echo -e "${YELLOW}📦 Bucket: $BUCKET_NAME${NC}"
echo -e "${YELLOW}🌍 Region: $REGION${NC}"

# Test AWS credentials
echo -e "${YELLOW}🔑 Testing AWS credentials...${NC}"
if aws sts get-caller-identity > /dev/null 2>&1; then
    echo -e "${GREEN} AWS credentials are valid${NC}"
else
    echo -e "${RED} AWS credentials not configured or invalid${NC}"
    echo -e "${YELLOW}Run: aws configure${NC}"
    exit 1
fi

# Upload files to S3
echo -e "${YELLOW}📤 Uploading files to S3...${NC}"
aws s3 sync . s3://$BUCKET_NAME/ \
    --exclude ".git/*" \
    --exclude "scripts/*" \
    --exclude "*.md" \
    --exclude "Jenkinsfile" \
    --acl public-read

if [ $? -eq 0 ]; then
    echo -e "${GREEN} Files uploaded successfully!${NC}"
    echo -e "${GREEN}🌐 Your website should be available at:${NC}"
    echo -e "${GREEN}   http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com${NC}"
else
    echo -e "${RED} Upload failed. Check your bucket name and permissions.${NC}"
    exit 1
fi

# Test website accessibility
echo -e "${YELLOW} Testing website accessibility...${NC}"
WEBSITE_URL="http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"

if curl -s --head "$WEBSITE_URL" | head -n 1 | grep -q "200 OK"; then
    echo -e "${GREEN} Website is accessible!${NC}"
    echo -e "${GREEN} Deployment test completed successfully!${NC}"
else
    echo -e "${YELLOW}  Website might not be ready yet. Try accessing manually:${NC}"
    echo -e "${YELLOW}   $WEBSITE_URL${NC}"
fi