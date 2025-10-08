#!/bin/bash

# Check if required Jenkins plugins are installed

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🔍 Checking Required Jenkins Plugins...${NC}"
echo "================================================"

PLUGINS_DIR="/var/lib/jenkins/plugins"

# Required plugins
declare -A REQUIRED_PLUGINS=(
    ["pipeline-stage-view"]="Pipeline Stage View"
    ["workflow-aggregator"]="Pipeline"
    ["github"]="GitHub Integration"
    ["aws-java-sdk"]="AWS Java SDK"
    ["pipeline-aws"]="Pipeline: AWS Steps"
    ["http_request"]="HTTP Request"
)

echo -e "${YELLOW}📋 Plugin Status:${NC}"

MISSING_PLUGINS=()

for plugin in "${!REQUIRED_PLUGINS[@]}"; do
    if sudo ls "$PLUGINS_DIR" 2>/dev/null | grep -q "^${plugin}"; then
        echo -e "${GREEN}✅ ${REQUIRED_PLUGINS[$plugin]}${NC}"
    else
        echo -e "${RED}❌ ${REQUIRED_PLUGINS[$plugin]} (${plugin})${NC}"
        MISSING_PLUGINS+=("$plugin")
    fi
done

echo ""
if [ ${#MISSING_PLUGINS[@]} -eq 0 ]; then
    echo -e "${GREEN}🎉 All required plugins are installed!${NC}"
else
    echo -e "${YELLOW}⚠️  Missing plugins that need to be installed:${NC}"
    for plugin in "${MISSING_PLUGINS[@]}"; do
        echo -e "${YELLOW}   - ${REQUIRED_PLUGINS[$plugin]}${NC}"
    done
    echo ""
    echo -e "${YELLOW}📝 To install missing plugins:${NC}"
    echo "1. Go to Jenkins: http://localhost:8080"
    echo "2. Manage Jenkins → Manage Plugins → Available"
    echo "3. Search for each missing plugin and install"
    echo "4. Restart Jenkins when prompted"
fi