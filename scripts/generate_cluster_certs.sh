#!/usr/bin/env bash


curl https://repository.cloudifysource.org/cloudify/6.2.0/ga-release/cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm -o cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm
sudo yum install -y cloudify-manager-install-6.2.0-ga.el7.x86_64.rpm

hostname1=`hostname`
ip2_string=`echo ${VM2_IP_PRIVATE} | sed 's/\./-/g'`
ip3_string=`echo ${VM3_IP_PRIVATE} | sed 's/\./-/g'`
hostname2="ip-${ip2_string}.${REGION}.compute.internal"
hostname3="ip-${ip3_string}.${REGION}.compute.internal"

sudo cfy_manager generate-test-cert -s ${VM1_IP_PUBLIC},${hostname1}
sudo cfy_manager generate-test-cert -s ${VM2_IP_PUBLIC},${hostname2}
sudo cfy_manager generate-test-cert -s ${VM3_IP_PUBLIC},${hostname3}

sudo mv /root/.cloudify-test-ca /home/centos/
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM1_IP_PUBLIC}.crt
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM1_IP_PUBLIC}.key
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM2_IP_PUBLIC}.crt
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM2_IP_PUBLIC}.key
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM3_IP_PUBLIC}.crt
sudo chmod 444 /home/centos/.cloudify-test-ca/${VM3_IP_PUBLIC}.key
sudo chmod 444 /home/centos/.cloudify-test-ca/ca.crt
sudo chmod 444 /home/centos/.cloudify-test-ca/ca.key
sudo chown cfyuser /home/centos/.cloudify-test-ca/ca.crt
sudo chown cfyuser /home/centos/.cloudify-test-ca/ca.key

ca=`cat /home/centos/.cloudify-test-ca/ca.crt`
vm2_crt=`cat /home/centos/.cloudify-test-ca/${VM2_IP_PUBLIC}.crt`
vm2_key=`cat /home/centos/.cloudify-test-ca/${VM2_IP_PUBLIC}.key`
vm3_crt=`cat /home/centos/.cloudify-test-ca/${VM3_IP_PUBLIC}.crt`
vm3_key=`cat /home/centos/.cloudify-test-ca/${VM3_IP_PUBLIC}.key`

ca_output="'$ca'"
vm2_crt_output="'$vm2_crt'"
vm2_key_output="'$vm2_key'"
vm3_crt_output="'$vm3_crt'"
vm3_key_output="'$vm3_key'"

ctx instance runtime-properties ca "$ca_output"
ctx instance runtime-properties vm2.crt "$vm2_crt_output"
ctx instance runtime-properties vm2.key "$vm2_key_output"
ctx instance runtime-properties vm3.crt "$vm3_crt_output"
ctx instance runtime-properties vm3.key "$vm3_key_output"
