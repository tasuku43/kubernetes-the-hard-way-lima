#!/bin/bash
set -euo pipefail

read -p "Is it okay to run apt-get update + install?"
apt-get update && apt-get -y install wget curl vim openssl git tree

read -p "Is it okay to clone kubernetes-the-hard-way?"
git clone --depth 1 https://github.com/kelseyhightower/kubernetes-the-hard-way.git
cd kubernetes-the-hard-way

read -p "Is it okay to fetch binaries with wget?"
wget -q --show-progress \
    --https-only \
    --timestamping \
    -P downloads \
    -i downloads-$(dpkg --print-architecture).txt

read -p "Run ls on downloads?"
ls -oh downloads

ARCH=$(dpkg --print-architecture)
read -p "Is it okay to create directories and extract archives?"
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
read -p "Is it okay to move the binaries to their respective directories?"
mv downloads/{etcdctl,kubectl} downloads/client/
mv downloads/{etcd,kube-apiserver,kube-controller-manager,kube-scheduler} \
    downloads/controller/
mv downloads/{kubelet,kube-proxy} downloads/worker/
mv downloads/runc.${ARCH} downloads/worker/runc

read -p "Is it okay to clean up the downloaded archives?"
rm -rf downloads/*gz

read -p "Is it okay to make the binaries executable?"
chmod +x downloads/{client,cni-plugins,controller,worker}/*

read -p "Is it okay to copy kubectl to /usr/local/bin/?"
cp downloads/client/kubectl /usr/local/bin/

read -p "Is it okay to verify the kubectl version?"
kubectl version --client