#!/bin/bash -x

function debug {
    if [[ "$DEBUG_LOG" == "1" ]]; then echo "DEBUG: $1";fi
}

function info {
    echo "INFO: $1"
}

function install_terraform_kvm_plugin {
    PLUGIN_TAR=terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
    debug "Downloading $PLUGIN_TAR..."
    curl -LO https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/${PLUGIN_TAR}
    TF_PLG_DIR=${HOME}/.terraform.d/plugins/
    debug "Creating $TF_PLG_DIR..."
    mkdir -P $TF_PLG_DIR
    debug "Extracting $PLUGIN_TAR to $TF_PLG_DIR..."
    tar -xvzf ${PLUGIN_TAR} $TF_PLG_DIR
    debug "Installing genisoimage..."
    apt install libvirt-clients genisoimage -y
}

info "Installing KVM plugin..."
install_terraform_kvm_plugin