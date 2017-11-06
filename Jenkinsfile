#!/usr/bin/env groovy
pipeline {
  agent { dockerfile true }
  stages {
    stage('Code Analysis') {
      steps {
        pmd -d src/classes -f text -R config/pmd.xml
      }
    }
  }
}
