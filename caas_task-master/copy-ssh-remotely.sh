USER=ec2-user; while read HOST; do ssh-copy-id "$USER@$HOST"; done < ~/hosts_inventory
