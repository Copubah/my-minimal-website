#!/bin/bash

echo "🔑 Resetting Jenkins admin password..."

# Stop Jenkins
echo "Stopping Jenkins..."
sudo systemctl stop jenkins

# Disable security temporarily
echo "Disabling security temporarily..."
sudo sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/' /var/lib/jenkins/config.xml

# Start Jenkins
echo "Starting Jenkins..."
sudo systemctl start jenkins

echo "✅ Jenkins started without authentication"
echo "🌐 Go to: http://localhost:8080"
echo ""
echo "📝 To create a new admin user:"
echo "1. Go to Manage Jenkins → Manage Users"
echo "2. Create User → Add your username/password"
echo "3. Go to Configure Global Security"
echo "4. Enable 'Jenkins' own user database'"
echo "5. Save configuration"
echo ""
echo "⚠️  Remember to re-enable security after creating your user!"