#!/bin/bash

set -euo pipefail

cd kubernetes-the-hard-way

# We cannot use `limactl cp` to copy files directly into `/var/lib/kubelet`
# because it uses `scp`, which runs as the default user (non-root) on the guest.
# Since `/var/lib/kubelet` is owned by root, direct copy will result in permission denied.
# To work around this, we first copy files to `/tmp` and then move them using `sudo`.
for host in node-0 node-1; do
  limactl shell ${host} -- bash -c "mkdir -p /tmp/kubelet"

  limactl cp ca.crt ${host}:/tmp/kubelet/ca.crt
  limactl cp ${host}.crt ${host}:/tmp/kubelet/kubelet.crt
  limactl cp ${host}.key ${host}:/tmp/kubelet/kubelet.key

  limactl shell ${host} -- bash -c "sudo mkdir -p /var/lib/kubelet/"
  limactl shell ${host} sudo mv /tmp/kubelet/ca.crt /var/lib/kubelet/ca.crt
  limactl shell ${host} sudo mv /tmp/kubelet/kubelet.crt /var/lib/kubelet/kubelet.crt
  limactl shell ${host} sudo mv /tmp/kubelet/kubelet.key /var/lib/kubelet/kubelet.key

  limactl shell ${host} -- bash -c "rm -rf /tmp/kubelet"
done

limactl shell server -- bash -c "mkdir -p /tmp/certs"
limactl cp \
  ca.key ca.crt \
  kube-api-server.key kube-api-server.crt \
  service-accounts.key service-accounts.crt \
  server:/tmp/certs/
limactl shell server -- bash -c "sudo mv /tmp/certs/ /certs/"
limactl shell server -- bash -c "rm -rf /tmp/certs"
