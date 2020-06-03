build_number            = "${BUILD_NUMBER}"

# Access inforation for vSphere cluster
vsphere_server          = "vcenter.example.com"
vsphere_user            = "administrator"
vsphere_password        = "${VSPHERE_PASSWORD}"

# Resource information on vSphere
vsphere_datacenter      = "GTFO"
vsphere_datastore       = "devops-001-a"
vsphere_compute_cluster = "Devops"
vsphere_network         = "Engineering Network"

# Option for creating VM
## Clone from template
clone_template          = "${CLONE_TEMPLATE}"
vsphere_template        = "${TEMPLATE_NAME}"

# From local OVF file
local_ovf               = "${LOCAL_OVF}"
local_ovf_path          = "${LOCAL_OVF_PATH}"

# From remote OVF file
remote_ovf              = "${REMOTE_OVF}"
remote_ovf_url          = "${REMOTE_OVF_URL}"

# Configuration for VM
vm_name                 = "${VM_NAME}"
vm_password             = "${VM_PASSWORD}"
vm_number               = 2
vm_cpus                 = 2
vm_memory               = 4096
vm_disk                 = "400"