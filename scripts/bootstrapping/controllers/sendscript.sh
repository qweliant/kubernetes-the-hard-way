#!/bin/bash

gcloud compute scp rbac.sh controller-0:./

for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp provision.sh healthcheck.sh ${instance}:./
done