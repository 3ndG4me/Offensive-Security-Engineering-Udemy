# Using a VM Instead of AWS for this Course

If you are in a predicament where you need to make use of a VM and test these techniques locally you have two options.

1. Use the provided Ubuntu and Kali Linux Vagrantfiles
2. Manually configure your own VMs

The course references will provide links to documentation on setting up and using Vagrant, but in either case you will likely need to install Virtualbox at minimum.

If you are using Vagrant, and need to spin up multiple VMs, simply copy and rename the directory containing the Vagrantfile you would like to use, and issue the `vagrant up` command.

The following example shows how to do that with the Ubuntu VM:
1. `cp -r /path/to/vagrant-ubuntu /path/to/vagrant-ubuntu-2`
2. `cd /path/to/vagrant-ubuntu-2`
3. `vagrant up`

These same steps can be followed to set up as many VMs as you need for a given exercise. This course still has a heavy emphasis on Terraform, so if you are following along manually you will still need to learn Terraform to convert the IaC into manual steps.

Manual steps will explicitly **not** be provided as the goal either way should be to understand the Terraform well enough to either use it, or translate it.

Feel free to document the manual steps you come up with and share them. You are even encouraged to automate them locally with whatever tooling you choose.
