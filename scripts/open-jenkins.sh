#!/bin/bash

echo "🚀 Opening Jenkins..."
echo "Jenkins URL: http://localhost:8080"
echo ""
echo "If you can't login, run: ./scripts/reset-jenkins-password.sh"

# Try to open in browser (if available)
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:8080
elif command -v firefox &> /dev/null; then
    firefox http://localhost:8080 &
else
    echo "Please open http://localhost:8080 in your browser"
fi