tools:
	sudo apt-get update -y
	sudo apt-get install docker.io -y
	sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo usermod -aG docker ubuntu
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	sudo service docker restart
	sudo chmod 666 /var/run/docker.sock
start:
	docker-compose up -d
	sh rates-s.sh
db:
	sh db.sh
stop:
	docker-compose down
	sh rates-d.sh
