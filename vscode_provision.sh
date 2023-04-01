#!/bin/bash

echo "Now provisioning VS Code with extensions"

code --install-extension hashicorp.terraform
code --install-extension hashicorp.sentinel
code --install-extension 4ops.packer
code --install-extension owenfarrell.vscode-vault
code --install-extension gitlab.gitlab-workflow
code --install-extension ms-azuretools.vscode-azureterraform
code --install-extension ms-azuretools.vscode-docker
code --install-extension microsoft.kubernetes
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension tomaciazek.ansible
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension golang.go
code --install-extension ms-python.python
code --install-extension tsandall.opa
code --install-extension DavidAnson.vscode-markdownlint

echo -e "Provisioning complete! Now I must go... \nMy planet needs me."
# rm $0 #removes this bash script