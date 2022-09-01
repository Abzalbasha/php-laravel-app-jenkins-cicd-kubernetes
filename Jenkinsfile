pipeline {

  environment {
    dockerimagename = "shawon10/laravel-hello-1"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/shawon100/php-laravel-app-jenkins-cicd-kubernetes'
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
          kubernetesDeploy(configs: "deploy/deployment.yaml", kubeconfigId: "kubernetes")
          kubernetesDeploy(configs: "deploy/service.yaml", kubeconfigId: "kubernetes")
        }
      }
    }

  }

}