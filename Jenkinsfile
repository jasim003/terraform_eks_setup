pipeline {
    agent any
    environment {
        PATH="/usr/local/bin:$PATH"
    }
    parameters {
            choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'What action should Terraform take?')
        }


    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'c4b2addd-5cd4-4892-bbb4-7b34a202ebd6', url: 'https://github.com/jasim003/terraform_eks_setup.git'
            }
        }
        stage('Terraform Init') {
            steps {
               sh '''
               #!/bin/bash
               terraform init
               '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                #!/bin/bash
                terraform plan '-out=tfplan'
                '''
            }
        }
        stage('Terraform Deploy') {
            steps{
                script {
                switch(params.ACTION) {
                case "apply" : sh ''' terraform apply '-auto-approve' '''; break
                case "destroy" :  sh ''' terraform destroy '-auto-approve' '''; break
                }

            }
            }
        }
    }

post {
    always {
        cleanWs( cleanWhenNotBuilt: false, disableDeferredWipeout: true, notFailBuild: true)
    }
}
}