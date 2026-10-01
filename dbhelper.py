import mysql.connector
import sys

class DbHelper:
    def __init__(self):
        try:
            self.conn = mysql.connector.connect(host="localhost", username="root", password="", database="hit-db-demo")
            self.mycursor = self.conn.cursor()
        except:
            print("couldnt connect to DB")
            sys.exit(0)
        else:
            print("connected to DB")

    def register(self, name, email, password):
        try: 
            self.mycursor.execute(f"""
            INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES (NULL, '{name}', '{email}', '{password}')""")
            self.conn.commit()
        except:
            return -1
        else:
            return 1

    def search(self, email, password):
        try:
            self.mycursor.execute(f"""
            SELECT * FROM users WHERE email LIKE '{email}' AND PASSWORD LIKE '{password}'""")
            data = self.mycursor.fetchall()
            return data
        except:
            pass


        

