# Automated Website Deployment with Jenkins and AWS S3

A complete CI/CD pipeline that automatically deploys a static website to AWS S3 using Jenkins whenever changes are pushed to GitHub.

## Project Overview

This project demonstrates a full DevOps workflow with:
- Static website (HTML, CSS, JavaScript)
- GitHub repository for version control
- Jenkins CI/CD pipeline for automation
- AWS S3 for static website hosting
- Automatic deployment on code changes

## Live Website

**Production URL:** http://opuba236.s3-website-us-east-1.amazonaws.com

## Architecture

```
GitHub Repository → Jenkins Pipeline → AWS S3 Bucket → Live Website
```

1. **Developer pushes code** to GitHub repository
2. **GitHub webhook triggers** Jenkins pipeline automatically
3. **Jenkins pipeline** validates, builds, and deploys to S3
4. **Website is live** on S3 static hosting within minutes

## Repository Structure

```
├── index.html              # Main website file
├── main.css               # Website styling
├── script.js              # Interactive functionality
├── Jenkinsfile            # Jenkins pipeline configuration
├── README.md              # This documentation
└── scripts/               # Utility scripts
    ├── complete-jenkins-setup.sh    # Automated Jenkins configuration
    ├── test-deployment.sh           # Manual deployment testing
    ├── verify-jenkins-setup.sh     # Setup verification
    ├── update-jenkinsfile.sh       # Update pipeline configuration
    ├── check-required-plugins.sh   # Plugin verification
    ├── open-jenkins.sh             # Jenkins access helper
    ├── reset-jenkins-password.sh   # Password reset utility
    └── test-jenkins-aws.groovy     # AWS connection test
```

## Prerequisites

- **Jenkins Server** (local or remote)
- **AWS Account** with S3 access
- **GitHub Account** and repository
- **Git** installed locally
- **AWS CLI** configured with credentials

## Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/Copubah/my-minimal-website.git
cd my-minimal-website
```

### 2. AWS S3 Setup
The S3 bucket `opuba236` is already configured for this project with:
- Static website hosting enabled
- Public read access configured
- Bucket policy for web access

### 3. Jenkins Setup
Run the automated setup script:
```bash
chmod +x scripts/complete-jenkins-setup.sh
./scripts/complete-jenkins-setup.sh
```

### 4. Manual Jenkins Configuration
1. **Access Jenkins:** http://localhost:8080
2. **Install Required Plugins:**
   - AWS Pipeline Plugin
   - Pipeline: AWS Steps
   - HTTP Request Plugin
3. **Add AWS Credentials:**
   - Go to Manage Jenkins → Manage Credentials
   - Add AWS Credentials with ID: `aws-s3-credentials`
   - Use your AWS Access Key and Secret Key

### 5. Test Deployment
```bash
# Manual test deployment
./scripts/test-deployment.sh opuba236 us-east-1

# Verify Jenkins setup
./scripts/verify-jenkins-setup.sh
```

## Jenkins Pipeline Details

The `Jenkinsfile` defines a 4-stage pipeline:

### Stage 1: Checkout
- Downloads source code from GitHub
- Validates repository access

### Stage 2: Validate Files
- Checks for required files (index.html, main.css, script.js)
- Ensures all dependencies are present

### Stage 3: Deploy to S3
- Uploads website files to S3 bucket
- Excludes unnecessary files (.git, documentation, etc.)
- Uses AWS credentials for secure access

### Stage 4: Verify Deployment
- Tests website accessibility
- Performs HTTP health check
- Confirms successful deployment

## Pipeline Configuration

Key environment variables in `Jenkinsfile`:
```groovy
environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    S3_BUCKET = 'opuba236'
    AWS_CREDENTIALS_ID = 'aws-s3-credentials'
}
```

## Automatic Deployment

### GitHub Webhook Setup
For automatic deployment on code changes:

1. **Repository Settings** → **Webhooks** → **Add webhook**
2. **Payload URL:** `http://your-jenkins-server:8080/github-webhook/`
3. **Content type:** `application/json`
4. **Events:** Just the push event
5. **Active:** Checked

