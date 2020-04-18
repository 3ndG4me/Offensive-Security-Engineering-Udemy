# Salt Stack Setup

1. Run `terraform apply` to spin up the servers
2. Follow the instructions to install the salt-master and salt-minions here: https://repo.saltstack.com/#ubuntu
    - `sudo apt install salt-master` on the master
    - `sudo apt install salt-minion` on the minions
3. Get master fingerprint `sudo salt-key -F master`
4. Configure minions with master address and fingerprint
5. Run `sudo salt-key -L` to list the minions
6. Run `sudo salt-key -A` to accept all the minions that are listed
7. Put states in `/srv/salt/adduser/init.sls`
8. Put top file in `/srv/salt/top.sls`
9. To see an example of what will happen before you apply the state across all systems, supply the "test" argument `sudo salt '*' state.apply test=true`
10. To apply the state across all systems `sudo salt '*' state.apply`