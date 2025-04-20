#!/bin/bash

set -euo pipefail

apt-get update && apt-get -y install wget curl vim openssl git tree

# すでに kubernetes-the-hard-way がある場合は、clone しない
if [ ! -d "kubernetes-the-hard-way" ]; then
    git clone --depth 1 https://github.com/kelseyhightower/kubernetes-the-hard-way.git
fi
cd kubernetes-the-hard-way

wget -q --show-progress \
    --https-only \
    --timestamping \
    -P downloads \
    -i downloads-$(dpkg --print-architecture).txt

ls -oh downloads

ARCH=$(dpkg --print-architecture)
mkdir -p downloads/{client,cni-plugins,controller,worker}
tar -xvf downloads/crictl-v1.32.0-linux-${ARCH}.tar.gz \
    -C downloads/worker/
tar -xvf downloads/containerd-2.1.0-beta.0-linux-${ARCH}.tar.gz \
    --strip-components 1 \
    -C downloads/worker/
tar -xvf downloads/cni-plugins-linux-${ARCH}-v1.6.2.tgz \
    -C downloads/cni-plugins/
tar -xvf downloads/etcd-v3.6.0-rc.3-linux-${ARCH}.tar.gz \
    -C downloads/ \
    --strip-components 1 \
    etcd-v3.6.0-rc.3-linux-${ARCH}/etcdctl \
    etcd-v3.6.0-rc.3-linux-${ARCH}/etcd
mv downloads/{etcdctl,kubectl} downloads/client/
mv downloads/{etcd,kube-apiserver,kube-controller-manager,kube-scheduler} \
    downloads/controller/
mv downloads/{kubelet,kube-proxy} downloads/worker/
mv downloads/runc.${ARCH} downloads/worker/runc

rm -rf downloads/*gz

chmod +x downloads/{client,cni-plugins,controller,worker}/*

cp downloads/client/kubectl /usr/local/bin/

kubectl version --client
