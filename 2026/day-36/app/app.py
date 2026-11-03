
from flask import Flask, request, jsonify
import pymysql
import os

app = Flask(__name__)


def get_db_connection():
    return pymysql.connect(
        host=os.getenv("MYSQL_HOST"),
        user=os.getenv("MYSQL_USER"),
        password=os.getenv("MYSQL_PASSWORD"),
        database=os.getenv("MYSQL_DATABASE"),
        port=int(os.getenv("MYSQL_PORT", "3306")),
        cursorclass=pymysql.cursors.DictCursor
    )


@app.route("/")
def home():
    return "Flask + MySQL application is running!"


@app.route("/products", methods=["GET"])
def get_products():
    connection = get_db_connection()

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM products")
        products = cursor.fetchall()

    connection.close()

    return jsonify(products)


@app.route("/products", methods=["POST"])
def add_product():
    data = request.json

    connection = get_db_connection()

    with connection.cursor() as cursor:
        cursor.execute(
            "INSERT INTO products (name, price) VALUES (%s, %s)",
            (data["name"], data["price"])
        )

    connection.commit()
    connection.close()

    return jsonify({"message": "Product added successfully"}), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
