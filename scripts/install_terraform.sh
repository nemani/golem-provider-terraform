#!/bin/bash

function terraform-install() {
  [[ -f ${HOME}/bin/terraform ]] && echo "`${HOME}/bin/terraform version` already installed at ${HOME}/bin/terraform" && return 0
  
  LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta' | egrep 'linux.*amd64' |tail -1)
  
  curl ${LATEST_URL} > /tmp/terraform.zip
  mkdir -p ${HOME}/bin
  (cd ${HOME}/bin && unzip /tmp/terraform.zip)
  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi
  
  echo "Installed: `${HOME}/bin/terraform version`"
  
}


function terragrunt-install() {
  [[ -f ${HOME}/bin/terragrunt ]] && echo "Terragrunt `${HOME}/bin/terragrunt | grep -iA 2 version | tr -d '\n'` already installed at ${HOME}/bin/terragrunt" && return 0
  
  LATEST_URL=$(curl -sL  https://api.github.com/repos/gruntwork-io/terragrunt/releases  | jq -r '.[0].assets[].browser_download_url' | egrep 'linux.*amd64' | tail -1)
  mkdir -p ${HOME}/bin
  curl -sL ${LATEST_URL} > ${HOME}/bin/terragrunt
  chmod +x ${HOME}/bin/terragrunt

  if [[ -z $(grep 'export PATH=${HOME}/bin:${PATH}' ~/.bashrc) ]]; then
  	echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
  fi
  
  echo "Installed: Terragrunt `${HOME}/bin/terragrunt | grep -iA 2 version | tr -d '\n'`"
}

terraform-install
terragrunt-install

cat - << EOF 

Run the following to reload your PATH with terraform and terragrunt:
  source ~/.bashrc
EOF