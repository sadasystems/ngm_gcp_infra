# Packer

## Hashicorp Packer

What is Hashicorp Packer?  http://www.packer.io 

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.

Packer is easy to use and automates the creation of any type of machine image. It embraces modern configuration management by encouraging you to use a framework such as Chef or Puppet to install and configure the software within your Packer-made images.

## Advantages of Using Packer

*_Super fast infrastructure deployment_*. Packer images allow you to launch completely provisioned and configured machines in seconds, rather than several minutes or hours. This benefits not only production, but development as well, since development virtual machines can also be launched in seconds, without waiting for a typically much longer provisioning time.

*_Multi-provider portability._* Because Packer creates identical images for multiple platforms, you can run production in AWS, staging/QA in a private cloud like OpenStack, and development in desktop virtualization solutions such as VMware or VirtualBox. Each environment is running an identical machine image, giving ultimate portability.

*_Improved stability._* Packer installs and configures all the software for a machine at the time the image is built. If there are bugs in these scripts, they'll be caught early, rather than several minutes after a machine is launched.

*_Greater testability._* After a machine image is built, that machine image can be quickly launched and smoke tested to verify that things appear to be working. If they are, you can be confident that any other machines launched from that image will function properly.

Packer makes it extremely easy to take advantage of all these benefits.

## Packer files for AgilOne

Packer files were created with AgilOne use-case in-mind.  There are two main packer configurations.

1. BaseImage - The base-image is used for creating a copy of the base Ubuntu image provided in GCP (see template.json file for version).  Once the image is created and stored in GCP, it can be the "source image" for almost all of the compute instances provisioned in this code.  *The Benefit:* - You can customize OS configuration, harden the OS, and install apps that you may want globally-available.

2. OpenVpn - This packer configuration is used for creating a custom image in GCP, and subsequently used by the `Terrafrom/OpenVpn` component which contains an openvpn installation script.  The script will be ran on first boot of a provisioned compute instance using this generated image.

## Running Packer

To execute a packer build, ensure you have the Packer Go binary installed.  Then traverse into the subdirectory containing the Packer `template.json` that you wish to build an image for.

Execution example:
```bash
cd BaseImage/
packer build template.json
```
