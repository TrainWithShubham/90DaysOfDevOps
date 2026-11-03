import os
import time
from flask import Flask
import psycopg2
import redis

app = Flask(__name__)

# Connect to Redis (uses the service name 'redis' from docker-compose)
cache = redis.Redis(host='redis', port=6379, decode_responses=True)

# Connect to Postgres (uses the service name 'db' from docker-compose)
def get_db_connection():
    conn = psycopg2.connect(
        host='db',
        database=os.environ.get('POSTGRES_DB', 'postgres'),
        user=os.environ.get('POSTGRES_USER', 'postgres'),
        password=os.environ.get('POSTGRES_PASSWORD', 'password')
    )
    return conn

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    # 1. Get visit count from Redis
    hits = get_hit_count()
    
    # 2. Get database info from Postgres
    db_message = ""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT version();')
        db_version = cur.fetchone()
        db_message = f"Successfully connected to PostgreSQL! Version: {db_version[0]}"
        cur.close()
        conn.close()
    except Exception as e:
        db_message = f"Could not connect to PostgreSQL: {e}"

    # 3. Display the normal text output on the browser
    return f"Hello World! This page has been viewed {hits} times.\n\nDatabase Status: {db_message}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
