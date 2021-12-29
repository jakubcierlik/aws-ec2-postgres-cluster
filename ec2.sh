cfy ex start -d ec2 -p ignore_failure=true uninstall
cfy dep del ec2
cfy bl del --force ec2
cfy bl upl -b ec2 ec2.yaml
cfy dep cr -b ec2 ec2
cfy ex start -d ec2 install
