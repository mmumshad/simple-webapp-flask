
pipeline {
    agent any
	
    stages {
        stage('Checkout project') {
            steps {
                script {
				
                    #git branch: "master",
                        #credentialsId: 'my-credentials',
                        git 'https://user@github.org/myproject/sample-repo.git'
                }
            }
        }
    }
}
 
