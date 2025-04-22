#!/bin/bash

set -euo pipefail

cd kubernetes-the-hard-way

# Note: Following the original approach in "Kubernetes the Hard Way", 
# we continue to create a separate kubeconfig file for each component.
# However, to avoid permission errors caused by file locking (e.g., config.lock)
# when writing to host-mounted directories under Lima, we changed the output
# directory for the kubeconfig files to a location outside the host-mounted path.
# This ensures compatibility with Lima's mount behavior while preserving
# the per-component configuration file structure.
KUBECONFIG_DIR=${HOME}/.kube

for node in node-0 node-1; do
  echo "Distributing kubeconfig files to ${node}..."
  ssh -o StrictHostKeyChecking=no root@${node} "mkdir -p /var/lib/kubelet/"
  scp -o StrictHostKeyChecking=no ${KUBECONFIG_DIR}/kube-proxy.kubeconfig ${node}:/var/lib/kube-proxy/kubeconfig
  scp -o StrictHostKeyChecking=no ${KUBECONFIG_DIR}/${node}.kubeconfig ${node}:/var/lib/kubelet/kubeconfig
done

echo "Distributing kubeconfig files to server..."
scp -o StrictHostKeyChecking=no \
  ${KUBECONFIG_DIR}/admin.kubeconfig \
  ${KUBECONFIG_DIR}/kube-controller-manager.kubeconfig \
  ${KUBECONFIG_DIR}/kube-scheduler.kubeconfig \
  root@server:~/