# The Grafana Privacy demo
This repository contains the demo artifacts used for the Grafana webinar "Managing privacy in log data with Grafana Loki".

The purpose of the demo is to show:
- How to use Grafana Agent pipelines to obfuscate PII data in logs
- How to detect PII data and use Grafana Logs LBAC to protect access to sensitive information
- How to use Grafana Agent metrics to design PII audit dashboards in Grafana (TBD)

||
|--|--|
| __Title__    | Manages privacy in your log data with Grafana Logs                              |
| __Duration__ | 20 minutes                                                                      |
| __Audience__ | Technical and non-technical                                                     |
| __Personas__ | CISO <br> Devops                                                                |
| __Products__ | Grafana Cloud Logs<br>Grafana Enterprise Logs                                   |
| __Features__ | Grafana Agent - Pipeline stages<br>Grafana Agent - Pipeline metrics<br>LBAC     |

## Pre-requisites
- A Grafana Cloud stack (including logs and metrics instances)
- Access to a Kubernetes cluster - the demo was tested on Google Kubernetes Engine (GKE)
- The Kubernetes command-line tool (kubectl) installed on your laptop
- Helm installed on your laptop (tested with Helm v3)

## Running the demo
The following steps describe how to build and deploy the demo in your envrionment.

### Configure the script
You need to edit the script demo.sh and configure the following variables.
```sh
DOCKER_IMG_REPO_URL - URL of the images repository
K8S_AGENT_NAMESPACE - Namespace used to install the demo
GC_METRICS_ENDPOINT - Your Grafana Cloud Metrics endpoint
GC_METRICS_USERNAME - Your Grafana Cloud Metrics username
GC_LOGS_ENDPOINT    - Your Grafana Cloud Logs endpoint
GC_LOGS_USERNAME    - Your Grafana Cloud Logs username
GC_API_KEY          - Your Grafana Cloud API Key
 ```

### Build and upload the images
Run the following command in order to build the images and upload them to your images repository
```sh
./demo.sh build
 ```

### Deploy the demo
Run the following command in order to deploy the demo in your Kubernetes cluster
```sh
./demo.sh deploy
 ```

Once the deployment is over the script should displayed the address of the web portal and the Grafana Agent Push API

The agent also exposes pipeline metrics than can be used to track how many sensite values have been detected/deleted/redacted. These metrics can be displayed via the "Audit and privicaty dashboard". The template is available in the ./dashboard folder and must be imported in your Grafana Cloud instance.

### Delete the demo
If you wish to delete all deployed artifacts (frontend, agent, etc) please run the command below:
```sh
./demo.sh clean
 ```

Once the deployment is over the script should displayed the address of the web portal and the Grafana Agent Push API

## Limitations
Because the web portal and the Grafana Agent Push API endpoint are exposed on different ports, you need to disable CORS protection in your browser.

One way to do it is by starting chrome with the specific flag as shown below:

```sh
open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security
```

## TO-DO
- Add the dashboard to the repo
- Templatize agent version and namespace
- Clean Grafana Agent deployment
- Deploy an ingress controller for avoiding CORS issues
- Fix modal window on the web-app
- Clean-up the web-app