# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# ------------------------------------
#
# ------------------------------------
$install_pkgs = <<SCRIPT
# Update w/ latest security updates
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get install -y fail2ban
apt-get install -y unzip
chmod +u+x /opt/vagrant/zdd.sh

# Install docker
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y lxc-docker
# Uncomment to use apt docker package (might be old)
#apt-get install -y docker.io
#source /etc/bash_completion.d/docker.io

# Install docker compose
# Note: not used! This section (and corresponding docker-compose.yml file) remains for reference
#curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
#docker-compose -f /opt/vagrant/docker-compose.yml up -d

# Pull docker images
docker pull dockerfile/nodejs
docker pull dockerfile/nginx

# Build docker image
cd /opt/vagrant
CONTAINER_NAME=pklicnik/hello-node:`date +%m%d_%H%M%S`
docker build --no-cache=true -t $CONTAINER_NAME .
docker run -itPd $CONTAINER_NAME
CONTAINER_ID=`docker ps | grep "$CONTAINER_NAME" | awk '{print $1}'`
CONTAINER_PORT=`docker inspect $CONTAINER_ID | grep HostPort | cut -d '"' -f 4 | head -1`
#docker exec -it <id> bash

# Install and configure nginx
apt-get install -y nginx
rm /etc/nginx/sites-enabled/default

sed -e "s@<target>@http\:\/\/127\.0\.0\.1\:${CONTAINER_PORT}@g" /opt/vagrant/nginx-template > /etc/nginx/sites-enabled/hellonode
service nginx reload
SCRIPT

# ------------------------------------
#
# ------------------------------------
$setup_users = <<SCRIPT
newusers /opt/vagrant/users.txt
echo 'pklicnik ALL=(ALL:ALL) ALL' >> /etc/sudoers
cp .bashrc /tmp
cp .profile /tmp
chmod 777 /tmp/.*
SCRIPT

# ------------------------------------
#
# ------------------------------------
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '/Users/pklicnik/Shovebox/VagrantFile-PK/keys/do'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.token = '<APIkey>'
    provider.image = 'ubuntu-14-10-x64'
    provider.region = 'nyc3'
    provider.size = '512mb'
  end

  config.vm.define :pklabs do |pklabs_config|
    config.vm.provision "shell", inline: $install_pkgs
    config.vm.provision "shell", inline: $setup_users
    config.vm.hostname = "pklabs"
    config.vm.synced_folder "vagrant/", "/opt/vagrant"
  end

end
