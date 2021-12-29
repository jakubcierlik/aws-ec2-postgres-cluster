#!/usr/bin/env bash


curl https://repository.cloudifysource.org/cloudify/6.2.0/ga-release/cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm -o cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm
sudo yum install -y cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm

mkdir -p /home/centos/.cloudify-test-ca
echo "${CA}" > /home/centos/.cloudify-test-ca/ca.crt
echo "${CRT}" > /home/centos/.cloudify-test-ca/${VM_IP_PUBLIC}.crt
echo "${KEY}" > /home/centos/.cloudify-test-ca/${VM_IP_PUBLIC}.key
chmod 400 /home/centos/.cloudify-test-ca/ca.crt
chmod 400 /home/centos/.cloudify-test-ca/${VM_IP_PUBLIC}.crt
chmod 400 /home/centos/.cloudify-test-ca/${VM_IP_PUBLIC}.key
