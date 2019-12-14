# Github Action for Deploying a Virtual Machine from a vSphere Content Library

## Description

This Docker Container uses [govc](https://github.com/vmware/govmomi/tree/master/govc) to login to vCenter Server and deploys a new Virtual Machine from a vSphere Content Library.

## Usage

```
workflow "Deploy WebApp VM" {
  resolves = ["docker://lamw/create-vsphere-tag"]
  on = "push"
}

action "docker://lamw/create-vsphere-tag" {
  uses = "docker://lamw/deploy-vm-from-content-library"
  secrets = ["GOVC_PASSWORD"]
  env = {
    GOVC_URL = "https://<vcenter>/sdk"
    GOVC_USERNAME = "cloudadmin@vmc.local"
    GOVC_DATACENTER = "SDDC-Datacenter"
    GOVC_NETWORK = "sddc-cgw-network-1"
    GOVC_DATASTORE = "WorkloadDatastore"
    GOVC_FOLDER = "Workloads"
    GOVC_RESOURCE_POOL = "Compute-ResourcePool"
    LIBRARY_NAME = "Customer[0]"
    LIBRARY_TEMPLATE = "WebApp-Template"
    VM_NAME = "Validate-WebApp-00"
  }
}
```

## Secrets

| Variable      | Definition              |
|---------------|-------------------------|
| GOVC_PASSWORD | vCenter Server Password |

## Environmental Variables

| Variable           | Definition                                                 |
|--------------------|------------------------------------------------------------|
| GOVC_URL           | vCenter Server URL                                         |
| GOVC_USERNAME      | vCenter Server Username                                    |
| GOVC_INSECURE      | Enable or disable Certificate verification                 |
| GOVC_DATACENTER    | vSphere Datacenter to deploy new VM                        |
| GOVC_NETWORK       | vSphere Network to deploy new VM                           |
| GOVC_DATASTORE     | vSphere Datastore to deploy new VM                         |
| GOVC_FOLDER        | vSphere Folder to deploy new VM (required for VMC)         |
| GOVC_CLUSTER       | vSphere Cluster to deploy new VM                           |
| GOVC_RESOURCE_POOL | vSphere Resource Pool to deploy new VM (required for VMC)   |
| VM_NAME            | Name of new VM to deploy                                   |
| LIBRARY_NAME       | Name of vSphere Content Library to deploy from             |
| LIBRARY_TEMPLATE   | Name of vSphere Content Library VM Template to deploy from |

## Testing

To ensure the Docker Container will run successfully, you can test locally by building/running the container and then specifying the input using the `--env-file` and the name of the file.

Step 1 - Create a file which contains the following variables along with the values from your vSphere environment:

```
GOVC_URL=https://<vcenter>/sdk
GOVC_USERNAME=
GOVC_PASSWORD=
GOVC_DATACENTER=SDDC-Datacenter
GOVC_NETWORK=sddc-cgw-network-1
GOVC_DATASTORE=WorkloadDatastore
GOVC_FOLDER=Workloads
GOVC_RESOURCE_POOL=Compute-ResourcePool
LIBRARY_NAME=Customer[0]
LIBRARY_TEMPLATE=WebApp-Template
VM_NAME=Validate-WebApp-00
```

Step 2 - Run the Container

```
docker run --rm -it --env-file myEnvFile lamw/deploy-vm-from-content-library
```

If the operation was successful, you should see a message like the following:
```
Deploying new VM Validate-WebApp-00 from Customer[0] Content Library ...
Using datastore ID datastore-62
Using pool ID resgroup-61
Using folder ID group-v58
Found OVA for deployment: PhotonOS-Template
Deploy succeeded: vm-174
Powering on Validate-WebApp-00 ...
Powering on VirtualMachine:vm-174... OK
```

If you head over to your vSphere environment, you should a new VM that has been deployed from your specified vSphere Content Library and VM Template.

## License

The Dockerfile and associated scripts and documentation in this project are released under the MIT License.
