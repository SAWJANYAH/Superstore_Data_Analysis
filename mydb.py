import mysql.connector
import pandas as pd

# loading csv file into dataframe...
superstrdf=pd.read_csv('processed_superstore1.csv', )

try:
    myconn=mysql.connector.connect(
        user='root',password='India01$',host='127.0.0.1',port=3306, database='superstoredb')

    if myconn.is_connected():
        mycur=myconn.cursor()
        mycur.execute("select database();")
        record=mycur.fetchone()
        print("connection to DB", record)
        mycur.execute('DROP TABLE IF EXISTS superstore;')
        print("Creating Superstore table...")
        mycur.execute('''CREATE TABLE superstore (row_id INT(10) PRIMARY KEY NOT NULL, 
                                order_id CHAR(100) NOT NULL, order_date DATE NOT NULL, 
                                ship_date DATE NOT NULL, ship_mode CHAR(100) NOT NULL, 
                                cust_id CHAR(100) NOT NULL, cust_name CHAR(100) NOT NULL, 
                                segment CHAR(100) NOT NULL,country CHAR(100) NOT NULL, 
                                city CHAR(100) NOT NULL, state CHAR(100) NOT NULL,
                                postal_code INT(5) NOT NULL,region CHAR(100) NOT NULL, 
                                prod_id CHAR(100) NOT NULL, category CHAR(100) NOT NULL, 
                                sub_cat CHAR(100) NOT NULL, prod_name CHAR(255) NOT NULL, 
                                sales FLOAT(10,5) NOT NULL)''')
        print("superstore table created!!!")
        for i, row in superstrdf.iterrows():
            if i<3:
                print(row)
            sql="INSERT INTO superstore VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            mycur.execute(sql, tuple(row))
            myconn.commit()
        
        mycur.execute("SELECT COUNT(*) FROM superstore;")
        records = mycur.fetchone()
        print(f"Number of records INSERTED{records}")

except Exception as e:
    print("Error while connecting to MYSQL", e)




#print(superstr.dtypes)
