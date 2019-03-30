#!/bin/bash
# Need to build govc from source as support for vSphere Content Library isn't official yet

PATH=$PATH:/usr/local/go/bin
GOPATH=/root/go

curl -O https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
tar xvf go1.12.1.linux-amd64.tar.gz -C /usr/local
rm -f /root/go1.12.1.linux-amd64.tar.gz

mkdir -p /root/go
go get -u github.com/vmware/govmomi/govc
cd /root/go/src/github.com/vmware/govmomi/govc
go build
cp /root/go/src/github.com/vmware/govmomi/govc/govc /usr/local/bin
