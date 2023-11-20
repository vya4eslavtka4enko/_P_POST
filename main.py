from flask import Flask, render_template
import requests
import json
app = Flask(__name__)
response = requests.get('https://api.npoint.io/79f25174e6089513a1bf')
all_blogs = response.json()

@app.route('/')
def home():
    return render_template("index.html", all_blogs=all_blogs)

@app.route('/blog')
def get_blog():
    return render_template('post.html',all_blogs=all_blogs)

if __name__ == "__main__":
    app.run(debug=True)
