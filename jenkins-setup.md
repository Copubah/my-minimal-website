# Jenkins Setup Guide

## Prerequisites
- Jenkins server running (local or cloud)
- Jenkins with required plugins installed

## Step 1: Install Required Jenkins Plugins

Go to **Manage Jenkins** → **Manage Plugins** → **Available** and install:

1. **Pipeline** (usually pre-installed)
2. **GitHub Integration Plugin**
3. **AWS Pipeline Plugin**
4. **Pipeline: AWS Steps**
5. **HTTP Request Plugin**

## Step 2: Configure AWS Credentials in Jenkins

1. **Manage Jenkins** → **Manage Credentials**
2. **System** → **Global credentials** → **Add Credentials**
3. **Kind:** AWS Credentials
4. **ID:** `aws-s3-credentials` (must match Jenkinsfile)
5. **Access Key ID:** Your AWS Access Key
6. **Secret Access Key:** Your AWS Secret Key
7. **Description:** AWS S3 Deployment Credentials
8. **Save**

## Step 3: Create Jenkins Pipeline Job

1. **New Item** → **Pipeline** → Name: `my-website-deployment`
2. **Pipeline Configuration:**
 - **Definition:** Pipeline script from SCM
 - **SCM:** Git
 - **Repository URL:** `https://github.com/Copubah/my-minimal-website.git`
 - **Branch:** `*/main`
 - **Script Path:** `Jenkinsfile`

## Step 4: Configure GitHub Webhook (Auto-trigger)

### In GitHub Repository:
1. Go to your repo: **Settings** → **Webhooks** → **Add webhook**
2. **Payload URL:** `http://YOUR-JENKINS-URL/github-webhook/`
3. **Content type:** `application/json`
4. **Events:** Just the push event
5. **Active:** ✓ checked
6. **Add webhook**

### In Jenkins Job:
1. **Configure** your pipeline job
2. **Build Triggers** → Check **GitHub hook trigger for GITScm polling**
3. **Save**

## Step 5: Update Jenkinsfile Variables

Edit the `Jenkinsfile` in your repo and update:
```groovy
environment {
 AWS_DEFAULT_REGION = 'YOUR-AWS-REGION' // e.g., 'us-east-1'
 S3_BUCKET = 'YOUR-ACTUAL-BUCKET-NAME' // e.g., 'my-minimal-website-12345'
 AWS_CREDENTIALS_ID = 'aws-s3-credentials'
}
```

## Troubleshooting

### Common Issues:
1. **AWS Credentials Error:** Verify credentials in Jenkins
2. **S3 Access Denied:** Check bucket policy and IAM permissions
3. **Webhook Not Triggering:** Verify Jenkins URL is accessible from GitHub
4. **Plugin Missing:** Install AWS Pipeline Plugin

### Test Manual Deployment:
1. Go to Jenkins job → **Build Now**
2. Check **Console Output** for detailed logs
3. Verify files appear in S3 bucket