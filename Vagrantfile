Vagrant.configure("2") do |config|
  config.vm.box = "G3Technology/rhel9-ptools"
  config.vm.hostname = "rhel-control"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "parallels" do |p|
    p.memory = 4096
    p.cpus = 4
  end
end
