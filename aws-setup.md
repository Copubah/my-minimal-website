# AWS S3 Setup for Static Website Hosting

## Step 1: Create S3 Bucket

1. **Login to AWS Console** → Navigate to S3
2. **Create Bucket:**
 - Bucket name: `my-minimal-website-[unique-suffix]` (e.g., `my-minimal-website-12345`)
 - Region: Choose your preferred region (e.g., `us-east-1`)
 - **Uncheck "Block all public access"**
 - Acknowledge the warning about public access

## Step 2: Enable Static Website Hosting

1. **Select your bucket** → Properties tab
2. **Static website hosting** → Edit
3. **Enable** static website hosting
4. **Index document:** `index.html`
5. **Error document:** `index.html` (optional)
6. **Save changes**

## Step 3: Configure Bucket Policy

Go to **Permissions** tab → **Bucket policy** → Add this policy:

```json
{
 "Version": "2012-10-17",
 "Statement": [
 {
 "Sid": "PublicReadGetObject",
 "Effect": "Allow",
 "Principal": "*",
 "Action": "s3:GetObject",
 "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
 }
 ]
}
```

**Replace `YOUR-BUCKET-NAME` with your actual bucket name**

## Step 4: Create IAM User for Jenkins

1. **IAM Console** → Users → Create user
2. **Username:** `jenkins-s3-deployer`
3. **Attach policies directly:**
 - `AmazonS3FullAccess` (or create custom policy for specific bucket)
4. **Create user**
5. **Security credentials** → Create access key
6. **Use case:** Application running outside AWS
7. **Save Access Key ID and Secret Access Key** (you'll need these for Jenkins)

## Your S3 Website URL will be:
`http://YOUR-BUCKET-NAME.s3-website-REGION.amazonaws.com`