### Testing Auto-Deployment
```bash
# Make a change to the website
echo "<p>Updated content</p>" >> index.html

# Commit and push
git add .
git commit -m "Test auto-deployment"
git push origin main

# Jenkins will automatically trigger build and deploy
```

## Monitoring and Troubleshooting

### Check Pipeline Status
- **Jenkins Dashboard:** http://localhost:8080
- **Build History:** View all pipeline executions
- **Console Output:** Detailed logs for each build

### Common Issues and Solutions

**Build Fails with AWS Error:**
- Verify AWS credentials in Jenkins
- Check IAM user permissions for S3
- Ensure S3 bucket exists and is accessible

**Build Fails with Git Error:**
- Verify GitHub repository URL
- Check repository is public or credentials are configured
- Ensure Jenkinsfile exists in repository root

**Website Not Updating:**
- Check S3 bucket contents after deployment
- Verify static website hosting is enabled
- Clear browser cache
- Check S3 bucket policy allows public read

### Verification Commands
```bash
# Test S3 website accessibility
curl -I http://opuba236.s3-website-us-east-1.amazonaws.com

# Check S3 bucket contents
aws s3 ls s3://opuba236/

# Verify Jenkins service
systemctl status jenkins

# Check Jenkins logs
sudo journalctl -u jenkins -f
```

## Security Considerations

- **AWS Credentials:** Stored securely in Jenkins credential store
- **S3 Bucket Policy:** Allows only public read access to website files
- **Jenkins Access:** Configure authentication and authorization
- **GitHub Webhook:** Use HTTPS and validate payloads in production

## Development Workflow

### Making Changes
1. **Edit files** locally (index.html, main.css, script.js)
2. **Test locally** by opening index.html in browser
3. **Commit changes** to Git
4. **Push to GitHub** - triggers automatic deployment
5. **Verify deployment** on live website

### Adding New Features
1. **Create feature branch**
2. **Develop and test** new functionality
3. **Create pull request** for code review
4. **Merge to main** - triggers production deployment

## Utility Scripts

### `scripts/complete-jenkins-setup.sh`
Automated Jenkins configuration including job creation and plugin verification.

### `scripts/test-deployment.sh`
Manual deployment testing without Jenkins pipeline.

### `scripts/verify-jenkins-setup.sh`
Comprehensive verification of Jenkins installation and configuration.

### `scripts/update-jenkinsfile.sh`
Update pipeline configuration with new S3 bucket or region.

## Performance and Optimization

- **S3 Static Hosting:** Fast global content delivery
- **Lightweight Pipeline:** Minimal build time (< 2 minutes)
- **Incremental Sync:** Only changed files are uploaded
- **Automated Validation:** Prevents broken deployments

## Cost Optimization

- **S3 Storage:** Pay only for stored data
- **Data Transfer:** Free tier covers typical usage
- **Jenkins:** Self-hosted reduces CI/CD costs
- **Automation:** Reduces manual deployment time

## Contributing

1. **Fork the repository**
2. **Create feature branch** (`git checkout -b feature/new-feature`)
3. **Commit changes** (`git commit -am 'Add new feature'`)
4. **Push to branch** (`git push origin feature/new-feature`)
5. **Create Pull Request**

## License

This project is open source and available under the MIT License.

## Support

For issues and questions:
- **GitHub Issues:** Create an issue in this repository
- **Documentation:** Refer to this README and script comments
- **Jenkins Logs:** Check console output for detailed error information

## Project Status

- **Status:** Production Ready
- **Last Updated:** October 2025
- **Jenkins Version:** Compatible with Jenkins 2.x
- **AWS Services:** S3 Static Website Hosting
- **Deployment:** Fully Automated