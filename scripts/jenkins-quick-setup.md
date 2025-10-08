# Jenkins Quick Setup for Your Pipeline

## Jenkins is running at: http://localhost:8080

### Step 1: Install Required Plugins
1. Go to **Manage Jenkins** → **Manage Plugins** → **Available**
2. Search and install these plugins:
 - Pipeline (usually pre-installed)
 - GitHub Integration Plugin
 - AWS Pipeline Plugin 
 - Pipeline: AWS Steps
 - HTTP Request Plugin

### Step 2: Add AWS Credentials
1. **Manage Jenkins** → **Manage Credentials**
2. **System** → **Global credentials** → **Add Credentials**
3. **Kind:** AWS Credentials
4. **ID:** `aws-s3-credentials` (MUST match Jenkinsfile)
5. **Access Key ID:** [Your AWS Access Key]
6. **Secret Access Key:** [Your AWS Secret Key]
7. **Description:** AWS S3 Deployment Credentials
8. **Save**

### Step 3: Create Pipeline Job
1. **New Item** → **Pipeline** 
2. **Name:** `my-website-deployment`
3. **Pipeline Configuration:**
 - **Definition:** Pipeline script from SCM
 - **SCM:** Git
 - **Repository URL:** `https://github.com/Copubah/my-minimal-website.git`
 - **Branch:** `*/main`
 - **Script Path:** `Jenkinsfile`
4. **Save**

### Step 4: Test Manual Build
1. Go to your pipeline job
2. Click **Build Now**
3. Check **Console Output** for logs

### Step 5: Setup GitHub Webhook (Auto-deployment)
1. **GitHub repo** → **Settings** → **Webhooks** → **Add webhook**
2. **Payload URL:** `http://YOUR-JENKINS-IP:8080/github-webhook/`
3. **Content type:** `application/json`
4. **Events:** Just the push event
5. **Save**

6. **Back in Jenkins job** → **Configure**
7. **Build Triggers** → **GitHub hook trigger for GITScm polling**
8. **Save**

## Expected Results:
- Manual build should deploy to S3 successfully
- Website should be live at: http://opuba236.s3-website-us-east-1.amazonaws.com
- Future pushes to GitHub should trigger automatic deployment

## Troubleshooting:
- **Plugin issues:** Restart Jenkins after installing plugins
- **AWS credentials:** Double-check Access Key and Secret Key
- **Webhook:** Ensure Jenkins is accessible from internet for GitHub webhooks