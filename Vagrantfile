Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.network :private_network, ip: "192.168.33.10"

  if Vagrant.has_plugin?('vagrant-vbguest')
      config.vbguest.auto_update = false
  end

  config.vm.provider "virtualbox" do |vb|

      vb.name = "WebServerPuppet"
      vb.cpus = 1
      vb.memory = 1024
      vb.gui = false

  end

$provision_script= <<SCRIPT
    if [[ $(which puppet) != '/usr/bin/puppet' ]]; then
      sudo apt-get -y update
      sudo apt-get install -y puppet
    fi
SCRIPT

  config.vm.provision :shell, :inline => $provision_script

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
  end

end