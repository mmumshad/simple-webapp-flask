import os
import socket

from flask import Flask, jsonify

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "dev")

@app.route("/")
def main():
    return "Welcome!"

@app.route('/how-are-you')
def hello():
    return 'I am good, how about you?'

@app.route('/healthz')
def healthz():
    return jsonify(status="ok")

@app.route('/version')
def version():
    return jsonify(version=APP_VERSION, hostname=socket.gethostname())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
