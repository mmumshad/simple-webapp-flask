FROM ubuntu:20.04

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Install Python 3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Update pip and setuptools
RUN pip3 install --upgrade pip setuptools

# Install Flask
RUN pip3 install flask

# Copy your Flask app
COPY app.py /opt/

# Set the FLASK_APP environment variable
ENV FLASK_APP=/opt/app.py

# Use exec form for ENTRYPOINT
ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=8080"]
