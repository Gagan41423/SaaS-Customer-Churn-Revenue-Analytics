# DATABASE CREATION AND USAGE 

CREATE DATABASE SAS_Analytics; 
USE SAS_Analytics;


# PHASE ONE - TABLE CREATION DDL
# CREATING TABLE STRUCTURES 

CREATE TABLE customers ( 
customer_id int primary key,
signup_date DATE,
plan_type VARCHAR(50),
monthly_fee INT,
acquisition_cost INT,
churn_date DATE NULL
);


CREATE TABLE subscription (
subscription_id VARCHAR(50) PRIMARY KEY,
customer_id INT,
month VARCHAR(20),
monthly_fee INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE revenue (
subscription_id VARCHAR(50),
customer_id INT,
month varchar(20),
monthly_fee INT,
revenue_type VARCHAR(50),
amount INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

# INITIATED TABLE DATA IMPORT WIZARD TO FILL THIS TABLE FROM REQUIRED TABLE DATA FROM CSV DATASETS - 
#EXCEPT CUSTOMER FOR WHICH HVAE TO RUN PYTHON SCRIPT FOR DIFF DATETYPE CHANGE  
