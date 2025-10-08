# Pipeline Job Configuration

## Exact Settings for Jenkins Pipeline Job

### Job Creation:
- **Item name:** `my-website-deployment`
- **Type:** Pipeline
- **Description:** `Automated deployment of minimal website to AWS S3`

### General Configuration:
- **GitHub project**
- **Project URL:** `https://github.com/Copubah/my-minimal-website/`

### Build Triggers:
- **GitHub hook trigger for GITScm polling**

### Pipeline Configuration:
- **Definition:** Pipeline script from SCM
- **SCM:** Git
- **Repository URL:** `https://github.com/Copubah/my-minimal-website.git`
- **Credentials:** - none - (public repository)
- **Branches to build:** `*/main`
- **Script Path:** `Jenkinsfile`

### Advanced Options (if available):
- **Lightweight checkout:** (recommended)

## Expected Pipeline Stages:
1. **Checkout** - Downloads code from GitHub
2. **Validate Files** - Checks for required files
3. **Deploy to S3** - Uploads files to S3 bucket
4. **Verify Deployment** - Tests website accessibility

## Success Indicators:
- All stages show green checkmarks
- Console output shows: "Pipeline completed successfully!"
- Website accessible at: http://opuba236.s3-website-us-east-1.amazonaws.com