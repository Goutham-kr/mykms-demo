pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID       = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY   = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION      = credentials('AWS_DEFAULT_REGION')
        TF_IN_AUTOMATION        = '1'
    }

    parameters {
        choice(name: 'action', choices: 'plan\napply\ndestroy', description: 'Create/update or destroy the AWS Infra.')
        string(name: 'devstage', defaultValue : 'dev', description: "KMS Demo.")
    }

    options {
      disableConcurrentBuilds()
      timeout(time: 1, unit: 'HOURS')
      ansiColor('xterm')
    }

    stages {
        stage('Setup') {
          steps {
            script {
              currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + "-" + params.devstage
              plan = params.devrstage + '.plan'
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
                   terraform workspace new dev
                   terraform workspace select dev
                   terraform init -input=false
                   terraform plan -input=false -out ${plan} --var-file='/var/lib/jenkins/secret3.tfvars'
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
                   terraform init -input=false
                   terraform plan -input=false -out ${plan} --var-file='/var/lib/jenkins/secret3.tfvars'
                   """
            script {
              input "Create/update Terraform stack for KMS ${params.devstage} env in aws?" 

                sh """
                  terraform apply -input=false --auto-approve ${plan}
                """
            }
          }
        }

        stage('TF Destroy') {
          when {
            expression { params.action == 'destroy' }
          }
          steps {
                sh """
                   terraform init -input=false
                   terraform show 
                   """            
            script {
              input "Destroy Terraform stack for KMS ${params.devstage} env in aws?" 

                sh """
                  terraform destroy --auto-approve --var-file='/var/lib/jenkins/secret3.tfvars'
                """
            }
          }
       }
    }    
    
    post {
        always {
            echo 'Clean up workspace'
            deleteDir()
        }
    }
}
