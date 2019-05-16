pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = "${env.AWS_ACCESS_ID}"
        AWS_SECRET_ACCESS_KEY = "${env.AWS_SECRET_ID}"
        AWS_DEFAULT_REGION = "${env.AWS_REGION_ID}"
        AWS_ACCOUNT_ID = "${env.AWS_ACCOUNT_ID}"
    }

    parameters {
        choice(name: 'action', choices: 'plan\napply\ndestroy', description: 'Create/update or destroy the AWS Infra.')
        string(name: 'environment', defaultValue : 'dev', description: "KMS Demo.")
    }

    options {
      disableConcurrentBuilds()
      timeout(time: 1, unit: 'HOURS')
      ansiColor('xterm')
    }

    stages {

        /* stage('Authenticate AWS') {
            steps {
                sh "python3 /usr/bin/gaws.py MY_SELF_GOUTHAM --profile nonprod --account 775537551370 --region us-east-1 --passwd ${JENKINS_USER_PASS}"
            }
        } */

        stage('Setup') {
          steps {
            script {
              currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + "-" + params.environment
              plan = params.environment + '.plan'
            }
          }
        }

        stage('Checkout') {
          steps {
            checkout scm
          }
        }

        stage('TF Plan') {
 
          when {
            expression { params.action == 'plan' }
          }
          steps {
                sh """
                   terraform init
                   terraform plan -input=false -out ${plan} 
                   terraform show $plan
                   """
            }
        }

        stage('TF Apply') {
          when {
            expression { params.action == 'apply' }
          }
          steps {
                sh """
                   terraform init
                   terraform plan -input=false -out ${plan}
                   """
            script {
              input "Create/update Terraform stack for KMS ${params.environment} env in aws?" 

                sh """
                  terraform apply -input=false -auto-approve ${plan}
                """
            }
          }
        }

        /* stage('TF Destroy') {
          when {
            expression { params.action == 'destroy' }
          }
          steps {
                sh """
                   terraform init
                   terraform show
                   """            
            script {
              input "Destroy Terraform stack for KMS ${params.environment} env in aws?" 

                sh """
                  terraform destroy -auto-approve
                """
            }
          }
       } */
    }    
    post {
        always {
            echo 'Clean up workspace'
            deleteDir()
        }
    }
}
