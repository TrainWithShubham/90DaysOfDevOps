from flask import Flask
import psycopg2
import redis
import os

app = Flask(__name__)

@app.route("/")
def home():

    db_message = "Database not connected"
    redis_message = "Redis not connected"

    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )

        conn.close()
        db_message = "PostgreSQL connected successfully"

    except Exception as e:
        db_message = f"Database error: {e}"

    try:
        cache = redis.Redis(
            host=os.getenv("REDIS_HOST"),
            port=6379
        )

        cache.ping()
        redis_message = "Redis connected successfully"

    except Exception as e:
        redis_message = f"Redis error: {e}"

    return f"""
    <h1>Hello Asma - Day 34 Docker Compose Lab</h1>

    <p>{db_message}</p>

    <p>{redis_message}</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)