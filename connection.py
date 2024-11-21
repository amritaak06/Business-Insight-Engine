# connection.py
import mysql.connector

def get_connection():
    try:
        mydb = mysql.connector.connect(
        host="localhost",
        database="****",
        user="root",
        password="************"
        )
        return mydb
    except mysql.connector.Error as err:
        print(f"Database Error: {err}")
        return None
