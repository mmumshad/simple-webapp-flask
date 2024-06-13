import os
from flask import Flask
app = Flask(__name__)

password = "1231434"
api_key = "23131231"
@app.route("/")
def main():
    return "Welcome!"

@app.route('/how are you')
def hello():
    return 'I am good, how about you?'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
