def label = "springmysql-${UUID.randomUUID().toString()}"

// JDK 8 사용하도록 설정하기
// def javaHome="tool name: 'jdk8', type: 'hudson.model.JDK'"
// env.JAVA_HOME="${javaHome}"
// env.PATH="${env.PATH}:${env.JAVA_HOME}/bin"

def mvnHome

podTemplate(
	label: label, 
	containers: [
    containerTemplate(name: 'tree', image: 'iankoulski/tree', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'docker', image: "desmart/dind", ttyEnabled: true, privileged: true, command: 'dockerd --host=unix:///var/run/docker.sock '),
    containerTemplate(name: 'maven',  image: "maven:3.5.2-jdk-8-alpine", ttyEnabled: true, command: 'cat'),
    // containerTemplate(name: 'node', image: 'node:8.16.2-alpine3.10', command: 'cat', ttyEnabled: true),
		containerTemplate(name: "kubectl", image: "lachlanevenson/k8s-kubectl", command: "cat", ttyEnabled: true)
	],
	//volume mount
	volumes: [
		// hostPathVolume(hostPath: "/var/run/docker.sock", mountPath: "/var/run/docker.sock")
    
	]
)
{
	node(label) {
    
    try {
      stage('Preparation') { // for display purposes
        echo "Current workspace : ${workspace}"
        // sh "ls -lt  package.json nodejs-exporter.js logger.js redis-ha.js server.js"
        // def slackResponse = slackSend(channel: "alert", color: '#0000FF', message: "Preparation: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        // slackResponse.addReaction("thumbsup")

        slackSend(channel: "alert", color: '#0000FF', message: "Preparation: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }

      stage("Get Source") {
        // git url:"http://gitea.nodespringboot.org/taeyeol/nodejs-bot.git", branch: "main", credentialsId: "git_credential"
        // git branch: 'main', url: 'http://gitea.nodespringboot.org/taeyeol/nodejs-bot.git'
        checkout scm
        container('tree') {
          // sh 'env'
          sh 'tree'
          // sh 'test -f old-evn.txt && cat old-env.txt'
          // sh 'env > old-env.txt'
        }
        slackSend(channel: "alert", color: '#0000FF', message: "Checkout - SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      } 

      //-- 환경변수 파일 읽어서 변수값 셋팅 
      def props = readProperties file: 'Jenkins.pipeline.properties'

      def dockerRegistryURL           = props["dockerRegistryURL"]
      def service_account             = props["serivce_account"]
      def dockerRegistryCredentialsId = props["dockerRegistryCredentialsId"]
      def cicd_namespace              = props["cicd_namespace"]
      def cicd_pvc                    = props["cicd_pvc"]
      def namespace                   = props["namespace"]
      def app                         = props["app"]
      def version                     = props["version"]

      def loginServer                 = props["loginServer"]
      def accessToken                 = props["accessToken"]
      def repositoryName              = props["repositoryName"]
      def acrName                     = props["acrName"]

      stage('Build Maven Project') {
        container('maven') {
          // withMaven(maven: "maven-3", globalMavenSettingsConfig: "${MAVEN_SETTINGS}") {
          // withMaven( ) {
          sh "mvn -B clean package"
          sh "ls -lt target/*.war"
          //   sh 'mvn --settings settings.xml -e -U clean package -DskipTests=true -DfinalName=app -Ddockerfile.skip'
          // }

          // send slack notification
          slackSend(channel: "mta", color: '#0000FF', message: "Maven Build - SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})") 
        }
      }

      stage('Build Node.js Project & Docker Image') {
        container('docker') {
          // sh "docker build --rm=true --network=host --tag ${app}:${version} ."
          // sh "docker build --rm=true --network=host --tag ${app}:${version} -f deployment/Dockerfile"
          
          sh "docker build --rm=true --network=host --tag ${app}:${version} ."
          sh "docker tag ${app}:${version} ${dockerRegistryURL}/${namespace}/${app}:${version}"
          
          slackSend(channel: "alert", color: '#0000FF', message: "Docker Build - SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          // slackResponse.addReaction("thumbsup")
        }
        // app = docker.build("${dockerRegistryURL}/${namespace}/${app}:${version}") // docker image build 및 이름을 dockerRegistryURL/namespace/name:빌드번호 설정
        // slackSend(channel: "alert", color: '#0000FF', message: "Docker Build - SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }


      stage('Push Docker Image') {
        container('docker') {
          sh "docker login ${loginServer} -u '00000000-0000-0000-0000-000000000000' -p ${accessToken}"
          
          sh "docker tag ${repositoryName}:${version} ${loginServer}/${repositoryName}:${version}"
          sh "docker push ${loginServer}/${repositoryName}:${version}"

          slackSend(channel: "alert", color: '#0000FF', message: "Docker Push - SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          /*
          withDockerRegistry(credentialsId: "${dockerRegistryCredentialsId}", url: "https://${dockerRegistryURL}") {
            // docker.withRegistry("http://${dockerRegistryURL}", "${dockerRegistryCredentialsId}") {
            // sh "docker push ${dockerRegistryURL}/${namespace}/${app}:${version}"
            
            docker.image("${dockerRegistryURL}/${namespace}/${app}:${version}").push( )
          
            // send slack notification
            slackSend(channel: "alert", color: '#0000FF', message: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            // slackResponse.addReaction("thumbsup")
          } // withDockerRegistry
          */
        } // container
      }

        // stage( "Clean Up Existing Deployments" ) {
        // 		container("kubectl") {
        // 		  sh "kubectl delete deployments -n ${namespace} --selector=${selector_key}=${selector_val}"
        // 	 }
        // }

        // stage( "Deploy to Cluster" ) {
        //	container("kubectl") {
        //		sh "kubectl apply -n ${namespace} -f ${deployment}"
        //		sh "sleep 5"
        //		sh "kubectl apply -n ${namespace} -f ${service}"
        //		sh "kubectl apply -n ${namespace} -f ${ingress}"
        //	}
        // }
    } // try
    catch(Exception e) {
      currentBuild.result = "FAILED"
      // send slack notification
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      // slackResponse.addReaction("thumbsup")
      // throw the error
      echo e.toString( )
      throw e
    } // catch
	} // node
}