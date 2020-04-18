# Offensive Security Engineering Udemy
Various course materials, scripts, and configurations from my Offensive Security Engineering Course on Udemy


For all Terraform projects you will need to generate a PEM file to ssh into your servers. You can call it whatever you would like, but be sure to change the name in the Terraform configuration to whatever you set.

To generate a PEM file: 
- `ssh-keygen -P "" -t rsa -b 4096 -m pem -f my-key-pair`
- `chmod 400 my-key-pair`


