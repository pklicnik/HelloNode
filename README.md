##### IDS Build & deploy instructions:
Select Grunt for the builder
Use defaults for everything else in builder and deployer

##### Vagrant/Docker ZDD environment
The Vagrantfile is set up to DigitialOcean provider. Some setup required:

1. In Vagrantfile
  * Enter a API token: provider.token = '<APIkey>'
  * Enter private key path: override.ssh.private_key_path = '/Users/pklicnik/Shovebox/VagrantFile-PK/keys/do'
  * Generate a key pair using: ssh-keygen -t rsa
2. In vagrant/users.txt, update <password>
  * pklicnik:<password>:::pklicnik:/home/pklicnik:/bin/bash 
  * (Vagrantfile creates a non-root user using the above)
