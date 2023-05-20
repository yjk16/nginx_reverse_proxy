# Configure 2 so that 2 virtual machines are created. And note, we need a new do block for second (db) VM.

Vagrant.configure("2") do |config|

  # Configuring app settings
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.network "private_network", ip: "192.168.10.100"
    
    # Syncing app folder from local machine to VM "folder from local", "where to put in VM"
    app.vm.synced_folder "app", "/home/vagrant/app"
    
    # Provision the VM to have Nginx
    app.vm.provision "shell", path: "provision_app.sh"
  end

  # Configuring db (database) settings
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150" # last number can be any number between 1-255

    # Syncing db folder from local machine to db VM "folder from local", "where to put in VM"
    # db.vm.synced_folder "environment", "/home/vagrant/environment"

    # Provision the db VM
    db.vm.provision "shell", path: "provision_db.sh"
  
  end
end
