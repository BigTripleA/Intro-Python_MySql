import pymysql

def connect_to_db():
    return pymysql.connect(
        host="localhost",
        user="root",
        password="pass1",
        database="sample_project"
    )


def add_table(name):
    connection = connect_to_db()
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                           CREATE TABLE IF NOT EXISTS users(
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               name VARCHAR(255), 
                               age INT
                               )
                           """)
        connection.commit()
    finally:
        connection.close()

def add_user(name, age):
    connection = connect_to_db()
    try:
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO users (name, age) VALUES (%s, %s)", (name, age))
        connection.commit()
    finally:
        connection.close()

def view_users():
    connection = connect_to_db()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM users")
            result = cursor.fetchall()
            for row in result:
                print(row)
    finally:
        connection.close()

def delete_user(user_id):
    connection = connect_to_db()
    try:
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM users WHERE id = %s", (user_id,))
        connection.commit()
    finally:
        connection.close()

add_table("users")
add_user("Alice", 25)
view_users()
delete_user(1)
view_users()
