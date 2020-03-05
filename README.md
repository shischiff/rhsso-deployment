# rhsso-deployment

Automation of a RHSSO domain clustered server (master/slave) with postgresql db  

## Usage:
    ansible-playbook -i hosts --become -u root playbook.yml
    
## Prerequisites

1. 3 RHEL7 VMs, network is configured and accessible from ansible host
1. subscription-manager is registered with a pool attached (currently required for Java installation)
1. ssh-copy-id from ansible host to root on all 3 vms

## hosts file (inventory)

create hosts file following this template:

    [rhsso]
    10.0.0.1 hostMaster=True     # this is the maste host
    10.0.0.2                     # this is the slave host
    
    [pgsql]
    10.0.0.3                     # postgresql
    
    [pgsql:vars]
    ansible_python_interpreter=/usr/bin/python3
    

## Configuration files

### rh-sso role

Edit vars/main.yml for postgrsql password and for package URL

### ansible-role-postgresql

Edit defaults/main.yml for postgresql password  
