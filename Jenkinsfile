pipeline {
	agent any
	options { skipDefaultCheckout() }	
    	stages {
          stage("Checkout SCM") {
			steps {
				cleanWs()
				echo 'checkout scm'
				checkout scm
			}
		}	
	    stage('Setup Python Virtual Environment'){
			
            steps {
                sh '''
                    chmod +x envsetup.sh
                    ./envsetup.sh
                    '''
            }
	 }
		stage('Unit Testing'){
		parallel {
			stage("Unit Test Backend") {
			steps {
				sh 'echo "UnitTesting Backend"'
                		//sh 'python manage.py test'
				
			}
			}
			stage("Unit Test Frontend") {
			steps {
				sh 'echo "UnitTesting Frontend"'
                		//sh 'ng runscripts test'
				
			}
			}
		}
		}
		
		stage('SAST scan') {
			steps {
				echo 'SAST scan Stage'
				sh '''
                    			chmod +x bandit-env.sh
                    			./bandit-env.sh
                    			'''
				sh 'bandit -r ./'

			}
		}
		
			
		stage('Code Quality') {
			steps {
			dir("/home/lduser/deployments/deployments/metlife_poc"){
			catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
				sh "ls"
				sh "pwd"
					 script {
          				// requires SonarQube Scanner
          				scannerHome = tool 'sonarscanner';
        				}
				
				sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=Metlife-POC -Dsonar.sources=. -Dsonar.host.url=http://10.62.10.33:9000  -Dsonar.login=d49baa71cce9767a40392900f3bd28e34affba7b"
			}
			}
					 
			}
		}
	
	stage('Deployment') {
		
            steps {
                sh '''
                    chmod +x deplyment.sh
                    ./deployment.sh
                    '''         
            }
        
		}

		
	}     
    post {
        always {
            echo 'JENKINS PIPELINE'
        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}
