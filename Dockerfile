FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3-flask

COPY app.py /opt/app.py

ENV FLASK_APP=/opt/app.py

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
