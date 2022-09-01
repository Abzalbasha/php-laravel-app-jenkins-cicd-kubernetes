pipeline {

  environment {
    dockerimagename = "shawon10/laravel-hello-app-1"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        checkout scm
        git branch: 'main', url: 'https://github.com/shawon100/php-laravel-app-jenkins-cicd-kubernetes.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhublogin'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
           sh 'kubectl apply -f deploy/deployment.yaml'
           sh 'kubectl apply -f deploy/service.yaml'
        }
      }
    }

  }

}
