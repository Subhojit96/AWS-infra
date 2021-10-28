pipeline{
  agent{
      label 'master'
  } 
  option{
      timeout(time:1,unit:'HOURS')
      timestamps()
  } 
  tools{
      terraform 'terraform'
  }
  stages{
    input{
        message: "Please select action"
        ok: "Ready to apply the configuration"
        submitter: "*"
        submitterParameter:"whoIsSubmitter"
        parameters{
            booleanParam(name:'deploydestroy',defaultValue:true,description: 
            'Describe the action to perform using the script')
            choice(name:'choice',choices:'Deploy \n Destroy', description:'Enter choice')
        }
        environment{
            access_key= credentials ('AWS_ACCESS_KEY_ID')
            secret_key= credentials ('AWS_SECRET_KEY_ID')
        }
        if(${deploydestroy}=='Deploy'){
            stage('Initialize'){
                steps{
                    sh "echo \$PWD"
                    sh "terraform init"
                }
            }
            stage('Validate'){
                steps{
                    sh "terraform validate"
                }
            }
            stage('Plan'){
                steps{
                    sh "terraform plan --var 'access_key=${access_key}' --var 'secret_key=${secret_key} -out terraform.tfplan"
                }
            }
            stage('Deploy'){
                steps{
                    sh "terraform apply -auto-approve --var 'access_key=${access_key}' --var 'secret_key=${secret_key}"
                }
            }
        }
        else{
            stage{
                steps
                {
                    sh "terraform destroy -auto-approve --var 'access_key=${access_key}' --var 'secret_key=${secret_key}"
                }
            }
        }
    }
  }
}