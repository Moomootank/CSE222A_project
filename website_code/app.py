from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Goodbye, World!".join(["<p>Hello, World!</p>"]*100000)
