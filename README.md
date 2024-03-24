# Electrical-chain-store-Database-in-mySQL

This project encompasses a comprehensive database model developed in MySQL, showcasing example queries, a database schema, and an Entity-Relationship Diagram (ERD).

## Tables

The database comprises 16 tables:

- **Store**
- **Warehouse**
- **Department**
- **Sales_Destination**
- **Employee**
- **Salesman**
- **Warehouse_Worker**
- **Supplier**
- **Product**
- **Order_Supply**
- **Order_Lines**
- **Customer**
- **Stock_Department**
- **Stock_Warehouse**
- **Sale**
- **Sale_Detail**

## Note

- Format (Tables):

  - **College**: Holds names and IDs.
  - **Buildings**: Each building has a name.
  - **Classrooms**: Indicates projector presence, along with the building and room  - number.
  - **Sections**: Contains course, building, person, and classroom details.
  - **Courses**: Includes course names and associated textbook ISBNs.
  - **Textbooks**: Comprises title, author, and ISBN information.
  - **Persons**: Contains names and phone numbers.
  - **Faculty**: Includes titles, names, and salaries of faculty members.
  - **Students**: Stores grade point averages and student names.
  - **Interns**: Contains hourly wage and IDs.
    
- **Store**:  Holds ID, address, opening and closing times 
- **Warehouse** Contains its capacity 
- **Department** Includes names and capacities 
- **Sales_Destination** Has a destination of a specific month
- **Employee** Holds ID, names, addresses, birthday and hiring dates, phone numbers, positions and salaries 
- **Salesman** Has sales bonus percentage
- **Warehouse_Worker** Has ranks 
- **Supplier** Comprises names, phone numbers, starting dates and statuses  
- **Product** Contains names, types, prices, occupancies and manufacturers
- **Order_Supply** Stores order dates 
- **Order_Lines** (Orders detail) Gets a product quantities  
- **Customer** Contains ID, names, addresses and phone numbers
- **Stock_Department** Holds the quantities of each product and check dates
- **Stock_Warehouse** Holds the quantities of each product and check dates
- **Sale** Comprises the dates
- **Sale_Detail** Gets a product quantities, prices for each unit and total prices  

## Summary of Format:

- Most tables are designed with unique IDs as primary keys for unique identification, accompanied by unique indices.

- Foreign keys establish relationships between tables. 

- Table creation was done using the `CREATE TABLE` statement, followed by data insertion via `INSERT INTO` and `VALUES`.

- A range of queries was executed  with diffrent levels of manipulation. Covering basic retrieval, compound conditions, computed fields, SQL functions, subqueries, grouping, sorting, table joins, unions, special operators, views, updates, and deletes. All queries were successful and documented in a pptx file named "Presentation". This file contains the ERD and the queries results.
