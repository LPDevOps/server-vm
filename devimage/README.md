General Forensics Development Image Build
=====
This directory holds the Packer files for building a development virtual machine VirtualBox image for Ubuntu 14.04.

The output of this process is a VirtualBox OVA image. Output is placed into the `output-virtualbox_image` directory. The image has the following configuration:
* LAMP stack
  * Linux Ubuntu 14.04 (Trusty Tahr)
  * Apache 2.4
  * MySQL 5.6
  * PHP 5.5
* Development Tools
  * git
  * PHP Xdebug
  * Java OpenJDK
* Desktop Build Script to install:
  * Lubuntu
  * VirtualBox Guest Additions
  * MySQL Workbench
  * Eclipse
  * NetBeans

To build an image, run this command from the `devimage` directory:

     packer build ubuntu_dev/ubuntu_dev.json

ubuntu_dev Directory
-----
The `ubuntu_dev` directory holds the Packer configuration file and related script files needed to build the image.
* The basic LAMP stack software and development tools are installed on the image.
* The desktop and GUI tools are **not** installed as this makes for a very large image file. Instead, a script is provided for the user to execute.
* The resulting VirtualBox image is an OVA file placed in the `output-virtualbox-image` directory.

### ubuntu_dev.json
This is the Packer template to build the OVA file. Key points:
* Creates a VirtualBox image called _GF-Dev_.
* Uses the _GF-Base_ image as the starting point. The _GF-Base_ image **must** be in `../baseimage/output_virtualbox-image/GF-Base.ova`.
* User and password is _gfdev/gfdev_. This user has sudo privileges that does not require a password.

### dev_setup.sh
This script is run by Packer and installs the development tools.

### desktop_setup.sh
This script is uploaded by Packer to the _gfdev_ user's home directory. It performs the following steps:
* Installs the Lubuntu desktop.
* Installs the vncserver and sets it up for remote access.
* Installs the desktop development tools: MySQL Workbench, Eclipse, and NetBeans.

To install the desktop and tools, log into the system as _gfdev_ and run this command:

     bash desktop_setup.sh
    