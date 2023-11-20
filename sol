<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=Raleway" rel="stylesheet">
    <link rel="stylesheet" href="../static/css/styles.css">
</head>
<body>
<div class="wrapper">
    <div class="top">
        <div class="title"><h1>My Blog</h1></div>
    </div>

    {% for post in all_posts: %}
    <div class="content">
        <div class="card ">
            <h2>{‌{ post.title }}</h2>
            <p>{‌{ post.subtitle }}</p>
            <a href="{‌{ url_for('show_post', index=post.id) }}">Read</a>
        </div>

    </div>
    {% endfor %}

</div>
</body>
<footer>
    <p>Made with ♥️ in London.</p>
</footer>
</html>
main.py
from flask import Flask, render_template
from post import Post
import requests

posts = requests.get("https://api.npoint.io/c790b4d5cab58020d391").json()
post_objects = []
for post in posts:
    post_obj = Post(post["id"], post["title"], post["subtitle"], post["body"])
    post_objects.append(post_obj)

app = Flask(__name__)


@app.route('/')
def get_all_posts():
    return render_template("index.html", all_posts=post_objects)


@app.route("/post/<int:index>")
def show_post(index):
    requested_post = None
    for blog_post in post_objects:
        if blog_post.id == index:
            requested_post = blog_post
    return render_template("post.html", post=requested_post)


if __name__ == "__main__":
    app.run(debug=True)
post.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=Raleway" rel="stylesheet">
    <link rel="stylesheet" href="../static/css/styles.css">
</head>
<body>
<div class="wrapper">
    <div class="top">
        <div class="title"><h1>My Blog</h1></div>
    </div>
    <div class="content">
        <div class="card">
            <h1> {‌{ post.title }}</h1>
            <h2> {‌{ post.subtitle }}</h2>
            <p> {‌{ post.body }}</p>
        </div>
    </div>
</div>
</body>
<footer>
    <p>Made with ♥️ in London.</p>
</footer>
</html>
post.py
class Post:
    def __init__(self, post_id, title, subtitle, body):
        self.id = post_id
        self.title = title
        self.subtitle = subtitle
        self.body = body