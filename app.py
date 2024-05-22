import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "OMM NAMHA Ganapati!"

@app.route('/how are you')
def hello():
    return 'BABA Sivaya'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
