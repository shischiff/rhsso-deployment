# rhsso-deployment

Automation of a RHSSO domain clustered server (master/slave). 

## Usage:
    ansible-playbook -i hosts --become -u root playbook.yml
    
## Prerequisites

1. 1 Bastion VM with ansible 2.8.3 or higher installed
1. 2 RHEL7 VMs, network is configured and the hosts are accessible from ansible host
1. Password-less access from the bastion machine to the 2 VMs
1. The following files are required (have them available on the bastion machine):
    1. installation file: rh-sso.zip
    1. postgresql JDBC driver file
    1. Your organization's CA-bundle file
    1. Your organization's private key file
    1. Your organization's certificate file


# Configuration

Edit the following files:

## hosts file (inventory)

File location: project's main directory (rhsso-deployment/hosts).
Edit hosts file using the following template, *change only the IPs and the location of the ssh private keys*, the rest should remain as is:

    [rhsso-master]
    10.0.0.1 hostName=rhsso-master hostMaster=True ansible_ssh_private_key_file=~/.ssh/key1.pem
    
    [rhsso-slave]
    10.0.0.2 hostName=rhsso-slave ansible_ssh_private_key_file=~/.ssh/key2.pem
    
    [pgsql]
    10.0.0.3
    
    [rhsso:children]
    rhsso-master
    rhsso-slave
    
## rhsso-role

File location: rhsso-deployment/rhsso-role/vars/main.yml 
Edit the file, make sure you provide accurate details:

### ZIP and JDBC parameters

Provide the file names for the rhsso.zip and the jdbc files.
Next, configure 'rhsso_source' whether the files are available on the bastion (i.e. 'file') or on a web server (i.e 'url') 
finally according to source configuration provide the location of the files (either the path to the files or the web url address)

### Postgresql parmaters

Provide the DB connection parameters

### keystore parameters

Provide the parameters for keystore creation.
base_dir - where the files are located on the bastion.
Next, provide the exact file names for CA-bundle, certificate and private key.
Provide the password required to open the private key.
Next, provide the passwords you wish to create for the p12 and jks files
Finally provide the DNS name to be used for the keystore creation.

### RHSSO user login information

Provide the user and password to be created for accessing the management portal of the SSO 

# Optional: Advanced configuration 

## rhsso-role
Some advanced configurations are available under rhsso-deployment/rhsso-role/defaults/main.yml use with caution.

## postgresql-role

It is possible to use the playbook to delpoy also a postgresql instance (lab and tests only, not production ready!)
Make sure to provide and IP in the hosts file, and uncomment the postgres section in playbook.yml 
run the playbook as normal

configuration file is under rhsso-deployment/postgresql-role/vars/main.yml
