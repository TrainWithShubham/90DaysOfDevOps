from flask import Flask, render_template, request, redirect
from database import db
from models import Goal
import os
import random

app = Flask(__name__)

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://postgres:postgres@localhost:5432/motivation_db"
)

app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URL
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)

quotes = [
    "Small steps every day create big results.",
    "Discipline today becomes freedom tomorrow.",
    "You are building your future one commit at a time.",
    "Do not stop until you are proud.",
    "Every failure is feedback. Keep going."
]


@app.route("/")
def home():
    goals = Goal.query.order_by(Goal.created_at.desc()).all()
    quote = random.choice(quotes)
    return render_template("index.html", goals=goals, quote=quote)


@app.route("/add", methods=["POST"])
def add_goal():
    title = request.form.get("title")
    description = request.form.get("description")
    target_date = request.form.get("target_date")

    new_goal = Goal(
        title=title,
        description=description,
        target_date=target_date
    )

    db.session.add(new_goal)
    db.session.commit()

    return redirect("/")


@app.route("/update/<int:goal_id>", methods=["POST"])
def update_goal(goal_id):
    goal = Goal.query.get_or_404(goal_id)
    goal.progress = int(request.form.get("progress"))
    db.session.commit()
    return redirect("/")


@app.route("/delete/<int:goal_id>")
def delete_goal(goal_id):
    goal = Goal.query.get_or_404(goal_id)
    db.session.delete(goal)
    db.session.commit()
    return redirect("/")


@app.route("/health")
def health():
    return {
        "status": "healthy",
        "app": "Asma Motivation Tracker",
        "database": "connected"
    }


with app.app_context():
    db.create_all()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)