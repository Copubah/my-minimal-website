pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // Change to your preferred region
        S3_BUCKET = 'my-minimal-website-12345'  // Replace with your bucket name
        AWS_CREDENTIALS_ID = 'aws-s3-credentials'  // Jenkins credential ID
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Validate Files') {
            steps {
                echo 'Validating website files...'
                script {
                    // Check if required files exist
                    if (!fileExists('index.html')) {
                        error('index.html not found!')
                    }
                    if (!fileExists('main.css')) {
                        error('main.css not found!')
                    }
                    if (!fileExists('script.js')) {
                        error('script.js not found!')
                    }
                    echo 'All required files found ✓'
                }
            }
        }
        
        stage('Deploy to S3') {
            steps {
                echo 'Deploying to AWS S3...'
                withAWS(credentials: env.AWS_CREDENTIALS_ID, region: env.AWS_DEFAULT_REGION) {
                    // Sync all files to S3 bucket
                    s3Upload(
                        bucket: env.S3_BUCKET,
                        includePathPattern: '**/*',
                        excludePathPattern: '.git/**,Jenkinsfile,aws-setup.md,README.md',
                        workingDir: '.',
                        acl: 'PublicRead'
                    )
                }
                echo 'Deployment completed successfully! ✓'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo 'Verifying deployment...'
                script {
                    def websiteUrl = "http://${env.S3_BUCKET}.s3-website-${env.AWS_DEFAULT_REGION}.amazonaws.com"
                    echo "Website should be available at: ${websiteUrl}"
                    
                    // Optional: Add HTTP check
                    try {
                        def response = httpRequest(
                            url: websiteUrl,
                            timeout: 30,
                            validResponseCodes: '200'
                        )
                        echo "Website is live and responding! Status: ${response.status}"
                    } catch (Exception e) {
                        echo "Note: Website verification failed, but deployment completed. Check manually: ${websiteUrl}"
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
            echo "Your website is live at: http://${env.S3_BUCKET}.s3-website-${env.AWS_DEFAULT_REGION}.amazonaws.com"
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above for details.'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}