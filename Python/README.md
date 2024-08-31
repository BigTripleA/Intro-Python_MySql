## Getting Started with Python

### Table of Contents

1. [Introduction](#introduction)
2. [Installing Python on Windows](#installing-python-on-windows)
3. [Python Syntax Overview](#python-syntax-overview)
4. [Advanced Python Features](#advanced-python-features)
5. [Connecting Python to MySQL](#connecting-python-to-mysql)
6. [Sample Project: Python and MySQL Integration](#sample-project-python-and-mysql-integration)
7. [Conclusion](#conclusion)
8. [Additional Resources](#additional-resources)

---

### 1. Introduction

This guide is designed for programmers who want to become familiar with Python. Here, we’ll cover Python’s syntax, unique features, and how to connect Python to a MySQL database, using prior knowledge of programming as a foundation.

### 2. Installing Python on Windows

To get started with Python on Windows, follow these steps:

1. **Download Python:**
   - Visit the official Python website: [python.org](https://www.python.org/downloads/)
   - Download the latest version for Windows.

2. **Run the Installer:**
   - Open the downloaded installer.
   - **Important:** Check "Add Python to PATH" to run Python from the command line.
   - Click "Install Now".

3. **Verify the Installation:**
   - Open Command Prompt (search for `cmd` in the Start Menu).
   - Type `python --version` and press Enter.
   - You should see the installed Python version.

### 3. Python Syntax Overview

Python emphasizes readability and simplicity, making it distinct from many other programming languages. Here’s a quick overview of Python syntax with comparisons to other languages:

#### 3.1. Variables and Data Types

Python is dynamically typed, meaning variable types are inferred, unlike in languages like Java or C++.

```python
name = "Alice"  # No need for `String` keyword
age = 30        # No need for `int` keyword
is_active = True
```

#### 3.2. Conditional Statements

Python uses indentation instead of curly braces `{}` or keywords like `endif` to define code blocks.

Python code:
```python
if age > 18:
    print("Adult")
else:
    print("Minor")
```

Compared to C++:

```C++ 
if (age > 18) {
    std::cout << "Adult";
} else {
    std::cout << "Minor";
}
```

#### 3.3. Loops

Python supports `for` and `while` loops, similar to other languages but with simpler syntax.

**Python code:**

```python
for i in range(5,10,2):  # Outputs 5,7,9
    print(i)

```

**Compared to Javascript:**

``` JS
for (let i = 0; i < 5; i++) {
    console.log(i);
}
```

#### 3.4. Functions

Defining functions in Python is straightforward and does not require specifying return types.

**Python code:**
```python
def greet(name):
    return f"Hello, {name}"

print(greet("Alice"))
```

**Compared to Java:**

``` Java
String greet(String name) {
    return "Hello, " + name;
}
```

### 4. Advanced Python Features

Python has several advanced features that might differ from other programming languages. Here are some key features:

#### 4.1. List Comprehensions

List comprehensions provide a concise way to create lists.


**Python code:**
```python
squares = [x**2 for x in range(10)]
```
**Compared to C#:**
``` C#
var squares = Enumerable.Range(0, 10).Select(x => x * x).ToList();
```

#### 4.2. Lambda Functions and Higher-Order Functions

Python supports anonymous functions (lambdas) and allows passing functions as arguments.

```python
square = lambda x: x**2
print(square(5))  

# Using higher-order functions
numbers = [1, 2, 3, 4]
squared_numbers = map(lambda x: x**2, numbers)
print(list(squared_numbers))  
```

#### 4.3. Exception Handling

Python uses `try` and `except` for exception handling, similar to `try` and `catch` in other languages.

```python
try:
    result = 10 / 0
except ZeroDivisionError: # Can use Exception to catch any
    print("Cannot divide by zero")
```

#### 4.4. Object-Oriented Programming

Python fully supports object-oriented programming (OOP) with classes and inheritance.

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        print(f"{self.name} makes a sound")

class Dog(Animal):
    def speak(self):
        print(f"{self.name} barks")

dog = Dog("Buddy")
dog.speak()
```


---

### 5. Connecting Python to MySQL

Python can easily interact with databases, including MySQL, using libraries like `PyMySQL`. Here, we'll show you how to set up and use `PyMySQL` to connect to and interact with a MySQL database.

#### 5.1. Install PyMySQL

To install `PyMySQL`, run the following command in your command prompt or terminal:

```bash
pip install pymysql
```

#### 5.2. Basic Connection Setup

Here’s a simple Python script to connect to a MySQL database using `PyMySQL`:

```python
import pymysql

# Establish the connection
connection = pymysql.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="your_database_name"
)

# Check if the connection was successful
try:
    with connection.cursor() as cursor:
        cursor.execute("SELECT VERSION()")
        db_version = cursor.fetchone()
        print(f"Connected to MySQL database, version: {db_version[0]}")
finally:
    connection.close()
```

#### 5.3. Performing SQL Operations

You can execute SQL commands directly from Python to interact with the database using `PyMySQL`. Here's how to perform common SQL operations:

```python
import pymysql

# Establish the connection
connection = pymysql.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="your_database_name"
)

try:
    with connection.cursor() as cursor:
        # Create a table
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY, 
            name VARCHAR(255), 
            age INT
        )
        """)

        # Insert data
        cursor.execute("INSERT INTO users (name, age) VALUES (%s, %s)", ("John Doe", 30))
        connection.commit()

        # Retrieve data
        cursor.execute("SELECT * FROM users")
        result = cursor.fetchall()
        for row in result:
            print(row)
finally:
    # Close the connection
    cursor.close()
    connection.close()
```

### 6. Sample Project: Python and MySQL Integration

To consolidate what we've learned, let's build a small project that integrates Python with MySQL using `PyMySQL`.

#### Project Overview

Create a simple command-line application to manage user data (add, view, delete users) using a MySQL database.

#### Steps:

1. **Set Up Database:**
   - Create a MySQL database and table for storing user information.

2. **Build Python Script:**
   - Connect to the database using Python.
   - Implement functions to add, view, and delete user data.

3. **Run the Application:**
   - Execute the script and test the functionality.

**Sample code in folder as a hint**



### 7. Conclusion

With this guide, we’ve learned Python’s syntax and features tailored for programmers and how to connect Python to a MySQL database using `PyMySQL`. 

### 8. Additional Resources

- [Python Official Documentation](https://docs.python.org/3/)
- [PyMySQL Documentation](https://pymysql.readthedocs.io/en/latest/)
- [Python for Programmers Book](https://www.deitel.com/PythonforProgrammers/)
- [Real Python Tutorials](https://realpython.com/)

---

This revised README should now effectively guide a programmer familiar with other languages on how to use `PyMySQL` to connect Python to a MySQL database.