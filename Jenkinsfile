pipeline {

    agent any

    tools {

        jdk 'jdk21'
        nodejs 'node20'
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

        SONAR_HOST_URL    = "http://13.222.94.130:9000"

        /* ===================================================== */
        /* DOCKER SETTINGS                                       */
        /* ===================================================== */

        DOCKER_USER = "iamsubbu3"

        FRONTEND_IMAGE = "panigrahan-frontend"

        BACKEND_IMAGE  = "panigrahan-backend"

        REGISTRY_CRED = "docker-credentials"

        /* ===================================================== */
        /* KUBERNETES SETTINGS                                   */
        /* ===================================================== */

        K8S_NAMESPACE = "panigrahan"

        FRONTEND_DEPLOYMENT = "frontend"

        BACKEND_DEPLOYMENT  = "backend"

        MYSQL_DEPLOYMENT = "mysql"

        /* ===================================================== */
        /* EMAIL NOTIFICATIONS                                   */
        /* ===================================================== */

        NOTIFY_EMAIL = "subramanyam9979@gmail.com,poojipoojari2006@gmail.com,karthik2018mr@gmail.com"
    }

    triggers {

        githubPush()
    }

    stages {

        /* ===================================================== */
        /* STAGE 1 — CHECKOUT                                    */
        /* ===================================================== */

        stage('Checkout') {

            steps {

                checkout([
                    $class: 'GitSCM',

                    branches: [[name: '*/main']],

                    userRemoteConfigs: [[
                        credentialsId: 'github-private-repo',
                        url: 'https://github.com/iamsubbu3/panigrahan_web_application.git'
                    ]],

                    extensions: [[
                        $class: 'CloneOption',
                        shallow: false,
                        noTags: false
                    ]]
                ])

                script {

                    def GIT_TAG = sh(
                        script: "git describe --tags --exact-match HEAD 2>/dev/null || true",
                        returnStdout: true
                    ).trim()

                    if (GIT_TAG) {

                        env.APP_VERSION = GIT_TAG

                    } else {

                        env.APP_VERSION = "build-${BUILD_NUMBER}"
                    }

                    env.FRONTEND_TAG = "${DOCKER_USER}/${FRONTEND_IMAGE}:${APP_VERSION}"

                    env.BACKEND_TAG = "${DOCKER_USER}/${BACKEND_IMAGE}:${APP_VERSION}"

                    env.FRONTEND_LATEST = "${DOCKER_USER}/${FRONTEND_IMAGE}:latest"

                    env.BACKEND_LATEST = "${DOCKER_USER}/${BACKEND_IMAGE}:latest"

                    echo "=================================================="

                    echo "APPLICATION VERSION: ${APP_VERSION}"

                    echo "=================================================="
                }
            }
        }

        /* ===================================================== */
        /* STAGE 2 — DETECT CHANGES                              */
        /* ===================================================== */

        stage('Detect Changes') {

            steps {

                script {

                    env.FRONTEND_CHANGED = sh(
                        script: """
                            git diff --name-only HEAD~1 HEAD 2>/dev/null | grep '^client/' > /dev/null
                        """,
                        returnStatus: true
                    ) == 0 ? "true" : "false"

                    env.BACKEND_CHANGED = sh(
                        script: """
                            git diff --name-only HEAD~1 HEAD 2>/dev/null | grep '^server/' > /dev/null
                        """,
                        returnStatus: true
                    ) == 0 ? "true" : "false"

                    echo "=================================================="

                    echo "FRONTEND CHANGED: ${FRONTEND_CHANGED}"

                    echo "BACKEND CHANGED: ${BACKEND_CHANGED}"

                    echo "=================================================="
                }
            }
        }

        /* ===================================================== */
        /* STAGE 3 — VERIFY NODE                                 */
        /* ===================================================== */

        stage('Verify NodeJS') {

            steps {

                sh '''
                    node -v
                    npm -v
                '''
            }
        }

        /* ===================================================== */
        /* STAGE 4 — INSTALL FRONTEND DEPENDENCIES               */
        /* ===================================================== */

        stage('Install Frontend Dependencies') {

            when {

                expression {

                    env.FRONTEND_CHANGED == "true"
                }
            }

            steps {

                dir('client') {

                    script {

                        if (!fileExists('node_modules')) {

                            echo "=================================================="

                            echo "📦 FRONTEND node_modules NOT FOUND"

                            echo "📦 INSTALLING FRONTEND DEPENDENCIES"

                            echo "=================================================="

                            sh 'npm install'

                        } else {

                            echo "=================================================="

                            echo "✅ FRONTEND node_modules ALREADY EXISTS"

                            echo "✅ SKIPPING npm install"

                            echo "=================================================="
                        }
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 5 — INSTALL BACKEND DEPENDENCIES                */
        /* ===================================================== */

        stage('Install Backend Dependencies') {

            when {

                expression {

                    env.BACKEND_CHANGED == "true"
                }
            }

            steps {

                dir('server') {

                    script {

                        if (!fileExists('node_modules')) {

                            echo "=================================================="

                            echo "📦 BACKEND node_modules NOT FOUND"

                            echo "📦 INSTALLING BACKEND DEPENDENCIES"

                            echo "=================================================="

                            sh 'npm install'

                        } else {

                            echo "=================================================="

                            echo "✅ BACKEND node_modules ALREADY EXISTS"

                            echo "✅ SKIPPING npm install"

                            echo "=================================================="
                        }
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 6 — SONARQUBE SCAN                              */
        /* ===================================================== */

        // stage('SonarQube Scan') {

        //     steps {

        //         withSonarQubeEnv('sonar') {

        //             sh """
        //                 ${SCANNER_HOME}/bin/sonar-scanner \
        //                 -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
        //                 -Dsonar.projectName=${SONAR_PROJECT_KEY} \
        //                 -Dsonar.host.url=${SONAR_HOST_URL} \
        //                 -Dsonar.sources=client/src,server \
        //                 -Dsonar.sourceEncoding=UTF-8 \
        //                 -Dsonar.exclusions=**/node_modules/**,**/dist/**,**/build/**
        //             """
        //         }
        //     }
        // }

        /* ===================================================== */
        /* STAGE 7 — QUALITY GATE                                */
        /* ===================================================== */

        // stage('Quality Gate') {

        //     steps {

        //         timeout(time: 10, unit: 'MINUTES') {

        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        /* ===================================================== */
        /* STAGE 8 — BUILD FRONTEND IMAGE                        */
        /* ===================================================== */

        stage('Build Frontend Docker Image') {

            when {

                expression {

                    env.FRONTEND_CHANGED == "true"
                }
            }

            steps {

                dir('client') {

                    script {

                        docker.build(
                            FRONTEND_TAG,
                            "--label build_number=${BUILD_NUMBER} " +
                            "--label git_commit=${GIT_COMMIT} " +
                            "--label project=${FRONTEND_IMAGE} ."
                        )
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 9 — BUILD BACKEND IMAGE                         */
        /* ===================================================== */

        stage('Build Backend Docker Image') {

            when {

                expression {

                    env.BACKEND_CHANGED == "true"
                }
            }

            steps {

                dir('server') {

                    script {

                        docker.build(
                            BACKEND_TAG,
                            "--label build_number=${BUILD_NUMBER} " +
                            "--label git_commit=${GIT_COMMIT} " +
                            "--label project=${BACKEND_IMAGE} ."
                        )
                    }
                }
            }
        }

        // /* ===================================================== */
        // /* STAGE 10 — TRIVY FRONTEND SCAN                        */
        // /* ===================================================== */

        // stage('Trivy Frontend Security Scan') {

        //     when {

        //         expression {

        //             env.FRONTEND_CHANGED == "true"
        //         }
        //     }

        //     steps {

        //         sh """
        //             trivy image \
        //             --severity LOW,MEDIUM,HIGH \
        //             ${FRONTEND_TAG}
        //         """

        //         sh """
        //             trivy image \
        //             --exit-code 1 \
        //             --severity CRITICAL \
        //             ${FRONTEND_TAG}
        //         """
        //     }
        // }

        // /* ===================================================== */
        // /* STAGE 11 — TRIVY BACKEND SCAN                         */
        // /* ===================================================== */

        // stage('Trivy Backend Security Scan') {

        //     when {

        //         expression {

        //             env.BACKEND_CHANGED == "true"
        //         }
        //     }

        //     steps {

        //         sh """
        //             trivy image \
        //             --severity LOW,MEDIUM,HIGH \
        //             ${BACKEND_TAG}
        //         """

        //         sh """
        //             trivy image \
        //             --exit-code 1 \
        //             --severity CRITICAL \
        //             ${BACKEND_TAG}
        //         """
        //     }
        // }

        /* ===================================================== */
        /* STAGE 12 — PUSH FRONTEND IMAGE                        */
        /* ===================================================== */

        stage('Push Frontend Docker Image') {

            when {

                expression {

                    env.FRONTEND_CHANGED == "true"
                }
            }

            steps {

                script {

                    withDockerRegistry(
                        [
                            credentialsId: REGISTRY_CRED,
                            url: 'https://index.docker.io/v1/'
                        ]
                    ) {

                        sh "docker push ${FRONTEND_TAG}"

                        sh """
                            docker tag \
                            ${FRONTEND_TAG} \
                            ${FRONTEND_LATEST}
                        """

                        sh "docker push ${FRONTEND_LATEST}"
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 13 — PUSH BACKEND IMAGE                         */
        /* ===================================================== */

        stage('Push Backend Docker Image') {

            when {

                expression {

                    env.BACKEND_CHANGED == "true"
                }
            }

            steps {

                script {

                    withDockerRegistry(
                        [
                            credentialsId: REGISTRY_CRED,
                            url: 'https://index.docker.io/v1/'
                        ]
                    ) {

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
        /* STAGE 14 — DEPLOY MYSQL                               */
        /* ===================================================== */

        stage('Deploy MySQL') {

            when {

                changeset "k8s-manifests/mysql-*"
            }

            steps {

                dir('k8s-manifests') {

                    script {

                        sh """
                            export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                            kubectl apply -f mysql-headless-service.yaml

                            kubectl apply -f mysql-secret.yaml

                            kubectl apply -f mysql-statefulset.yaml
                        """

                        try {

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl rollout status \
                                statefulset/${MYSQL_DEPLOYMENT} \
                                -n ${K8S_NAMESPACE} \
                                --timeout=180s
                            """

                        } catch (err) {

                            echo "❌ MYSQL STATEFULSET DEPLOYMENT FAILED"

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl get pods -n ${K8S_NAMESPACE}

                                kubectl describe statefulset ${MYSQL_DEPLOYMENT} -n ${K8S_NAMESPACE} || true

                                kubectl logs statefulset/${MYSQL_DEPLOYMENT} -n ${K8S_NAMESPACE} || true
                            """

                            error("MySQL StatefulSet deployment failed.")
                        }
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 15 — DEPLOY BACKEND                             */
        /* ===================================================== */

        stage('Deploy Backend') {

            when {

                expression {

                    env.BACKEND_CHANGED == "true"
                }
            }

            steps {

                dir('k8s-manifests') {

                    script {

                        sh "git checkout -- backend-deployment.yaml || true"

                        sh """
                            sed -i 's|BACKEND_IMAGE_PLACEHOLDER|${BACKEND_TAG}|g' backend-deployment.yaml
                        """

                        sh """
                            export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                            kubectl apply -f backend-configmap.yaml

                            kubectl apply -f backend-secret.yaml

                            kubectl apply -f uploads-pvc.yaml

                            kubectl apply -f backend-deployment.yaml

                            kubectl apply -f backend-hpa.yaml
                        """

                        try {

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl rollout status \
                                deployment/${BACKEND_DEPLOYMENT} \
                                -n ${K8S_NAMESPACE} \
                                --timeout=180s
                            """

                        } catch (err) {

                            echo "❌ BACKEND DEPLOYMENT FAILED"

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl rollout undo \
                                deployment/${BACKEND_DEPLOYMENT} \
                                -n ${K8S_NAMESPACE}
                            """

                            error("Backend deployment failed. Rolled back successfully.")
                        }
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 16 — DEPLOY FRONTEND                            */
        /* ===================================================== */

        stage('Deploy Frontend') {

            when {

                expression {

                    env.FRONTEND_CHANGED == "true"
                }
            }

            steps {

                dir('k8s-manifests') {

                    script {

                        sh "git checkout -- frontend-deployment.yaml || true"

                        sh """
                            sed -i 's|FRONTEND_IMAGE_PLACEHOLDER|${FRONTEND_TAG}|g' frontend-deployment.yaml
                        """

                        sh """
                            export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                            kubectl apply -f frontend-deployment.yaml

                            kubectl apply -f frontend-hpa.yaml
                        """

                        try {

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl rollout status \
                                deployment/${FRONTEND_DEPLOYMENT} \
                                -n ${K8S_NAMESPACE} \
                                --timeout=180s
                            """

                        } catch (err) {

                            echo "❌ FRONTEND DEPLOYMENT FAILED"

                            sh """
                                export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                                kubectl rollout undo \
                                deployment/${FRONTEND_DEPLOYMENT} \
                                -n ${K8S_NAMESPACE}
                            """

                            error("Frontend deployment failed. Rolled back successfully.")
                        }
                    }
                }
            }
        }

        /* ===================================================== */
        /* STAGE 17 — VERIFY KUBERNETES                          */
        /* ===================================================== */

        stage('Verify Kubernetes Resources') {

            steps {

                sh """
                    export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

                    kubectl get pods -n ${K8S_NAMESPACE}

                    kubectl get deployment -n ${K8S_NAMESPACE}

                    kubectl get hpa -n ${K8S_NAMESPACE}

                    kubectl get pvc -n ${K8S_NAMESPACE}

                    kubectl get svc -n ${K8S_NAMESPACE}
                """
            }
        }
    }

    /* ===================================================== */
    /* POST BUILD ACTIONS                                    */
    /* ===================================================== */

    post {

        success {

            emailext(

                subject: "✅ SUCCESS | ${JOB_NAME} #${BUILD_NUMBER}",

                body: """
Hi Team,

✅ CI/CD Pipeline executed successfully.

🔹 Job Name:
${JOB_NAME}

🔹 Build Number:
${BUILD_NUMBER}

🏷️ Application Version:
${APP_VERSION}

🐳 Frontend Versioned Image:
${FRONTEND_TAG}

🐳 Backend Versioned Image:
${BACKEND_TAG}

🏷️ Frontend Latest Image:
${FRONTEND_LATEST}

🏷️ Backend Latest Image:
${BACKEND_LATEST}

🔗 Jenkins Build URL:
${BUILD_URL}

🔗 SonarQube Dashboard:
${SONAR_HOST_URL}/dashboard?id=${SONAR_PROJECT_KEY}

☸ Kubernetes Namespace:
${K8S_NAMESPACE}

🚀 Deployment Environment:
k3s Kubernetes Cluster

Regards,
DevSecOps Automation
""",

                to: "${NOTIFY_EMAIL}"
            )

            echo "✅ SUCCESS EMAIL SENT"
        }

        failure {

            emailext(

                subject: "❌ FAILURE | ${JOB_NAME} #${BUILD_NUMBER}",

                body: """
Hi Team,

❌ CI/CD Pipeline FAILED.

🔹 Job Name:
${JOB_NAME}

🔹 Build Number:
${BUILD_NUMBER}

🔗 Jenkins Console Logs:
${BUILD_URL}console

Possible Failure Areas:
- SonarQube Quality Gate
- Docker Build Failure
- Trivy Security Scan
- Docker Push Failure
- Kubernetes Rollout Failure

Please review Jenkins logs.

Regards,
DevSecOps Automation
""",

                to: "${NOTIFY_EMAIL}"
            )

            echo "❌ FAILURE EMAIL SENT"
        }

        always {

            script {

                echo "=================================================="

                echo "🧹 CLEANING FRONTEND DOCKER IMAGES"

                echo "=================================================="

                sh """
                    docker images \
                    --filter "label=project=${FRONTEND_IMAGE}" -q | \
                    sort -u | xargs -r docker rmi -f || true
                """

                echo "=================================================="

                echo "🧹 CLEANING BACKEND DOCKER IMAGES"

                echo "=================================================="

                sh """
                    docker images \
                    --filter "label=project=${BACKEND_IMAGE}" -q | \
                    sort -u | xargs -r docker rmi -f || true
                """

                echo "=================================================="

                echo "🧹 CLEANING UNUSED DOCKER IMAGES"

                echo "=================================================="

                sh "docker image prune -f || true"

                sh "docker builder prune -f || true"

                echo "=================================================="

                echo "✅ CLEANUP COMPLETED"

                echo "=================================================="
            }
        }
    }
}