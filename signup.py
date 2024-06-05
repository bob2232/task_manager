
import mysql.connector
from flask import Flask, render_template, request,redirect, url_for

app = Flask(__name__)

def validate_password(password):
    if len(password) < 6 or len(password) > 20:
        return "Password length should be 6 - 20 characters"
    if not any(char.isupper() for char in password):
        return "Password must contain at least 1 uppercase letter"
    if not any(char.islower() for char in password):
        return "Password must contain at least 1 lowercase letter"
    if not any(char.isdigit() for char in password):
        return "Password must contain at least 1 digit"
    return True

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        first_name = request.form.get('first_name')
        last_name = request.form.get('last_name')   
        email = request.form.get('email')
        password = request.form.get('password')

        validation_result = validate_password(password)
        if validation_result is not True:
            return validation_result

        try:
            conn = mysql.connector.connect(
                database="db_task_manager",  
                user="user_task_manager",
                password="task",
                host="localhost",
                port="3306",
            )
            cursor = conn.cursor()

            cursor.execute("INSERT INTO users (first_name, last_name, email, password) VALUES (%s, %s, %s, %s)",
                           (first_name, last_name, email, password))

            conn.commit()
            cursor.close()
            conn.close()

            return redirect(url_for('index.html'))  # Redirect to login page after successful signup
        
        except Exception as e:
            return f"Error: {str(e)}"

    # If the request method is GET or the validation fails, render the signup form
    return render_template('signup.html')

if __name__ == "__main__":
    app.run(debug=True)