Vagrant.configure("2") do |config|
  config.vm.box = "G3Technology/rhel9-ptools"
  config.vm.hostname = "rhel-control"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "parallels" do |p|
    p.memory = 4096
    p.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    set -e

    # Ensure PATH is sane during provisioning
    export PATH="/usr/local/bin:$HOME/.local/bin:$PATH"
    hash -r

    # Make PATH consistent for all logins (no need to source ~/.bashrc)
    sudo tee /etc/profile.d/00-vagrant-path.sh >/dev/null <<'EOF'
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
EOF

    # Base utilities (do not fail if repos are unavailable)
    sudo dnf -y install curl unzip python3 python3-pip || true

    # Ansible via pip for the vagrant user (works without RHSM repos)
    sudo -u vagrant python3 -m pip install --user --upgrade pip
    sudo -u vagrant python3 -m pip install --user ansible

    # Ensure vagrant user's PATH includes ~/.local/bin (extra safety)
    if ! sudo -u vagrant grep -q 'PATH=.*\\.local/bin' /home/vagrant/.bashrc; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' | sudo -u vagrant tee -a /home/vagrant/.bashrc >/dev/null
    fi

    # Terraform via official static zip (arm64)
    TF_VER="1.10.0"
    curl -fsSL -o /tmp/terraform.zip "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_arm64.zip"
    sudo unzip -o /tmp/terraform.zip -d /usr/local/bin
    sudo chmod 755 /usr/local/bin/terraform

    # Verify
    sudo -u vagrant /home/vagrant/.local/bin/ansible --version
    /usr/local/bin/terraform -version
  SHELL
end
