#!/usr/bin/env groovy
pipeline {
  agent { dockerfile true }
  stages {
    stage('Code Analysis') {
      steps {
        sh 'pmd -d src/classes -f text -R config/pmd.xml'
      }
    }
  }
}
