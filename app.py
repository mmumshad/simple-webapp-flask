import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome to Docker Class at JJTECH!"

@app.route('/how are you? Hope you are enjoying the class')
def hello():
    return 'Yes Prof, I sure do. I love DevOps?'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
