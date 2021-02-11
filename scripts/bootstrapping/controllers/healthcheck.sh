#!/bin/bash

# Enable HTTP Health Checks
# A Google Network Load Balancer will be used to distribute traffic 
# across the three API servers and allow each API server to terminate 
# TLS connections and validate client certificates. The network load balancer 
# only supports HTTP health checks which means the HTTPS endpoint exposed 
# by the API server cannot be used. As a workaround 
# the nginx webserver can be used to proxy HTTP health checks. 
# In this section nginx will be installed and configured to accept HTTP 
# health checks on port 80 and proxy the connections to the API server 
# on https://127.0.0.1:6443/healthz.

# The /healthz API server endpoint does not require authentication by default.

# Install a basic web server to handle HTTP health checks:
sudo apt-get update
sudo apt-get install -y nginx

cat > kubernetes.default.svc.cluster.local <<EOF
server {
  listen      80;
  server_name kubernetes.default.svc.cluster.local;

  location /healthz {
     proxy_pass                    https://127.0.0.1:6443/healthz;
     proxy_ssl_trusted_certificate /var/lib/kubernetes/ca.pem;
  }
}
EOF

{
  sudo mv kubernetes.default.svc.cluster.local \
    /etc/nginx/sites-available/kubernetes.default.svc.cluster.local

  sudo ln -s /etc/nginx/sites-available/kubernetes.default.svc.cluster.local /etc/nginx/sites-enabled/
}

sudo systemctl restart nginx

sudo systemctl enable nginx

# verify
curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz