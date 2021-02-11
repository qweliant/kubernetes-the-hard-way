
# create VPC
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

# create subnet for network
gcloud compute networks subnets create kubernetes \
--network kubernetes-the-hard-way \
  --range 10.240.0.0/24

