#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp etcdsshscript.sh ${instance}:./
done