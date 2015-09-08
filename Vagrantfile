Vagrant.configure("2") do |config|

	Instance = Struct.new(:region, :ami, :instance_type)
	instances = MyConfig::AWS[:instances]

	# SETUP 
  	(1..2).each do |i|
		config.vm.define "privoxy-#{i}" do |privoxy|
			instance = instances[i-1]
			privoxy.vm.box = "dummy"
			privoxy.vm.provider :aws do |aws, override|
				# AWS configuration settings
				aws.access_key_id = MyConfig::AWS[:access_key_id]
				aws.secret_access_key = MyConfig::AWS[:secret_access_key]
				aws.keypair_name = instance.region
				aws.ami = instance.ami
				aws.instance_type = instance.instance_type
				aws.region = instance.region
				aws.security_groups = ['privoxy_' + instance.region]
				aws.tags = {
				  'Name' => 'PRIVOXY_' + instance.region
				}
				# aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 50 }]
				override.ssh.username = "ubuntu"
				override.ssh.private_key_path = "/Users/patrickmichelberger/Development/aws/" + instance.region + ".pem"

				# Install docker and pull defined images 
				privoxy.vm.provision "docker" do |docker|
					docker.pull_images "pmichelberger/webcdn-privoxy:latest"
				end

				# Execute custom shell script 
				privoxy.vm.provision "shell", path: "provision.sh", privileged: false
			end
		end
	end
end
