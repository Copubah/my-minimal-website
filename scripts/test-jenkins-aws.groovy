// Jenkins Pipeline Test Script
// Use this in Jenkins "Pipeline Syntax" to test AWS connection

pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        S3_BUCKET = 'opuba236'
        AWS_CREDENTIALS_ID = 'aws-s3-credentials'
    }
    
    stages {
        stage('Test AWS Connection') {
            steps {
                echo 'Testing AWS credentials and S3 access...'
                withAWS(credentials: env.AWS_CREDENTIALS_ID, region: env.AWS_DEFAULT_REGION) {
                    script {
                        // List S3 buckets to test connection
                        sh 'aws s3 ls'
                        
                        // Check if our bucket exists
                        sh "aws s3 ls s3://${env.S3_BUCKET}/"
                        
                        echo "✅ AWS connection successful!"
                        echo "✅ S3 bucket '${env.S3_BUCKET}' is accessible!"
                    }
                }
            }
        }
    }
}