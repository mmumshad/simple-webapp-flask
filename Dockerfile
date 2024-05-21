FROM python:3.11
WORKDIR /opt
COPY . /opt
COPY ./requirements.txt /opt

RUN pip3 install -r requirements.txt
EXPOSE 5000

CMD ["flask", "run", "--host", "0.0.0.0"]
