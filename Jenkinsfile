pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = "${env.AWS_ACCESS_KEY_ID}"
		AWS_SECRET_ACCESS_KEY = "${env.AWS_SECRET_ACCESS_KEY}"
		AWS_DEFAULT_REGION	  = "${env.AWS_DEFAULT_REGION}"
    }

    stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = "${version}"
                }
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment}'
                sh "terraform plan -input=false -out tfplan -var 'version=${version}' --var-file=environments/${environment}.tfvars"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Apply') {
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}