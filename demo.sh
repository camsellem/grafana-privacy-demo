#!/bin/bash
#set -e

SVC_COFFEE_PATH="/Users/camsellem/Development/coffee-demo/coffee-service"
SVC_BEAN_PATH="/Users/camsellem/Development/coffee-demo/bean-service"
HELM_CHART_PATH="/Users/camsellem/Development/coffee-demo/helm"
K8S_AGENT_NAMESPACE="default"

GC_METRICS_ENDPOINT="https://prometheus-prod-10-prod-us-central-0.grafana.net/api/prom/push"
GC_METRICS_USERNAME="208413"
GC_LOGS_ENDPOINT="https://logs-prod-us-central1.grafana.net/loki/api/v1/push"
GC_LOGS_USERNAME="103178"
GC_TRACES_ENDPOINT="https://prometheus-prod-10-prod-us-central-0.grafana.net/api/prom/push"
GC_TRACES_USERNAME="99690"
GC_API_KEY="eyJrIjoiNDUzZDk5ODVmYTQ0MGRmZGI2ZjQwNDljMDRhOGIxMjU5NzYzMDE1NiIsIm4iOiJjYW1zZWxsZW0tZWFzeXN0YXJ0LXByb20tcHVibGlzaGVyIiwiaWQiOjQ2ODg4MX0="

DOCKER_IMG_REPO_URL="australia-southeast1-docker.pkg.dev/solutions-engineering-248511/camsellem-artifact-repo"


clean() {
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cd $SCRIPT_DIR

  echo "*-*-*-*-* Undeploying Helm chart *-*-*-*-*"
  helm uninstall privacy-app-prod-release
}

build() {
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cd $SCRIPT_DIR

  echo "*-*-*-*-* Building images *-*-*-*-*"
  docker build --pull --rm -f "docker/Dockerfile" -t privacy-app-frontend:latest "docker"

  echo "*-*-*-*-* Tagging images *-*-*-*-*"
  docker tag privacy-app-frontend:latest $DOCKER_IMG_REPO_URL/privacy-app-frontend:latest

  echo "*-*-*-*-* Uploading images *-*-*-*-*"
  docker push $DOCKER_IMG_REPO_URL/privacy-app-frontend:latest
}

deploy() {
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cd $SCRIPT_DIR/helm

  echo "*-*-*-*-* Deploying Helm chart *-*-*-*-*"
  helm install \
  --set www.image.repository=$DOCKER_IMG_REPO_URL/privacy-app-frontend privacy-app-prod-release \
  --set agent.gcloud.metrics.url=$GC_METRICS_ENDPOINT \
  --set agent.gcloud.metrics.basic_auth.username=$GC_METRICS_USERNAME \
  --set agent.gcloud.metrics.basic_auth.password=$GC_API_KEY \
  --set agent.gcloud.logs.url=$GC_LOGS_ENDPOINT \
  --set agent.gcloud.logs.basic_auth.username=$GC_LOGS_USERNAME \
  --set agent.gcloud.logs.basic_auth.password=$GC_API_KEY \
  .
}

case "$1" in
   clean)
      shift
      clean
      ;;
   build)
      shift
      build
      ;;
   deploy)
      shift
      deploy
      ;;
esac