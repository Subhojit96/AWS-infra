pipeline {
    agent any
    tools {
        terraform 'terraform'
    }    
    environment {
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages {
            stage('TerraformInit'){
            steps {
                
                    sh "terraform init -input=false"
                    sh "echo \$PWD"
                    sh "whoami"
                
            }
        }

        stage('TerraformFormat'){
            steps {
                
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
                }
        }

        stage('TerraformValidate'){
            steps {
                
                    sh "terraform validate"
                
            }
        }

        stage('TerraformPlan'){
            steps {                
                sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
                    -out terraform.tfplan;echo \$? > status"
                stash name: "terraform-plan", includes: "terraform.tfplan"
                }
        }
        
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan' 
                        
                    }
                }
            }
        }
    }
}