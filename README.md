# Hi there!

1. Before install this vagrant box you need to install **vagrant** >= 1.8.6 from `https://www.vagrantup.com/downloads.html` and **virtualbox** >= 5.1.8 from `https://www.virtualbox.org/wiki/Downloads`

2. Also you need to install **vagrant-vbguest** plugin: `vagrant plugin install vagrant-vbguest`

Please see `https://github.com/dotless-de/vagrant-vbguest` for details about the plugin.

3. Last step you need to alter `Vagrantfile` file, change path, ports forwarding and so on.

## PROJECT INSTALLATION

You need to set up SSH keys forwarding:

on your local machine under normal user from which you usually operate with git repo, you need to create (or change) the file `~/.ssh/config` (you can also copy this file from "conf/ssh" dir) :

```
Host *
	ForwardAgent yes
```

It will enable your ssh keys forwarding. Also you need to add your key to ssh agent, if it wasn't before:

### list of added keys
`ssh-add -l`

### add your key (for example, and by default)
`ssh-add ~/.ssh/id_rsa`

After these actions you need to `exit` from vagrant box and ssh to it again, then if you run `ssh-add -l` you should be able to see your SSH keys. If so, continue with `project-init.sh` inside from vagrant box and `vagrant` user.