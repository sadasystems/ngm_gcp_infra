
# Terraform Component

OpenVpn

## Description

This component provisions a single Google compute instance with openvpn server already configured and ready for use. 

The compute instance is created from a special Hashicorp Packer-maintained compute image.  See:  Packer/OpenVpn for details on the Packer configuration.  If this infrastructure is being setup for the first time, you will likely have to create the image using Packer.  For example:

From Packer/OpenVpn directory:

```bash
packer build template.json
```

If you have the image already generated, you can execute Terragrunt to build the OpenVpn server.  It will setup a public IP for the host to be accessible from outside the GCP network.

### First time setup and login

In order to gain access via the VPN connection for the first time, you must login to the server to obtain the default client certificate located in the /root directory.  It will have a .ovpn file extension.  Copy that file down to your local computer and install it into an openvpn client such as Tunnelblick or PriTunl.

### Creating additional client certificates.

Login to the openvpn server.  Run `openvpn-install.sh`  Follow the interactive menu to generate a new signed client certificate.  Once it's created, download it or copy it to submit to the requesting user.

---
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
