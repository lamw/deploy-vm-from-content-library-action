#!/bin/bash

export GOVC_URL=${GOVC_URL}
export GOVC_USERNAME=${GOVC_USERNAME}
export GOVC_PASSWORD=${GOVC_PASSWORD}

if [ -z ${GOVC_INSECURE} ]; then
    GOVC_INSECURE=True
else
    export GOVC_INSECURE=${GOVC_INSECURE}
fi

export GOVC_DATACENTER=${GOVC_DATACENTER}
export GOVC_NETWORK=${GOVC_NETWORK}
export GOVC_DATASTORE=${GOVC_DATASTORE}
export GOVC_FOLDER=${GOVC_FOLDER}

if [ ! -z ${GOVC_CLUSTER} ]; then
    export GOVC_CLUSTER=${GOVC_CLUSTER}
elif [ ! -z ${GOVC_RESOURCE_POOL} ]; then
    export GOVC_RESOURCE_POOL=${GOVC_RESOURCE_POOL}
else
    echo "GOVC_CLUSTER or GOVC_RESOURCE_POOL variable must be defined ..."
    exit 1
fi

export VM_NAME=${VM_NAME}
export LIBRARY_NAME=${LIBRARY_NAME}
export LIBRARY_TEMPLATE=${LIBRARY_TEMPLATE}

govc about > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Unable to login to vCenter Server ..."
    exit 1
fi

echo "Deploying new VM ${VM_NAME} from ${LIBRARY_NAME} Content Library ..."
govc vcenter.deploy "${LIBRARY_NAME}" "${LIBRARY_TEMPLATE}" "${VM_NAME}"

echo "Powering on ${VM_NAME} ..."
govc vm.power -on=true "${VM_NAME}"
