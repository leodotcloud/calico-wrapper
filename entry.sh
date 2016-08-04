#!/bin/sh

if [ ! -z ${RANCHER_DEBUG} ]; then
    set -x
fi

SRC_DIR=/opt/calico
CNI_CONFIG_FILE_NAME=10-calico.conf

CNI_CONFIG_DIRECTORY=/opt/rancher/cni

if [ ! -d "${CNI_CONFIG_DIRECTORY}" ]; then
    echo "Error: Couldn't find ${CNI_CONFIG_DIRECTORY}, this should have been available from 'volumes_from'"
    exit 1
fi

# Remove any existing config files
rm -f ${CNI_CONFIG_DIRECTORY}/*.conf

# Copy the CNI config file
cp ${SRC_DIR}/${CNI_CONFIG_FILE_NAME} ${CNI_CONFIG_DIRECTORY}/${CNI_CONFIG_FILE_NAME}
if [ $? -ne 0 ]; then
    echo "Error: Couldn't copy the config file to ${CNI_CONFIG_DIRECTORY}"
    exit 1
fi

echo "Going into hibernation"
sleep infinity
