import sqlite3

from app.config import DATABASE_NAME

def get_connection():
    conn = sqlite3.connect(DATABASE_NAME)
    conn.rowfactory = sqlite3.Row
    return conn

def initialise_database():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            category TEXT NOT NULL,
            price REAL NOT NULL,
            quantity INTEGER NOT NULL
        )
    """)
    conn.commit()
    conn.close()