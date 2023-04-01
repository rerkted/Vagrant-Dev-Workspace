# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "felipecrs/dev-ubuntu"
  if Vagrant.has_plugin?("vagrant-vbguest") then
	config.vbguest.auto_update = true
end
	
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
  vb.gui = true
  # Sets Virtual Machine Name
  vb.name = "CDP Development Ubuntu August 2021"
  # Customize the amount of memory on the VM:
  vb.memory = "4096"
  # Customize the amount of video RAM on the VM:
  vb.customize ["modifyvm", :id, "--vram", "128"]
  # Enable bi-directional clipboard for this VM
  vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
  # Sets graphics controller to VMSVGA, the recommended controller for Linux VM Guests
  vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
config.vm.provision "shell", run: "once", inline: <<-SHELL
  # Create a swapfile, because for some reason this VM doesn't have one already
  dd if=/dev/zero of=/swapfile bs=1M count=4096
  chmod 0600 /swapfile # For, um... Security purposes
  mkswap /swapfile
  swapon /swapfile
  # Swap is now created, now add to fstab so that swap mounts and run on every boot
  echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
   
  # Add Hashicorp repo
  curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
  apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  # Pull from repos updated package lists
  apt-get update
  
  # Adds and modifies bash completion
  echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc
    
  # Installs Terraform, Packer, and Vault
  apt install terraform -y
  apt-get install packer -y
  apt-get install vault -y

  # Installs the AWS CLI
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm awscliv2.zip # Clears out the downloaded installer zip file 

  # Installs Go compliler/interpreter v1.17
  curl -L "https://golang.org/dl/go1.17.linux-amd64.tar.gz" -o "golang1-17.tar.gz"
  tar -C /usr/local -xzf golang1-17.tar.gz
  export PATH=$PATH:/usr/local/go/bin # Adds golang to PATH
  rm golang1-17.tar.gz # Removes the downloaded tarball for golang

  # Installs Open Policy Agent OPA v0.31.0
  mkdir /usr/local/opa
  curl -L https://openpolicyagent.org/downloads/v0.31.0/opa_linux_amd64_static -o /usr/local/opa/opa
  chmod 775 /usr/local/opa/opa # Make OPA executable
  export PATH=$PATH:/usr/local/opa # Adds OPA to PATH

  # Installs Terrascan by Accurics
  curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz
  tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz
  install terrascan /usr/local/bin && rm terrascan

  # Adds VS Code Extensions that we commonly use via startup bash script
  # Extensions require a run AND shutdown of VSCode at least once before they're installed
  cp /vagrant/vscode_provision.sh /
  chmod 777 /vscode_provision.sh # Deal with it, this isn't supposed to be a secure machine
  cp /vagrant/vscode_provision.service /etc/systemd/system/
  systemctl daemon-reload
  systemctl enable vscode_provision
  service vscode_provision start

  # Installs Hashicorp Sentinel CLI
  sudo unzip /vagrant/sentinel_0.18.4_linux_amd64.zip -d /usr/local/bin/

  # Purge some not-needed applications from VM
  apt-get purge google-chrome-stable -y
  apt-get purge thunderbird -y
  snap remove postman
  apt-get purge remmina -y
  apt-get purge rhythmbox -y

  # Roll-up some security updates
  apt-get upgrade -y
  SHELL

# Always run an online software update when running 'vagrant up'
config.vm.provision "shell", run: "always", inline: <<-SHELL
  apt-get update
  apt-get upgrade -y
  apt autoremove -y
  SHELL
end
