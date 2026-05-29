from flask import Flask, request, jsonify
from flask_cors import CORS
import sqlite3
import json

app = Flask(__name__)
CORS(app)

DATABASE = 'users.db'

def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def create_table():
    conn = get_db_connection()
    conn.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            usuario TEXT NOT NULL UNIQUE,
            contraseña TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

@app.route('/Validar', methods=['POST'])
def validar_usuario():
    data = request.get_json()
    print(f"Login attempt with data: {data}")
    usuario = data['usuario']
    contraseña = data['contraseña']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE usuario = ? AND contraseña = ?", (usuario, contraseña))
    user = cursor.fetchone()
    conn.close()

    if user:
        print(f"User '{usuario}' found. Login successful.")
        # Return a list with a dictionary, similar to the expected format
        return jsonify([dict(user)])
    else:
        print(f"User '{usuario}' not found or password incorrect. Login failed.")
        # Return an empty list if user is not found
        return jsonify([])

@app.route('/agregar_usuario', methods=['POST'])
def agregar_usuario():
    data = request.get_json()
    print(f"Registration attempt with data: {data}")
    usuario = data['usuario']
    contraseña = data['contraseña']

    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO users (usuario, contraseña) VALUES (?, ?)", (usuario, contraseña))
        conn.commit()
        conn.close()
        print(f"User '{usuario}' registered successfully.")
        return jsonify({"message": "Registration completed successfully"}), 201
    except sqlite3.IntegrityError:
        print(f"Registration failed for user '{usuario}': User already exists.")
        return jsonify({"error": "User already exists"}), 409

if __name__ == '__main__':
    create_table()
    app.run(host='0.0.0.0', port=5000, debug=True)
