# AWS Credentials Configuration

## 🔑 You'll need these details for Jenkins:

### IAM User Information:
- **Username:** `jenkins-s3-deployer` (created earlier)
- **Access Key ID:** `[Your AWS Access Key]`
- **Secret Access Key:** `[Your AWS Secret Key]`

### Jenkins Credential Configuration:
- **Kind:** AWS Credentials
- **ID:** `aws-s3-credentials` (MUST be exactly this)
- **Description:** `AWS S3 Deployment Credentials`
- **Access Key ID:** [Paste your Access Key here]
- **Secret Access Key:** [Paste your Secret Key here]

## 🚨 Important Notes:
- The credential ID MUST be exactly: `aws-s3-credentials`
- This matches what's configured in your Jenkinsfile
- Keep your AWS keys secure and never commit them to code

## 🔍 To find your AWS keys:
1. Go to AWS Console → IAM → Users
2. Click on `jenkins-s3-deployer`
3. Security credentials tab
4. If no access key exists, create one
5. Copy the Access Key ID and Secret Access Key