# Simple Web Application

A minimal [Python Flask](https://flask.palletsprojects.com/) web application used as the demo app in the [KodeKloud Docker for Beginners](https://kodekloud.com/courses/docker-for-the-absolute-beginner-hands-on/) course.

The app exposes two routes:

| Route | Response |
|---|---|
| `/` | `Welcome!` |
| `/how-are-you` | `I am good, how about you?` |

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
docker build -t simple-webapp-flask .
docker run -p 5000:5000 simple-webapp-flask
```

Then open `http://localhost:5000` and `http://localhost:5000/how-are-you` in a browser.

## The Dockerfile

```dockerfile
FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3-flask

COPY app.py /opt/app.py

ENV FLASK_APP=/opt/app.py

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
```

Each instruction mirrors one of the manual steps above — making it easy to see how a Dockerfile is just an automated install script.


# Student Contribution

## Developer Information

- Name: Zayda Fernanda Vargas Vargas
- University: UTNG
- Date: 01/06/2026

## Proposed Improvements

1. Improve project documentation.
2. Add deployment guide.
3. Add testing examples.

## Observations

This project is useful for learning Flask fundamentals and deployment concepts.

## Project Strengths

1. Easy to understand structure.
2. Lightweight project.
3. Good for Flask beginners.
4. Quick deployment process.
5. Clear source code organization.

## Improvement Opportunities

1. Add user authentication.
2. Add unit testing.
3. Improve API documentation.
4. Add Docker support.
5. Improve UI design.

## Technologies Used

| Technology | Purpose |
|------------|----------|
| Python | Backend Development |
| Flask | Web Framework |
| HTML | User Interface |
| CSS | Styling |
| Git | Version Control |

## Architecture Diagram

```mermaid
graph LR
A[Client Browser] --> B[Flask Application]
B --> C[Business Logic]
C --> D[Data Storage]


---

## Actividad E

```markdown
## Functional Requirements

RF-01 The system shall display the home page.

RF-02 The system shall process user requests.

RF-03 The system shall return web responses.

RF-04 The system shall allow deployment on a server.

RF-05 The system shall support HTTP requests.

RF-06 The system shall display application status.

RF-07 The system shall manage application routes.

RF-08 The system shall serve static content.

RF-09 The system shall log application events.

RF-10 The system shall allow future feature extensions.