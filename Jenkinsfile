#!/usr/bin/env groovy
pipeline {
  agent { dockerfile true }
  stages {
    stage('Static Analysis') {
      steps {
        sh 'ls -la'
        sh 'wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F5.8.1/pmd-bin-5.8.1.zip'
        sh 'unzip -o pmd-bin-5.8.1.zip'
        sh './pmd-bin-5.8.1/bin/run.sh pmd -d src/classes -f xml -R config/pmd.xml'
        // sh 'curl \'https://developer.salesforce.com/media/salesforce-cli/manifest.json\' > manifest.json'
        // sh 'wget -O sfdx.tar.xz `jq -r \'.builds["linux-amd64"].url\' manifest.json`'
      }
    }
  }
}
