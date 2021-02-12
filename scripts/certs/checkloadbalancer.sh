#!/bin/bash

# Retrieve the kubernetes-the-hard-way static IP address:
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

# Make a HTTP request for the Kubernetes version info:
curl --cacert ca.pem https://${KUBERNETES_PUBLIC_ADDRESS}:6443/version