# Testing Pipeline and Setting Up Auto-Deployment

## Step 3: Test the Pipeline

### Manual Build Test:
1. Go to your pipeline job: `my-website-deployment`
2. Click **Build Now**
3. Watch the build progress (stages will appear)
4. Click on build number (e.g., #1) when it appears
5. Click **Console Output** to see detailed logs

### Expected Success Output:
```
Started by user [username]
Checking out code from GitHub...
Validating website files...
All required files found ✓
Deploying to AWS S3...
Deployment completed successfully! ✓
Verifying deployment...
Website should be available at: http://opuba236.s3-website-us-east-1.amazonaws.com
 Pipeline completed successfully!
```

### If Build Fails:
- Check Console Output for error messages
- Common issues:
 - AWS credentials not configured
 - Missing plugins
 - S3 bucket permissions
 - GitHub repository access

---

## Step 4: Set Up Auto-Deployment (GitHub Webhook)

### Option A: Local Testing (Skip webhook for now)
- Test by running manual builds
- Make code changes and run "Build Now"

### Option B: Full Auto-Deployment Setup
**Only if Jenkins is accessible from internet**

#### In GitHub Repository:
1. Go to: https://github.com/Copubah/my-minimal-website
2. **Settings** → **Webhooks** → **Add webhook**
3. **Payload URL:** `http://YOUR-PUBLIC-IP:8080/github-webhook/`
 - Replace YOUR-PUBLIC-IP with your actual public IP
 - For local testing: skip this step
4. **Content type:** `application/json`
5. **Which events:** Just the push event
6. **Active:** 
7. **Add webhook**

#### Test Auto-Deployment:
1. Make a small change to your website (e.g., edit index.html)
2. Commit and push to GitHub:
 ```bash
 git add .
 git commit -m "Test auto-deployment"
 git push origin main
 ```
3. Check Jenkins - build should start automatically
4. Verify changes appear on live website

---

## Quick Test Script

Run this after successful manual build:
```bash
# Test if website is accessible
curl -I http://opuba236.s3-website-us-east-1.amazonaws.com

# Should return: HTTP/1.1 200 OK
```

## Troubleshooting

### Build Fails with AWS Error:
- Check AWS credentials in Jenkins
- Verify IAM user has S3 permissions
- Check S3 bucket exists and is accessible

### Build Fails with Git Error:
- Verify GitHub repository URL
- Check if repository is public
- Ensure Jenkinsfile exists in repo root

### Website Not Updating:
- Check S3 bucket contents
- Verify files were uploaded
- Clear browser cache
- Check S3 static website hosting settings