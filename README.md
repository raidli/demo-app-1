# Introduction

This simple nodejs app is based on: https://github.com/cristiklein/node-hostname

There is a simple CI pipeline created using Github Actions to build the Docker image and push it to Google Cloud Artifact Registry.

CD portion is handled by ArgoCD (https://github/raidli/demo-app-1-infrastructure)

For running a sample GKE Autopilot cluster, please refer to https://github.com/raidli/demo-app-1-infrastructure

## Prerequisites

For local development, please use npm and nodejs to run the app. If you wish to use Docker to build an image and run this app then make sure you have docker engine installed, following these instructons https://docs.docker.com/engine/install/

## Local Development

In order to test this app natively, clone this repo and navigate to the root folder before following these instructions. 

Install dependencies:
```
npm install
```

then run the app:
```
npm run start
```
Open your browser and navigate to http://localhost:3000

If you wish to use Docker then first build the image:

```
docker build . -t node-hostname-image
```

and then you can run it:

```
docker run -dit -p 12000:3000 --name node-hostname node-hostname-image
```

Navigate to http://localhost:12000

To remove the running container:
```
docker rm node-hostname -f 
```

Remove the built docker image:
```
docker rmi node-hostname-image
```

## Kubernetes

Kustomize is used to create the app manifests for different environments. These manifests assume that ingress-nginx and cert-manager are already present in the cluster.

If you want to see these environment specific manifests, navigate to `kubernetes/envs/gcp/europe-north1/dev/app` and run either `kustomize build` or `kubectl kustomize` and it will generate all the manifests for you in your terminal.

If you want to apply these manifests to your own cluster then simply run `kubectl apply -k .` Just make sure to change the container image location in the Deployment to reflect your own image repository setup. Also make sure to change the `ingress-patch.yml` in order to use your own domain. Once the domain is changed, make sure the appropriate DNS A records are also pointing to the LB IP of the GKE cluster.

The `app` namespace is currently configured in the infrastructure repository (https://github.com/raidli/demo-app-1-infrastructure) to facilitate the use of ArgoCD.