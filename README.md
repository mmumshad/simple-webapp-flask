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

---

# Student Contribution

## Developer Information

- **Name:** Cesar Enrique Garay Garcia
- **University:** Universidad Tecnológica del Norte de Guanajuato (UTNG)
- **Date:** 2026-06-01

## Proposed Improvements

1. Add a `docker-compose.yml` file to simplify multi-container deployments and reduce manual configuration steps for new developers.
2. Include a `CONTRIBUTING.md` guide with coding standards, branch naming conventions, and PR review guidelines to streamline collaboration.
3. Extend the API with additional routes (e.g., `/health` for health checks and `/version` to expose the current app version) to make it production-ready.

## Observations

This project serves as an excellent minimal reference for understanding how Flask applications are containerized using Docker. The straightforward structure — a single `app.py` alongside a `Dockerfile` — makes it easy for beginners to grasp the relationship between application code and container configuration. The documentation clearly maps each manual installation step to its corresponding Dockerfile instruction, which is a great pedagogical approach. Future improvements could focus on adding environment-variable support for configuration (e.g., port, debug mode) and providing a `requirements.txt` for proper Python dependency management instead of relying on system packages.

---

# 📸 Evidencias

## Evidencia 1 — Fork creado

> Captura de pantalla del Fork creado en la cuenta personal de GitHub (`Cesax69/simple-webapp-flask`).

<!-- Insertar captura del Fork aquí -->

## Evidencia 2 — Resultado de `git remote -v`

```
origin    https://github.com/Cesax69/simple-webapp-flask.git (fetch)
origin    https://github.com/Cesax69/simple-webapp-flask.git (push)
upstream  https://github.com/mmumshad/simple-webapp-flask.git (fetch)
upstream  https://github.com/mmumshad/simple-webapp-flask.git (push)
```

## Evidencia 3 — Resultado de `git branch`

```
* dev
  master
```

## Evidencia 4 — Resultado de `git log --oneline`

```
4961c2c docs: agregar seccion de Contribucion Estudiantil al README.md
9cbf47d Update Dockerfile and README for Ubuntu setup and Flask installation
44cbe59 Update README for Docker course (drop MySQL, add docker build/run)
8fd4478 Modernize Dockerfile to FROM python:3, port 5000
9dd6dff Merge pull request #15 from Tej-Singh-Rana/master
a23e2f6 Removed the extra spaces
47fd1dc Update ubuntu version
4efe4c7 Updated Dockerfile
3f3bd2d Updated python version
5ce20c9 Upgraded ubuntu version to 18.04
e2e6359 Merge pull request #6 from suyogpatil/patch-3
ae46f74 Update
efc0b6b Merge pull request #4 from suyogpatil/patch-1
b31344f Update Dockerfile
f592b20 Update Dockerfile
3e0c7fc Rename dockerfile to Dockerfile
e2e91fb Merge pull request #2 from tanbir2684/patch-1
08f3037 Create dockerfile
b441bb9 Update app.py
e8704ae Update app.py
868da47 Create requirements.txt
1e3d0b7 Update README.md
5374b64 Create app.py
47dacf4 Create README.md
430d0e7 Initial commit
```

## Evidencia 5 — Captura del Pull Request

> Captura de pantalla del Pull Request creado en GitHub.

<!-- Insertar captura del Pull Request aquí -->

## Evidencia 6 — URL del Pull Request

> [Pull Request — docs: agregar seccion de Contribucion Estudiantil al README.md](https://github.com/mmumshad/simple-webapp-flask/pull/)

<!-- Sustituir el enlace anterior con la URL exacta generada al crear el Pull Request -->
