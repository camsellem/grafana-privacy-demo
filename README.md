# grafana-privacy-demo
This is the 

## Pre-requisites
- Access to a Kubernetes cluster - the demo was tested on Google Kubernetes Engine (GKE)
- The Kubernetes command-line tool (kubectl) installed on your laptop
- Helm installed on your laptop

## Running the demo
Please

### Configure the script
You need to edit the script demo.sh and configure the following variables.
```sh
DOCKER_IMG_REPO_URL - URL of the images repository
K8S_AGENT_NAMESPACE - Namespace used to install the demo
GC_METRICS_ENDPOINT - Your Grafana Cloud Metrics endpoint
GC_METRICS_USERNAME - Your Grafana Cloud Metrics username
GC_LOGS_ENDPOINT    - Your Grafana Cloud Logs endpoint
GC_LOGS_USERNAME    - Your Grafana Cloud Logs username
GC_TRACES_ENDPOINT  - Your Grafana Cloud Traces endpoint
GC_TRACES_USERNAME  - Your Grafana Cloud Traces username
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

Once the deployment is over the script should displayed the address of the web portal and the Agent Push API

## Limitations
Because the web portal and the Grafana Agent Push API endpoint are exposed on different ports, you need to disable CORS protection in your browser.

One way to do it is by starting chrome with the specific flag as shown below

```sh
open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security
```
