import pymysql

def connect_to_db():
    return pymysql.connect(
        host="localhost",
        user="your_username",
        password="your_password",
        database="your_database_name"
    )

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

# Example usage
add_user("Alice", 25)
view_users()
delete_user(1)
view_users()
