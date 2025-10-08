# Deployment Verification Checklist

## Pre-Deployment Checklist

- [ ] AWS S3 bucket created and configured for static hosting
- [ ] Bucket policy allows public read access
- [ ] IAM user created with S3 access
- [ ] Jenkins has AWS credentials configured
- [ ] Required Jenkins plugins installed
- [ ] GitHub webhook configured
- [ ] Jenkinsfile updated with correct bucket name and region

## Post-Deployment Verification

### 1. Check Jenkins Build
- [ ] Jenkins job triggered automatically on push
- [ ] Build completed successfully (green status)
- [ ] Console output shows successful S3 upload
- [ ] No error messages in build logs

### 2. Verify S3 Bucket
- [ ] Files uploaded to S3 bucket:
  - [ ] `index.html`
  - [ ] `main.css`
  - [ ] `script.js`
- [ ] Files have public read permissions
- [ ] Static website hosting is enabled

### 3. Test Website Functionality
- [ ] Website loads at S3 URL: `http://YOUR-BUCKET.s3-website-REGION.amazonaws.com`
- [ ] CSS styling applied correctly
- [ ] JavaScript button works (shows alert)
- [ ] All navigation links function
- [ ] Page displays correctly on mobile/desktop

### 4. Test Automatic Deployment
- [ ] Make a small change to website (e.g., update text in index.html)
- [ ] Commit and push to GitHub
- [ ] Jenkins job triggers automatically
- [ ] Changes appear on live website within 2-3 minutes

## Quick Test Commands

### Test S3 Website URL:
```bash
curl -I http://YOUR-BUCKET-NAME.s3-website-REGION.amazonaws.com
# Should return: HTTP/1.1 200 OK
```

### Check S3 Files via AWS CLI:
```bash
aws s3 ls s3://YOUR-BUCKET-NAME/
# Should show: index.html, main.css, script.js
```

## Success Indicators

✅ **Deployment Successful When:**
- Jenkins build shows green/success status
- Website loads without errors
- CSS and JavaScript work correctly
- Automatic deployments trigger on code changes
- S3 bucket contains all website files

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| 403 Forbidden | Check bucket policy and public access settings |
| Jenkins build fails | Verify AWS credentials and permissions |
| Webhook not triggering | Check GitHub webhook URL and Jenkins accessibility |
| CSS/JS not loading | Ensure files uploaded with correct MIME types |
| Website not updating | Clear browser cache, check S3 file timestamps |