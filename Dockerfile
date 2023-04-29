FROM ubuntu
RUN apt update
RUN apt full-upgrade -y && apt install python-pip -y
RUN pip2 install flask
WORKDIR /opt
COPY app.py /opt/app.py
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
