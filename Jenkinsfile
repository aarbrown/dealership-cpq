#!/usr/bin/env groovy
pipeline {
  agent { dockerfile true }
  stages {
    stage('Static Analysis') {
      steps {
        sh 'cd build'
        sh 'ant analyze'
      }
    }
  }
}
