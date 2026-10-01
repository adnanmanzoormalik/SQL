#we ll creare a registration and login page
import sys
from dbhelper import DbHelper

class Flipkart:

    def __init__(self):
        #connect to DB
        self.db = DbHelper()
        self.menu()
        

    def menu(self):
        user_input = input("""
        1. Enter 1 to register
        2. Enter 2 to login
        3. Anything else to exit
        """)

        if user_input == "1":
            self.register()
        elif user_input == "2":
            self.login()
        else:
            sys.exit(1000)

    def register(self):
        name = input("Enter name: ")
        email = input("Enter email: ")
        password = input("Enter password: ")

        response = self.db.register(name, email, password)

        if response == 1:
            print("Regitration successful")
        else:
            print("Registration failed")

        self.menu()

    def login(self):
        email = input("Enter email: ")
        password = input("Enter password: ")

        data = self.db.search(email, password)

        if len(data) == 0:
            print("incorrecr email/password")
            self.login()
        else:
            print("Hello ",data[0][1])
            self.login_menu()

    def login_menu(self):
        input("""
        1. Enter 1 to see profile
        2. Enter 2 to edit profile
        3. Enter 3 to delete profile
        4. Enter 4 to logout
        """)

obj = Flipkart()