from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['school']  # Create or connect to the 'school' database
students_collection = db['Student']  # Create or connect to the 'Student' collection

def insert_student(rollno, name, address, contact_no, department):
    student = {
        "rollno": rollno,
        "name": name,
        "address": address,
        "contact_no": contact_no,
        "department": department
    }
    students_collection.insert_one(student)
    print("Student details inserted successfully.")

def update_address(name, new_address):
    result = students_collection.update_one(
        {"name": name},
        {"$set": {"address": new_address}}
    )
    if result.modified_count > 0:
        print(f"Address updated successfully for {name}.")
    else:
        print(f"No record found for {name}.")

def display_students():
    students = students_collection.find()
    print("\nStudent Information:")
    for student in students:
        print(f"Roll No: {student['rollno']}, Name: {student['name']}, Address: {student['address']}, "
              f"Contact No: {student['contact_no']}, Department: {student['department']}")

def delete_student(rollno):
    result = students_collection.delete_one({"rollno": rollno})
    if result.deleted_count > 0:
        print(f"Student record with rollno {rollno} deleted successfully.")
    else:
        print(f"No record found with rollno {rollno}.")

def menu():
    while True:
        print("\nMenu:")
        print("1. Insert Student Details")
        print("2. Update Address of Pooja")
        print("3. Display Student Information")
        print("4. Delete Student Record (rollno: 32)")
        print("5. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            rollno = int(input("Enter Roll No: "))
            name = input("Enter Name: ")
            address = input("Enter Address: ")
            contact_no = input("Enter Contact No: ")
            department = input("Enter Department: ")
            insert_student(rollno, name, address, contact_no, department)
        elif choice == '2':
            update_address("Pooja", "Saraswati Nagar")
        elif choice == '3':
            display_students()
        elif choice == '4':
            delete_student(32)
        elif choice == '5':
            print("Exiting the program.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    menu()
