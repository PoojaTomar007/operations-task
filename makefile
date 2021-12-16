tools:
	sudo apt-get update -y
	sudo apt-get install docker.io -y
	sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo usermod -aG docker ubuntu
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	sudo service docker restart
	sudo chmod 666 /var/run/docker.sock
	docker network create custom_network
	sudo apt-get install -y postgresql-client
start:
	sh rates-s.sh
db:
	sh db.sh
stop:
	sh rates-d.sh
