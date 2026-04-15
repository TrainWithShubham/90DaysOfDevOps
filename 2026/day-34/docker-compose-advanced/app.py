from flask import Flask
import psycopg2
import redis
import os
import time

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        host=os.environ.get("DB_HOST"),
        database=os.environ.get("DB_NAME"),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASSWORD")
    )

def get_redis():
    return redis.Redis(host=os.environ.get("REDIS_HOST"), port=6379)

@app.route("/")
def hello():
    # DB check
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        cur.close()
        conn.close()
        db_status = "connected"
    except Exception as e:
        db_status = f"error: {e}"

    # Redis check
    try:
        r = get_redis()
        r.set("ping", "pong")
        redis_status = r.get("ping").decode()
    except Exception as e:
        redis_status = f"error: {e}"

    return {
        "message": "Hello World",
        "database": db_status,
        "redis": redis_status
    }

if __name__ == "__main__":
    # Small retry loop (defensive, even with depends_on)
    for i in range(5):
        try:
            get_db_connection()
            break
        except:
            time.sleep(2)

    app.run(host="0.0.0.0", port=5000)