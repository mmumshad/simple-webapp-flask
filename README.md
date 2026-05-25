# Simple Web Application

A minimal [Python Flask](https://flask.palletsprojects.com/) web application used as the demo app in the [KodeKloud Docker for Beginners](https://kodekloud.com/courses/docker-for-the-absolute-beginner-hands-on/) course.

The app exposes two routes:

| Route | Response |
|---|---|
| `/` | `Welcome!` |
| `/how-are-you` | `I am good, how about you?` |

## Run with Docker (recommended)

```bash
git clone https://github.com/mmumshad/simple-webapp-flask.git
cd simple-webapp-flask
docker build -t simple-webapp-flask .
docker run -p 5000:5000 simple-webapp-flask
```

Then open `http://localhost:5000` and `http://localhost:5000/how-are-you` in a browser.

## Run manually (without Docker)

```bash
pip install flask
FLASK_APP=app.py flask run --host=0.0.0.0
```

The app listens on port `5000`.

## The Dockerfile

```dockerfile
FROM python:3

RUN pip install flask

COPY app.py /opt/app.py

ENV FLASK_APP=/opt/app.py

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
```

Uses the official `python:3` image to avoid `apt-get`/PEP 668 friction and keep the image small.
