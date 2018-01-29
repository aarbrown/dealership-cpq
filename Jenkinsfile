#!/usr/bin/env groovy
def getRepoURL() {
  sh "git config --get remote.origin.url > .git/remote-url"
  return readFile(".git/remote-url").trim()
}

def getCommitSha() {
  sh "git rev-parse HEAD > .git/current-commit"
  return readFile(".git/current-commit").trim()
}

def updateGithubCommitStatus(build) {
  // workaround https://issues.jenkins-ci.org/browse/JENKINS-38674
  repoUrl = getRepoURL()
  commitSha = getCommitSha()

  step([
    $class: 'GitHubCommitStatusSetter',
    reposSource: [$class: "ManuallyEnteredRepositorySource", url: repoUrl],
    commitShaSource: [$class: "ManuallyEnteredShaSource", sha: commitSha],
    errorHandlers: [[$class: 'ShallowAnyErrorHandler']],
    statusResultSource: [
      $class: 'ConditionalStatusResultSource',
      results: [
        [$class: 'BetterThanOrEqualBuildResult', result: 'SUCCESS', state: 'SUCCESS', message: build.description],
        [$class: 'BetterThanOrEqualBuildResult', result: 'FAILURE', state: 'FAILURE', message: build.description],
        [$class: 'AnyBuildResult', state: 'FAILURE', message: 'Loophole']
      ]
    ]
  ])
}
node {
      stage('Checkout') {
          checkout scm
      }

      stage('Static Analysis') {
          withAnt(installation: 'ant') {
              withCredentials([file(credentialsId: 'dealership-build-properties	', variable: 'FILE')]) {
                  sh 'ant -f build/build.xml analyze -propertyfile ' + FILE
              }
          }
      }

      stage('Unit Tests') {
          withAnt(installation: 'ant') {
              withCredentials([file(credentialsId: 'dealership-build-properties	', variable: 'FILE')]) {
                  sh 'ant -f build/build.xml test -propertyfile ' + FILE
              }
          }
      }

      stage('Test Deployment') {
          withAnt(installation: 'ant') {
              withCredentials([file(credentialsId: 'dealership-build-properties	', variable: 'FILE')]) {
                  sh 'ant -f build/build.xml check-deploy -propertyfile ' + FILE
              }
          }
      }

      stage('Reporting') {
          junit 'build/ApexUnitReport.xml'

          step([$class: 'PmdPublisher', pattern: 'build/pmd-results.xml', unstableTotalAll:'0'])

          // publish html
          // snippet generator doesn't include "target:"
          // https://issues.jenkins-ci.org/browse/JENKINS-29711.
          publishHTML (target: [
              allowMissing: false,
              alwaysLinkToLastBuild: false,
              keepAll: true,
              reportDir: 'build/Report',
              reportFiles: 'ApexUnitReport.html',
              reportName: "ApexUnit Report"
          ])
      }
}
