clear
docker version
sudo systemctl status docker
clear
sudo docker run docker/whalesay cowsay hello-world!
ubuntu@ip-172-31-32-139:~$ sudo docker run docker/whalesay cowsay hello-world!
Unable to find image 'docker/whalesay:latest' locally
latest: Pulling from docker/whalesay
docker: Docker Image Format v1 and Docker Image manifest version 2, schema 1 support has been removed. Suggest the author of docker.io/docker/whalesay:latest to upgrade the image to the OCI Format or Docker Image manifest v2, schema 2. More information at https://docs.docker.com/go/deprecated-image-specs/
docker ps
sudo docker ps
clear
docker pull docker/whalesay:linux
docker run docker/whalesay:linux cowsay "hello-world!"
sudo docker run docker/whalesay:linux cowsay "hello-world!"
sudo 
clear
sudo docker pull docker/whalesay:linux
ubuntu@ip-172-31-32-139:~$ sudo docker pull docker/whalesay:linux
Error response from daemon: manifest for docker/whalesay:linux not found: manifest unknown: manifest unknown
ubuntu@ip-172-31-32-139:~$
sudo docker hello-world
sudo docker run  hello-world
sudo docker pull docker/whalesay:latest
$ docker run docker/whalesay cowsay boo
sudo  docker run docker/whalesay cowsay boo
systemctl --user enable docker-desktop
sudo systemctl --user enable docker-desktop
clear
clear
cat /etc/*release*
sudo apt update -y
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
docker version
clear
docker pull docker/whalesay:latest
sudo docker run docker/whalesay cowsay hello-world!
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
clear
docker version
sudo  docker run docker/whalesay cowsay hello-world!
sudo usermod -aG docker $USER
docker version
docker run hello-world
sudo docker run docker/whalesay cowsay hello-world
clear
docker pull docker/whalesay:linux
sudo docker pull docker/whalesay:linux
sudo docker run docker/whalesay cowsay "Hello World!"
sudo docker run hello-world
clear
sudo docker run nginx
clear
docker ps
sudo docker ps
sudo docker ps -a
clear
docker run nginx
sudo docker run nginx
clear
sudo docker -d run nginx
sudo docker run -d  nginx
docker ps
sudo docker ps
docker ps -a
sudo docker ps -a
clear
docker run -d ubuntu
sudo docker run -d ubuntu
clear
sudo docker ps
sudo docker image
sudo docker images
clea
clear
sudo docker run -it ubuntu
clear
sudo docker run -it ubuntu
docker
clear
docker ps -a
sudo docker ps -a
clea
clear
docker ps -a
sudo docker ps -a
sudo docker rmi 3111fe1af56f
sudo docker rm 3111fe1af56f
sudo docker ps -a
clear
sudo docker rm  angry_noyce
sudo docker ps -a
sudo docker rm 35b 5bf 698 10b 710 80d
sudo docker ps -a
clear
sudo docker stop nginx
sudo docker ps -a
sudo docker stop 5bf
sudo docker rm 5bf
sudo docker ps -a
docker images
sudo docker images
docker run ubuntu
sudo docker run ubuntu
docker ps
sudo docker ps
clear
sudo docker run ubuntu
sudo docker ps
sudo docker ps -a
sudo docker run -d  ubuntu
clear
ls
docker images
docker run -d redis:4.0
docker images
clear
docker run -it reds:4.0
docker run -d mysql
clear
docker ps
docker run -d ubuntu
docker run ubuntu cat /etc/*release
docker run ubuntu:22.04 cat /etc/*release
docker run ubuntu sleep 15
clear
docker ps
docker ps -a
clear
docker run timer
sudo docker run timer
sudo docker run ubuntu
sudo docker run timer
docker run jenkins
clear
docker run -d jenkins
docker pull jenkins/jenkins:lts-jdk17
docker run jenkins
clear
dockr ps
docker ps
clear
sudo docker run -d -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
sudo lsofs
clear
docker ps
docker inspect 3d15d8b7a0fe
clear
sudo systemctl status jenkins
sudo docker ps
docker inspect 3d15d8b7a0fe
curl ifconfig.me
cat /var/jenkins_home/secrets/initialAdminPassword
clear
sudo cat /var/jenkins_home/secrets/initialAdminPassword
sudo docker run -d -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
sudo docker exec -it 3d15d8b7a0fe cat /var/jenkins_home/secrets/initialAdminPassword
clear
ls
sudo systemctl status docker
clear
docker images
docker ps 
docker ps -a
clear
docker images
sudo docker run -d -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
docker ps -a
docker ps
clear
curl ifconfig.me
sudo docker exec -it 3d15d8b7a0fe cat /var/jenkins_home/secrets/initialAdminPassword
clear
cle
clear
docker ps
clear
docker ps
sudo docker exec -it 16d00fb875e4 cat /var/jenkins_home/secrets/initialAdminPassword
docker run -p 8080:8080 jenkins
clear
mkdir jenkins_data
docker run -p 8080:8080 -v /root/jenkins_data:/var/jenkins_home jenkins
sudo docker run -d -p 8080:8080 -p 50000:50000   -v /root/jenkins_data:/var/jenkins_home   jenkins/jenkins:lts
clear
ls
docker ps
clear
docker run -it -d ubuntu bash
sudo apt-get update
sudo apt-get install -y python
What It Means for Vaidhya (Lessons)
From Practo’s model, you can learn:
Multiple Revenue Streams are very helpful — not just subscription or just booking fees
clear
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get update
sudo apt-get install -y python3
python
clear
phython
python3 --version
sudo apt-get install python-pip
pip install flask
sudo apt install python3-pip
python3 --version
clear
pip install flask
sudo apt install -y python3-flask
clear
pip install flask
clear
sudo apt install -y python3-venv
python3 -m venv myenv
source myenv/bin/activate
pip install flask
clear
python -m flask --version
cat > /opt/app.py
sudo cat> /opt/app.py
sudo tee /opt/app.py > /dev/null << 'EOF'
import os
from flask import Flask

app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome!"

@app.route("/how are you")
def hello():
    return "I am good, how about you?"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
EOF

sudo cat /opt/app.py
clear
cd /opt/
ls
curl ifconfig.me
FLASK_APP=app.py flask run --host=0.0.0.0
clear
mkdir my-simple-webapp 
cd ..
mkdir my-simple-webapp 
cd ..
exit
clear
mkdir my-simple-webapp 
cd my-simple-webapp/
cat > Dockerfile
cat Dockerfile 
clear
cat >app.py
docker build .
cat >app.py
clear
cat >app.py
cat app.py
cat >Dockerfile 
cl
clear
docker build .
clear
cat > Dockerfile 
docker build .
clear
docker ps
docker build .
docker images
clear
docker build . -t my-simple-webapp
clear
docker images
docker run my-simple-webapp:latest 
curl ifconfig.me
docker run my-simple-webapp:latest 
clear
cat Dockerfile 
