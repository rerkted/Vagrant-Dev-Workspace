# cdp_VagrantUbuntuDev

## Vagrant make file for our CDP Ubuntu dev VirtualBox VM

Pulls an instance of an Ubuntu 20.04LTS image from Vagrant Cloud, and implements some of our customizations to it.

### Usage

You'll at least need Vagrant and VirtualBox installed, and ideally 40GB of HDD space on your system.
Instructions to clone or pull this repository are avilable on Atlassian Confluence, but the short of using this machines follows these procedures:

1. Create a directory on host machine and clone repo
2. Run `vagrant init` then `vagrant up` in the directory you cloned to. Initial load takes 10-20 minutes. Username/Password is vagrant/vagrant
3. To suspend VM, use `vagrant suspend`. To shutdown, use `vagrant halt`. Use `vagrant up` to start the VM again (it will pull updates and mount shared drives). SSH into the machine using `vagrant ssh`. Destroy the VM using `vagrant destroy` to start from scratch
4. Changes are made on occasion to the Vagrant provisioning files to add or update program suite. Just `git pull` and use `vagrant up --provision` to apply new changes, this will keep your files and preferences in tact.
5. Make pull requests on Gitlab to add or request features. It's EASY!

### Packages added

* Visual Studio Code
* Terraform
* Packer
* Vault
* Sentinel CLI
* AWS-CLI
* Go 1.17
* Open Policy Agent v0.31
* Terrascan by Accurics

### Visual Studio Code extensions added

* Hashicorp Terraform
* Docker
* Kubernetes
* Packer
* Vault
* Sentinel POC
* AWS Toolkit
* Ansible
* Go Stable
* Open Policy Agent
