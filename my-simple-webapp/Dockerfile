# Use official Python image (slim version for smaller size)
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy your Flask app
COPY app.py /app/app.py

# Install Flask
RUN pip install --no-cache-dir flask

# Expose port 8080
EXPOSE 8080

# Run Flask
ENV FLASK_APP=/app/app.py
ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=8080"]
