#!/bin/bash
export new_ip=$(vagrant ssh -c "ip address show eth0 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//'")
export new_ip2=`echo "$new_ip" | tr -cd '[[:digit:].-]'`

export OPTIONS="-o Compression=yes -o DSAAuthentication=yes -o LogLevel=FATAL -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes"

echo IP Address: $new_ip2

#ssh-keygen -f "/home/kleechneek/.ssh/known_hosts" -R "$new_ip2"

ssh $OPTIONS "pklicnik@$new_ip2"