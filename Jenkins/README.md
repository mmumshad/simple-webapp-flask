# Flask CI/CD Pipeline with Jenkins

This repository is a fork of [mohanDevOps-arch/flask_Practice](https://github.com/mohanDevOps-arch/flask_Practice.git),
extended with a Jenkins pipeline that automates **build → test → deploy** for the Flask application,
along with automatic build triggers and email notifications.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Jenkins Setup](#jenkins-setup)
- [Pipeline Stages](#pipeline-stages)
- [Configuring the Build Trigger](#configuring-the-build-trigger)
- [Configuring Email Notifications](#configuring-email-notifications)
- [Running the Pipeline](#running-the-pipeline)
- [Repository Structure](#repository-structure)
- [Troubleshooting](#troubleshooting)

## Overview

The `Jenkinsfile` in the root of this repository defines a declarative pipeline with three stages:

1. **Build** – creates a Python virtual environment and installs dependencies from `requirements.txt`.
2. **Test** – runs the test suite with `pytest` and publishes JUnit-style test results.
3. **Deploy** – if (and only if) all tests pass and the branch is `main`, the app is started as a
   background process to simulate deployment to a staging environment.

On every completed build, Jenkins sends an email notifying whether the pipeline succeeded or failed.

## Prerequisites

Before running the pipeline, make sure you have:

- A Jenkins server (self-hosted VM, on-prem, or a cloud instance) with admin access.
- **Java 11+** installed on the Jenkins host (required by Jenkins itself).
- **Python 3.8+** and `pip` installed on the Jenkins agent that will execute the pipeline.
- Git installed on the Jenkins agent.
- A forked copy of this repository under your own GitHub account.
- (Optional but recommended) A GitHub Personal Access Token if your fork is private, so Jenkins can
  clone it.
- An SMTP-capable email account (e.g., Gmail with an App Password) for notifications.

## Jenkins Setup

1. **Install Jenkins**
   ```bash
   sudo apt update
   sudo apt install -y fontconfig openjdk-17-jre
   curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
     /usr/share/keyrings/jenkins-keyring.asc > /dev/null
   echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
     "https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
     /etc/apt/sources.list.d/jenkins.list > /dev/null
   sudo apt update
   sudo apt install -y jenkins
   sudo systemctl enable --now jenkins
   ```
   ![alt text](Jenkins_install.png)
2. Browse to `http://<server-ip>:8080`, unlock Jenkins using
   `/var/lib/jenkins/secrets/initialAdminPassword`, and install the suggested plugins.
3. Install additional plugins via **Manage Jenkins → Plugins → Available**:
   - Pipeline
   - Git
   - GitHub
   - Email Extension Plugin
4. Install Python tooling on the Jenkins agent:
   ```bash
   sudo apt install -y python3 python3-venv python3-pip
   ```

## Pipeline Stages

| Stage    | What it does                                                             |
|----------|---------------------------------------------------------------------------|
| Checkout | Pulls the latest code from the configured branch of your fork.           |
| Build    | Creates a virtualenv and runs `pip install -r requirements.txt`.          |
| Test     | Runs `pytest`, produces `test-results.xml`, and publishes JUnit results.  |
| Deploy   | Only on `main` and only if tests pass: launches the app as a background process bound to a staging port (`8000` by default), simulating a staging deployment. |

If any stage fails, the pipeline stops immediately and the **post → failure** block sends an email.

## Configuring the Build Trigger

Two supported approaches (the Jenkinsfile includes a polling fallback by default):

**Option A — GitHub Webhook (recommended, near-instant builds)**
1. In your GitHub fork: **Settings → Webhooks → Add webhook**.
2. Payload URL: `http://<your-jenkins-url>/github-webhook/`
3. Content type: `application/json`
4. Trigger on: "Just the push event."
5. In the Jenkins job configuration, check **"GitHub hook trigger for GITScm polling."**

**Option B — SCM Polling (works even if Jenkins isn't publicly reachable)**
- Already configured in the `Jenkinsfile` via `pollSCM('H/5 * * * *')`, checking for changes every 5 minutes.
- Alternatively, enable "Poll SCM" in the job configuration UI with the same schedule.

## Configuring Email Notifications

1. **Manage Jenkins → System → Extended E-mail Notification**: set SMTP server, port, and
   credentials (e.g., `smtp.gmail.com`, port `587`, with an App Password).
2. Also fill in the basic **E-mail Notification** section as a fallback for the standard `mail` step.
3. Update the `NOTIFY_EMAIL` environment variable at the top of the `Jenkinsfile` with your address.
4. Emails are sent automatically:
   - On success → confirms Build/Test/Deploy completed.
   - On failure → links directly to the failing console output.

## Running the Pipeline

1. Create a new Jenkins item: **New Item → Pipeline**.
2. Under **Pipeline**, select "Pipeline script from SCM":
   - SCM: Git
   - Repository URL: your fork's URL
   - Branch: `*/main`
   - Script Path: `Jenkinsfile`
3. Save, then click **Build Now** to run it manually the first time.
4. Push a commit to `main` on your fork to confirm the trigger fires automatically afterward.

## Repository Structure

```
flask_Practice/
├── app.py                # Flask application entrypoint
├── requirements.txt       # Python dependencies
├── tests/                 # pytest test suite
├── Jenkinsfile             # CI/CD pipeline definition
└── README.md               # This file
```

> Note: If your fork uses a different entrypoint filename or a subfolder for the app/tests, update
> the `Deploy` stage command (`python3 app.py ...`) in the `Jenkinsfile` accordingly.

## Troubleshooting

- **`pytest: command not found`** → Ensure the virtualenv is activated in the same shell step; each
  `sh` block in Jenkins runs in a fresh shell, so activation must happen in the same block as usage.
- **Webhook not triggering builds** → Check GitHub's webhook delivery logs (green check/red X) under
  Settings → Webhooks → Recent Deliveries, and confirm Jenkins is reachable from GitHub's servers.
- **No email received** → Verify SMTP credentials under Manage Jenkins → System, and check the
  Jenkins system log for mail errors.
- **Deploy stage port already in use** → The pipeline kills any previous staging PID stored in
  `staging.pid` before starting a new one; delete `staging.pid` manually if it becomes stale.

## Submission Checklist

- [ ] Forked repository URL with `Jenkinsfile` and this `README.md` committed to `main`.
- [ ] Screenshot of Jenkins Stage View showing Build, Test, and Deploy stages passing.
- [ ] Screenshot of console output for a build (showing pip install, pytest results, deploy step).
- [ ] Screenshot of a received success/failure notification email.
- [ ] Screenshot of the GitHub webhook delivery log (if using webhook trigger).