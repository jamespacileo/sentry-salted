Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8009

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  ## For masterless, mount your salt file root
  config.vm.synced_folder "states/salt", "/srv/salt"
  config.vm.synced_folder "states/pillar", "/srv/pillar"

  ## Use all the defaults:
  config.vm.provision :salt do |salt|
    salt.minion_config = "states/minion.conf"
    salt.run_highstate = true
    salt.verbose = true

    ## If you have a remote master setup, you can add
    ## your preseeded minion key
    # salt.minion_key = "salt/key/minion.pem"
    # salt.minion_pub = "salt/key/minion.pub"
  end
end