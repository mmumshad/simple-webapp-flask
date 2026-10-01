from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome!"


@app.route('/hello')
def hello():
    return "Hello, Open Source!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


