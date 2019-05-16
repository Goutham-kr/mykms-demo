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
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment}'
                sh "terraform plan -input=false -out tfplan --var-file=environments/${environment}.tfvars"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
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
