
# create VPC
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

# create subnet for network
gcloud compute networks subnets create kubernetes \
--network kubernetes-the-hard-way \
  --range 10.240.0.0/24

# create firewall rules
# internal communications are all go
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

# allow SSH, ICMP, and, HTTPS
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0