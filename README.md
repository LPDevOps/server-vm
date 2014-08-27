Virtual Machine Image Build
=====
This directory holds the files for building virtual machine (VM) images. The build process uses Packer (http://packer.io) to manage the build process and is augmented with various shell scripts. See the README.md files in each directory for details.

Overview
-----
* There is a base image for each supported OS.
* Each VM variant is built from the base image.
* The output VM images are copied to a publicly available location for users to download.

baseimage
-----
The `baseimage` directory builds the base images for VMs.

devimage
-----
The `devimage` directory builds images appropriate for use by developers.