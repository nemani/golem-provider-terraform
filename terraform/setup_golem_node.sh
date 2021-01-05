#!/bin/bash -i

start=$(date +%s)

cd ~
echo "Running as user" $(whoami)

if ! grep -q 'ssh-add' ~/.bashrc; then
cat << 'EOT' >> ~/.bashrc
alias taillog="tail -f /var/log/syslog | egrep 'cloud-init|startup-script'"
alias catlog="cat /var/log/syslog | egrep 'cloud-init|startup-script'"
export RUN_PROM=${RUN_PROM}
export PROM_IP=${PROM_IP}
export HOSTNAME=${HOSTNAME}
export wallet_address=${wallet_address}
EOT
fi

sudo apt update && sudo apt -y install make git zip unzip

git clone https://github.com/nemani/golem-provider-terraform
cd ./golem-provider-terraform

rm .env

cat << 'EOT' >> .env
YAGNA_METRICS_URL=http://${PROM_IP}:9091/
wallet_address=${wallet_address}
HOSTNAME=${HOSTNAME}
EOT

make deps

docker-compose up -d prometheus pushgateway

make golem-setup
docker-compose up -d node

echo "ALL DONE!"
end=$(date +%s)
echo $((end-start))
echo $(uptime)
