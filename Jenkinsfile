pipeline {
  environment {
    registry = "pedromasa/cicd"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'ssh://git@github.com:pmasa/CICD.git'
      }
    }
    stage('Building Docker image ') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        
        }
      }
    }
    stage('Push Image to Docker Hub ') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            dockerImage.push('latest')
          }
        }
      }
    }

stage ('Deploy') {
    steps{
        sshagent(credentials : ['dockerhub']) {
            sh 'docker pull pedromasa/cicd:latest'
            sh 'docker stop cicd'
            sh 'docker rm cicd'
            sh 'docker rmi pedromasa/cicd:current || true'
            sh 'docker tag pedromasa/cicd:latest pedromasa/cicd:current'
            sh 'docker run -d --name cicd -p 8082:80 pedromasa/cicd:latest'
        }
    }
}
    }
      
    }   
  }

