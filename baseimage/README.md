Base Image Build - Ubuntu 14.04 (Trusty Tahr)
=====
This directory holds the Packer files for building a base VirtualBox image for Ubuntu 14.04.

The output of this process is a VirtualBox OVA image with the base Ubuntu 14.04 Server OS. Output is placed into the `output-virtualbox_image` directory.

To build an image, run this command from the `baseimage` directory:

     packer build ubuntu_64/ubuntu_64.json

ubuntu_64 Directory
-----
The __ubuntu_64__ directory holds the Packer configuration file and related script files needed to build the image.
* **Set** the `.vbox_version` file contents to the version of VirtualBox that will be used to build the image.
* Ubuntu ISO image is downloaded from http://releases.ubuntu.com.
* The VirtualBox Guest Additions ISO image is downloaded from http://download.virtualbox.org/virtualbox/ `version`.
* The resulting VirtualBox image is an OVA file placed in the `output-virtualbox-image` directory.

### ubuntu_64.json
This is the Packer template to build the OVA file. Key points:
* Creates a VirtualBox image called _GF-Base_.
* User and password is _gfdev/gfdev_. This user has sudo privileges that does not require a password.
* Disk size = 20GB
* VRAM = 256MB
* Memory = 2GB

### preseed.cfg
This file preseeds responses to the installer.

### root_setup.sh
This script is executed by Packer once the virtual machine is running. It performs the following steps:
* Updates and upgrades all existing software packages.
* Enables NTP and sets the time zone to Pacific Time.
* Loads packages needed to install the VirtualBox Guest Additions. Does not install guest additions.
* Loads basic packages useful for general operation.
* Configures the _gfdev_ user for no-password `sudo` access.