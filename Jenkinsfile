pipeline {

  environment {
    dockerimagename = "shawon10/laravel-hello-1"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Latest Source') {
      steps {
        git branch: 'main', url: 'https://github.com/shawon100/php-laravel-app-jenkins-cicd-kubernetes.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          //dockerImage = docker.build dockerimagename
          sh 'docker build -t shawon10/laravel-hello-1:${BUILD_NUMBER} .'
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
            dockerImage.push("${BUILD_NUMBER}")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
           kubernetesDeploy(enableConfigSubstitution: true, configs: "deploy/deployment.yaml", kubeconfigId: "kubernetes")
           kubernetesDeploy(configs: "deploy/service.yaml", kubeconfigId: "kubernetes")
        }
      }
    }

  }

}
