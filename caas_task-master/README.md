Problem:- Given a cluster of 100 servers, write automation to install your SSH key on all of them. Use a tool and approach of your choice. We can achieve it using shell script as well as ansible playbook.

shell script:- USER=ec2-user; while read HOST; do ssh-copy-id "$USER@$HOST"; done < ~/hosts_inventory we have to create hosts_inventory file and add server names. execute this command.
2:- By using ansible playbook push_ssh_keys_remote.yml
hosts: targets gather_facts: false vars: ssh_key: '/home/ec2-user/.ssh' tasks:
name: copy ssh key authorized_key: key: "{{ lookup('file', ssh_key) }}" user: root
########Inventory Hosts file####### ##This file has 100 servers host entries which will start from 10.1.0.1 to 10.1.0.100 [targets] 10.1.0:[1:100]

Command to execute:- ansible-playbook -i /etc/ansible/hosts push_ssh_keys_remote.yml--extra-vars='pubkey="~/.ssh/authorized_keys"' Here we are passing variable value for public key to the playbook. ⦁	Since ansible uses ssh to access to each of the remote hosts, before we execute a playbook, we need to put the public key to the ~/.ssh/authorized_keys so that you don’t need to input the password for ssh every time you execute the playbook. ⦁ disable SSH authenticity checking by adding an /etc/ansible/ansible.cfg to the place where you want to execute the playbook: host_key_checking = False This will deploy our public key to all the remote hosts.

Assuming we have 100 nodes, if we execute it in 100 servers automatically it will deploy the key on all nodes. I tested for 3 servers.
