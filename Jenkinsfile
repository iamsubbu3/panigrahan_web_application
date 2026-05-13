pipeline {
    agent any

    tools {
        jdk 'jdk21'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    environment {

        /* ===================================================== */
        /* BUILD CONFIGURATION                                   */
        /* ===================================================== */

        DOCKER_BUILDKIT = "1"

        /* ===================================================== */
        /* SONARQUBE SETTINGS                                    */
        /* ===================================================== */

        SCANNER_HOME      = tool 'sonar-scanner'
        SONAR_PROJECT_KEY = "panigrahan-web-app"
        SONAR_HOST_URL    = "http://sonarqube.company.com"

        /* ===================================================== */
        /* DOCKER SETTINGS                                       */
        /* ===================================================== */

        DOCKER_USER = "iamsubbu3"

        FRONTEND_IMAGE = "react-frontend"
        BACKEND_IMAGE  = "node-backend"

        REGISTRY_CRED = "docker-credentials"

        /* Semantic Versioning */

        MAJOR_VERSION = "1"
        MINOR_VERSION = "0"
        PATCH_VERSION = "${BUILD_NUMBER}"

        FRONTEND_TAG = "${DOCKER_USER}/${FRONTEND_IMAGE}:v${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}"
        BACKEND_TAG  = "${DOCKER_USER}/${BACKEND_IMAGE}:v${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}"

        FRONTEND_LATEST = "${DOCKER_USER}/${FRONTEND_IMAGE}:latest"
        BACKEND_LATEST  = "${DOCKER_USER}/${BACKEND_IMAGE}:latest"

        /* ===================================================== */
        /* KUBERNETES / EKS SETTINGS                             */
        /* ===================================================== */

        AWS_REGION  = "us-east-1"
        EKS_CLUSTER = "panigrahan"

        K8S_NAMESPACE = "panigrahan"

        FRONTEND_DEPLOYMENT = "react-frontend"
        BACKEND_DEPLOYMENT  = "node-backend"

        FRONTEND_CONTAINER = "react-frontend"
        BACKEND_CONTAINER  = "node-backend"

        /* ===================================================== */
        /* NOTIFICATIONS                                         */
        /* ===================================================== */

        NOTIFY_EMAIL = "subramanyam9979@gmail.com"
    }

    triggers {
        githubPush()
    }

    stages {

        /* ===================================================== */
        /* STAGE 1 — CHECKOUT SOURCE CODE                        */
        /* ===================================================== */

        stage('Checkout') {

            steps {

                cleanWs()

                git branch: 'main',
                    credentialsId: 'github-private-repo',
                    url: 'https://github.com/iamsubbu3/panigrahan_web_application.git'
            }
        }

        /* ===================================================== */
        /* STAGE 2 — SONARQUBE STATIC ANALYSIS                   */
        /* ===================================================== */

        stage('SonarQube Scan') {

            steps {

                withSonarQubeEnv('sonar') {

                    sh """
                        ${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${SONAR_PROJECT_KEY} \
                        -Dsonar.host.url=${SONAR_HOST_URL} \
                        -Dsonar.sources=client/src,server \
                        -Dsonar.sourceEncoding=UTF-8 \
                        -Dsonar.exclusions=**/node_modules/**,**/dist/**,**/build/**,**/coverage/** \
                        -Dsonar.verbose=true
                    """
                }
            }
        }

        /* ===================================================== */
        /* STAGE 3 — SONAR QUALITY GATE                          */
        /* ===================================================== */

        stage('Quality Gate') {

            steps {

                timeout(time: 5, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true
                }
            }
        }

        /* ===================================================== */
        /* STAGE 4 — BUILD FRONTEND IMAGE                        */
        /* ===================================================== */

        stage('Build Frontend Docker Image') {

            steps {

                dir('client') {

                    script {

                        docker.build(
                            FRONTEND_TAG,

                            "--pull " +
                            "--label build_number=${BUILD_NUMBER} " +
                            "--label git_commit=${GIT_COMMIT} " +
                            "--label project=${FRONTEND_IMAGE} ."
                        )
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 5 — BUILD BACKEND IMAGE                         */
        /* ===================================================== */

        stage('Build Backend Docker Image') {

            steps {

                dir('server') {

                    script {

                        docker.build(
                            BACKEND_TAG,

                            "--pull " +
                            "--label build_number=${BUILD_NUMBER} " +
                            "--label git_commit=${GIT_COMMIT} " +
                            "--label project=${BACKEND_IMAGE} ."
                        )
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 6 — TRIVY FRONTEND SECURITY SCAN                */
        /* ===================================================== */

        stage('Trivy Frontend Security Scan') {

            steps {

                script {

                    sh """
                        trivy image \
                        --severity LOW,MEDIUM,HIGH \
                        ${FRONTEND_TAG}
                    """

                    sh """
                        trivy image \
                        --exit-code 1 \
                        --severity CRITICAL \
                        ${FRONTEND_TAG}
                    """

                    sh """
                        trivy image \
                        --format json \
                        -o frontend-trivy-report.json \
                        ${FRONTEND_TAG}
                    """

                    archiveArtifacts artifacts: 'frontend-trivy-report.json',
                    fingerprint: true
                }
            }
        }

        /* ===================================================== */
        /* STAGE 7 — TRIVY BACKEND SECURITY SCAN                 */
        /* ===================================================== */

        stage('Trivy Backend Security Scan') {

            steps {

                script {

                    sh """
                        trivy image \
                        --severity LOW,MEDIUM,HIGH \
                        ${BACKEND_TAG}
                    """

                    sh """
                        trivy image \
                        --exit-code 1 \
                        --severity CRITICAL \
                        ${BACKEND_TAG}
                    """

                    sh """
                        trivy image \
                        --format json \
                        -o backend-trivy-report.json \
                        ${BACKEND_TAG}
                    """

                    archiveArtifacts artifacts: 'backend-trivy-report.json',
                    fingerprint: true
                }
            }
        }

        /* ===================================================== */
        /* STAGE 8 — DOCKER PUSH                                 */
        /* ===================================================== */

        stage('Docker Push Images') {

            steps {

                script {

                    withDockerRegistry(
                        [
                            credentialsId: REGISTRY_CRED,
                            url: 'https://index.docker.io/v1/'
                        ]
                    ) {

                        /* FRONTEND */

                        sh "docker push ${FRONTEND_TAG}"

                        sh """
                            docker tag \
                            ${FRONTEND_TAG} \
                            ${FRONTEND_LATEST}
                        """

                        sh "docker push ${FRONTEND_LATEST}"

                        /* BACKEND */

                        sh "docker push ${BACKEND_TAG}"

                        sh """
                            docker tag \
                            ${BACKEND_TAG} \
                            ${BACKEND_LATEST}
                        """

                        sh "docker push ${BACKEND_LATEST}"
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 9 — DEPLOY TO EKS                               */
        /* ===================================================== */

        stage('Deploy to EKS (Auto Rollback Enabled)') {

            steps {

                dir('k8s-manifests') {

                    withCredentials([
                        aws(
                            credentialsId: 'aws-keys',
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                        )
                    ]) {

                        sh """
                            aws eks update-kubeconfig \
                              --region ${AWS_REGION} \
                              --name ${EKS_CLUSTER}
                        """

                        /* ===================================================== */
                        /* VALIDATE NAMESPACE                                    */
                        /* ===================================================== */

                        sh """
                            kubectl get ns ${K8S_NAMESPACE} || \
                            kubectl create ns ${K8S_NAMESPACE}
                        """

                        /* ===================================================== */
                        /* APPLY K8S MANIFESTS                                   */
                        /* ===================================================== */

                        sh """
                            kubectl apply -n ${K8S_NAMESPACE} \
                            -f mysql-deployment.yaml
                        """

                        sh """
                            kubectl apply -n ${K8S_NAMESPACE} \
                            -f backend-deployment.yaml
                        """

                        sh """
                            kubectl apply -n ${K8S_NAMESPACE} \
                            -f frontend-deployment.yaml
                        """

                        /* ===================================================== */
                        /* VALIDATE DEPLOYMENTS EXIST                            */
                        /* ===================================================== */

                        sh """
                            kubectl get deployment ${FRONTEND_DEPLOYMENT} \
                            -n ${K8S_NAMESPACE}
                        """

                        sh """
                            kubectl get deployment ${BACKEND_DEPLOYMENT} \
                            -n ${K8S_NAMESPACE}
                        """

                        /* ===================================================== */
                        /* DEPLOY FRONTEND                                       */
                        /* ===================================================== */

                        script {

                            try {

                                sh """
                                    kubectl set image \
                                    deployment/${FRONTEND_DEPLOYMENT} \
                                    ${FRONTEND_CONTAINER}=${FRONTEND_TAG} \
                                    -n ${K8S_NAMESPACE}
                                """

                                sh """
                                    kubectl rollout status \
                                    deployment/${FRONTEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE} \
                                    --timeout=180s
                                """

                            } catch (err) {

                                sh """
                                    kubectl rollout undo \
                                    deployment/${FRONTEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE}
                                """

                                sh """
                                    kubectl rollout status \
                                    deployment/${FRONTEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE}
                                """

                                error("Frontend deployment failed. Rolled back to previous stable version.")
                            }
                        }

                        /* ===================================================== */
                        /* DEPLOY BACKEND                                        */
                        /* ===================================================== */

                        script {

                            try {

                                sh """
                                    kubectl set image \
                                    deployment/${BACKEND_DEPLOYMENT} \
                                    ${BACKEND_CONTAINER}=${BACKEND_TAG} \
                                    -n ${K8S_NAMESPACE}
                                """

                                sh """
                                    kubectl rollout status \
                                    deployment/${BACKEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE} \
                                    --timeout=180s
                                """

                            } catch (err) {

                                sh """
                                    kubectl rollout undo \
                                    deployment/${BACKEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE}
                                """

                                sh """
                                    kubectl rollout status \
                                    deployment/${BACKEND_DEPLOYMENT} \
                                    -n ${K8S_NAMESPACE}
                                """

                                error("Backend deployment failed. Rolled back to previous stable version.")
                            }
                        }
                    }
                }
            }
        }
    }

    /* ===================================================== */
    /* POST BUILD ACTIONS                                     */
    /* ===================================================== */

    post {

        success {

            emailext(

                subject: "✅ SUCCESS | ${JOB_NAME} #${BUILD_NUMBER}",

                body: """
Hi Team,

✅ Pipeline executed successfully.

🔹 Job Name : ${JOB_NAME}
🔹 Build No : ${BUILD_NUMBER}

🐳 Frontend Image:
${FRONTEND_TAG}

🐳 Backend Image:
${BACKEND_TAG}

🏷️ Frontend Latest:
${FRONTEND_LATEST}

🏷️ Backend Latest:
${BACKEND_LATEST}

🔗 Jenkins Build:
${BUILD_URL}

🔗 SonarQube:
${SONAR_HOST_URL}/dashboard?id=${SONAR_PROJECT_KEY}

Regards,
DevOps Automation
""",

                to: "${NOTIFY_EMAIL}"
            )
        }

        failure {

            emailext(

                subject: "❌ FAILURE | ${JOB_NAME} #${BUILD_NUMBER}",

                body: """
Hi Team,

❌ Pipeline FAILED.

🔹 Job Name : ${JOB_NAME}
🔹 Build No : ${BUILD_NUMBER}

🔗 Logs:
${BUILD_URL}console

Regards,
DevOps Automation
""",

                to: "${NOTIFY_EMAIL}"
            )
        }

        always {

            echo "🧹 Cleaning Jenkins Docker Images..."

            sh """
                docker images \
                --filter "label=project=${FRONTEND_IMAGE}" -q | \
                xargs -r docker rmi -f || true
            """

            sh """
                docker images \
                --filter "label=project=${BACKEND_IMAGE}" -q | \
                xargs -r docker rmi -f || true
            """

            sh "docker image prune -f || true"
        }
    }
}