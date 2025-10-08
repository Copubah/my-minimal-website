# Jenkins Step-by-Step Configuration Guide

## Access Jenkins: http://localhost:8080

---

## Step B: Install Required Plugins

### 1. Navigate to Plugin Manager
- Click **Manage Jenkins** (left sidebar)
- Click **Manage Plugins**
- Click **Available** tab

### 2. Search and Install These Plugins:
**Search for each plugin and check the box:**

 **Pipeline** (likely already installed)
 **GitHub Integration Plugin** (already installed ✓)
 **AWS Pipeline Plugin** - SEARCH: "AWS Pipeline"
 **Pipeline: AWS Steps** - SEARCH: "Pipeline AWS Steps" 
 **HTTP Request Plugin** - SEARCH: "HTTP Request"

### 3. Install Process:
- Check boxes for the plugins you need
- Click **Install without restart** (bottom of page)
- Wait for installation to complete
- **Restart Jenkins** if prompted

---

## Step C: Add AWS Credentials

### 1. Navigate to Credentials
- Click **Manage Jenkins** (left sidebar)
- Click **Manage Credentials**
- Click **System** → **Global credentials (unrestricted)**
- Click **Add Credentials**

### 2. Configure AWS Credentials:
- **Kind:** Select "AWS Credentials"
- **ID:** `aws-s3-credentials` (MUST be exactly this)
- **Description:** `AWS S3 Deployment Credentials`
- **Access Key ID:** [Your AWS Access Key from IAM user]
- **Secret Access Key:** [Your AWS Secret Key from IAM user]
- Click **OK**

### 3. Verify Credentials Added:
- You should see "AWS S3 Deployment Credentials" in the list
- ID should show as "aws-s3-credentials"

---

## Step D: Create Pipeline Job

### 1. Create New Job
- Click **New Item** (left sidebar)
- **Item name:** `my-website-deployment`
- Select **Pipeline**
- Click **OK**

### 2. Configure Pipeline
**In the configuration page:**

#### General Section:
- **Description:** `Automated deployment of minimal website to AWS S3`
- Check **GitHub project**
- **Project url:** `https://github.com/Copubah/my-minimal-website/`

#### Build Triggers:
- Check **GitHub hook trigger for GITScm polling**

#### Pipeline Section:
- **Definition:** Select "Pipeline script from SCM"
- **SCM:** Select "Git"
- **Repository URL:** `https://github.com/Copubah/my-minimal-website.git`
- **Credentials:** Leave as "- none -" (public repo)
- **Branch Specifier:** `*/main`
- **Script Path:** `Jenkinsfile`

### 3. Save Configuration
- Click **Save** (bottom of page)

---

## Test Your Setup

### 1. Manual Build Test
- Go to your pipeline job: `my-website-deployment`
- Click **Build Now**
- Click on the build number (e.g., #1) when it appears
- Click **Console Output** to see logs

### 2. Expected Results:
 Checkout stage completes
 File validation passes 
 S3 deployment succeeds
 Website verification passes
 Final message: "Your website is live at: http://opuba236.s3-website-us-east-1.amazonaws.com"

---

## Setup GitHub Webhook (Auto-deployment)

### 1. In GitHub Repository:
- Go to: https://github.com/Copubah/my-minimal-website
- Click **Settings** → **Webhooks** → **Add webhook**
- **Payload URL:** `http://YOUR-IP:8080/github-webhook/`
 - Replace YOUR-IP with your actual IP address
 - For local testing: `http://localhost:8080/github-webhook/`
- **Content type:** `application/json`
- **Which events:** Select "Just the push event"
- **Active**
- Click **Add webhook**

### 2. Test Auto-deployment:
- Make a small change to your website
- Commit and push to GitHub
- Jenkins should automatically trigger a build

---

## Troubleshooting

### Plugin Installation Issues:
- Restart Jenkins: `sudo systemctl restart jenkins`
- Check plugin compatibility
- Try installing one plugin at a time

### AWS Credentials Issues:
- Verify Access Key and Secret Key are correct
- Check IAM user has S3 permissions
- Ensure credential ID is exactly: `aws-s3-credentials`

### Build Failures:
- Check Console Output for specific errors
- Verify GitHub repository URL is correct
- Ensure Jenkinsfile exists in repository root