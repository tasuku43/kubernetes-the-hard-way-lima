#!/bin/bash

set -euo pipefail

cd kubernetes-the-hard-way

for host in node-0 node-1; do
  ssh -o StrictHostKeyChecking=no root@${host} "mkdir -p /var/lib/kubelet/"
  scp -o StrictHostKeyChecking=no ca.crt root@${host}:/var/lib/kubelet/ca.crt
  scp -o StrictHostKeyChecking=no ${host}.crt root@${host}:/var/lib/kubelet/kubelet.crt
  scp -o StrictHostKeyChecking=no ${host}.key root@${host}:/var/lib/kubelet/kubelet.key
done

scp -o StrictHostKeyChecking=no \
  ca.key ca.crt \
  kube-api-server.key kube-api-server.crt \
  service-accounts.key service-accounts.crt \
  root@server:~
