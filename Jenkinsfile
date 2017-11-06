#!/usr/bin/env groovy
pipeline {
  agent { dockerfile true }
  stages {
    stage('Code Analysis') {
      steps {
        sh 'wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip'
        sh 'unzip pmd-bin-5.8.1.zip'
        sh 'cp pmd-bin-5.8.1/bin/run.sh run.sh'
        sh 'ls -la .'
        sh './run.sh pmd -d src/classes -f text -R config/pmd.xml'
      }
    }
  }
}
