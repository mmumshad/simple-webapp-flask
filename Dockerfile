FROM ubuntu:16.04
RUN apt-get update && apt-get install -y 
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install flask
#COPY app.py /opt/
COPY . /opt/app
WORKDIR /opt/app
RUN pip3 install -r requirements.txt
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8081
