pipeline{
  agent{
      label 'master'
    } 
  options{
      timeout(time:1,unit:'HOURS')
      timestamps()
    } 
  tools{
      terraform 'terraform'
    }
   environment{
       access_key= credentials ('AWS_ACCESS_KEY_ID')
       secret_key= credentials ('AWS_SECRET_KEY_ID')
    }
  stages{
    stage('Build'){
            steps{
                sh "echo \$PWD"
                sh "terraform init"
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
}
}