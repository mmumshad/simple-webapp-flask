# Simple Web Application

This is a simple web application using [Python Flask](http://flask.pocoo.org/) and [MySQL](https://www.mysql.com/) database. 
This is used in the demonstration of development of Ansible Playbooks.
  
  Below are the steps required to get this working on a base linux system.
  
  - Install all required dependencies
  - Install and Configure Web Server
  - Start Web Server
   
## 1. Install python
  
  Python and its dependencies

    apt update && apt full-upgrade -y  && apt install python-pip -y 
   
## 2. Install and Configure Web Server

Install Python Flask dependency

    pip2 install flask

- Copy app.py or download it from source repository 

## 3. Start Web Server

Start web server

    FLASK_APP=app.py flask run --host=0.0.0.0
    
## 4. Test

Open a browser and go to URL

    http://<IP>:8080                           
