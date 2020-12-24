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
				catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
				sh '''
                    			chmod +x bandit-env.sh
                    			./bandit-env.sh
                    			'''
				
				}
			}
		}
		
			
		stage('Code Quality') {
			parallel {
				stage('Backend Quality'){
					steps {
					dir("/home/metlife-backend/deployments/metlife_poc"){
					catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
					sh "ls"
					sh "pwd"
					 script {
          				// requires SonarQube Scanner
          				scannerHome = tool 'sonarscanner';
        				}
				
				sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=Metlife-POC -Dsonar.sources=metlife_poc -Dsonar.host.url=http://10.62.10.33:9000  -Dsonar.login=d49baa71cce9767a40392900f3bd28e34affba7b"
				}
				}
					 
				}
					
				}
				stage('UI Quality'){
					steps{
					sh 'echo "UI Quality"'
					//script to execute UI Quality
					}
				}
			}
			
		}
	
	stage('Deployment') {
		
            steps {
		    script{
			props = readProperties file: '/home/metlife-backend/deployments/jenkins.properties'
			env.DEBUG=props.DEBUG
            		env.DB_NAME=prrops.DB_NAME
            		env.DB_USER=props.DB_USER
            		env.DB_PASSWORD=props.DB_PASSWORD
            		env.DB_PORT=props.DB_PORT
            		env.DB_HOST=props.DB_HOST
            		env.LOG_DIR=props.LOG_DIR
		}
		catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                sh '''
                    chmod +x deployment.sh
                    ./deployment.sh
                    '''         
           	 }
	    }
        
		}
		stage("SAST Scan Report"){
		
		steps {
		publishHTML (target : [allowMissing: false,
 		alwaysLinkToLastBuild: true,
 		keepAll: true,
 		reportDir: '/home/metlife-backend/deployments',
 		reportFiles: 'sast_out.html',
 		reportName: 'SAST Scan Report',
 		reportTitles: 'SAST Scan Report'])
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
