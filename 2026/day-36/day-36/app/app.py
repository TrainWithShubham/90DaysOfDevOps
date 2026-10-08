from flask import Flask
import psycopg2
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello Asma! Day 36 Dockerized Flask App is running."

@app.route("/db")
def db_check():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )
        conn.close()
        return "Database connection successful!"
    except Exception as e:
        return f"Database connection failed: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
