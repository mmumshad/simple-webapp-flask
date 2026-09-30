# Simple Web Application

A minimal [Python Flask](https://flask.palletsprojects.com/) web application used as the demo app in the [KodeKloud Docker for Beginners](https://kodekloud.com/courses/docker-for-the-absolute-beginner-hands-on/) course.

The app exposes two routes:

| Route | Response |
|---|---|
| `/` | `Welcome!` |
| `/how-are-you` | `I am good, how about you?` |
| `/healthz` | `{"status":"ok"}`, used by the Kubernetes probes |
| `/version` | App version and hostname, e.g. `{"hostname":"...","version":"1.0.0"}` |

## Run manually (without Docker)

These steps assume a fresh machine.

1. Select an OS - Ubuntu

2. Update the package index:

   ```bash
   sudo apt-get update
   ```

3. Install Flask (this also pulls in Python 3):

   ```bash
   sudo apt-get install -y python3-flask
   ```

4. Set the Flask app environment variable:

   ```bash
   export FLASK_APP=app.py
   ```

5. Start the application:

   ```bash
   flask run --host=0.0.0.0
   ```

Then open `http://localhost:5000` and `http://localhost:5000/how-are-you` in a browser.

## Run with Docker

```bash
git clone https://github.com/mmumshad/simple-webapp-flask.git
cd simple-webapp-flask
docker build --build-arg APP_VERSION=1.0.0 -t simple-webapp-flask:1.0.0 .
docker run -p 5000:5000 simple-webapp-flask:1.0.0
```

Then open `http://localhost:5000` and `http://localhost:5000/how-are-you` in a browser.

The image is based on `python:3.12-slim`, installs the pinned packages from `requirements.txt`, runs the app with gunicorn on port 5000 as a non-root user, and bakes the `APP_VERSION` build argument into the `/version` endpoint.

## Run on Kubernetes

The manifests and the instructions to deploy, update, roll back and remove the application are in [k8s/](k8s/README.md).
