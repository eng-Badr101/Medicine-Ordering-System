DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Prescription_Details CASCADE CONSTRAINTS;
DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE Medicine CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Employee_Phone CASCADE CONSTRAINTS;
DROP TABLE Pharmacy_Branch CASCADE CONSTRAINTS;
DROP TABLE Account CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Customer_Phone CASCADE CONSTRAINTS;
DROP TABLE Branch_Stocks CASCADE CONSTRAINTS;
DROP TABLE Admin CASCADE CONSTRAINTS;
DROP TABLE Operation_Manager CASCADE CONSTRAINTS;
DROP TABLE Delivery_Boy CASCADE CONSTRAINTS;


CREATE TABLE Account (
    account_id NUMBER(20) PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    acc_password VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    create_date DATE
);

CREATE TABLE Pharmacy_Branch (
    branch_id NUMBER(20) PRIMARY KEY,
    branch_name VARCHAR2(100),
    operating_hours VARCHAR2(50),
    street VARCHAR2(100),
    city VARCHAR2(50)
);

CREATE TABLE Medicine (
    medicine_id NUMBER(20) PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER(10, 2),
    expiry_date DATE
);

CREATE TABLE Customer (
    customer_id NUMBER(20) PRIMARY KEY,
    account_id NUMBER(20) UNIQUE,
    name VARCHAR2(100),
    date_of_birth DATE,
    address VARCHAR2(200),
    CONSTRAINT fk_cust_acc FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Customer_Phone (
    customer_id NUMBER(20),
    phone VARCHAR2(20),
    PRIMARY KEY (customer_id, phone),
    CONSTRAINT fk_cp_cust FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Employee (
    employee_id NUMBER(20) PRIMARY KEY,
    account_id NUMBER(20) UNIQUE,
    branch_id NUMBER(20),
    emp_name VARCHAR2(100),
    hire_date DATE,
    salary NUMBER(10, 2),
    emp_position VARCHAR2(50),
    CONSTRAINT fk_emp_acc FOREIGN KEY (account_id) REFERENCES Account(account_id),
    CONSTRAINT fk_emp_branch FOREIGN KEY (branch_id) REFERENCES Pharmacy_Branch(branch_id)
);

CREATE TABLE Employee_Phone (
    employee_id NUMBER(20),
    phone VARCHAR2(20),
    PRIMARY KEY (employee_id, phone),
    CONSTRAINT fk_ep_emp FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Branch_Stocks (
    branch_id NUMBER(20),
    medicine_id NUMBER(20),
    stock_quantity NUMBER(20),
    PRIMARY KEY (branch_id, medicine_id),
    CONSTRAINT fk_bs_branch FOREIGN KEY (branch_id) REFERENCES Pharmacy_Branch(branch_id),
    CONSTRAINT fk_bs_med FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Prescription (
    prescription_id NUMBER(20) PRIMARY KEY,
    created_date DATE,
    status VARCHAR2(20),
    customer_id NUMBER(20),
    CONSTRAINT fk_pres_cust FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Prescription_Details (
    prescription_id NUMBER(20),
    medicine_id NUMBER(20),
    quantity NUMBER(20),
    dosage VARCHAR2(100),
    PRIMARY KEY (prescription_id, medicine_id),
    CONSTRAINT fk_pd_pres FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    CONSTRAINT fk_pd_med FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Payment (
    payment_id NUMBER(20) PRIMARY KEY,
    amount NUMBER(10, 2),
    payment_date DATE,
    payment_method VARCHAR2(20),
    status VARCHAR2(20),
    customer_id NUMBER(20),
    prescription_id NUMBER(20),
    CONSTRAINT fk_pay_cust FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_pay_pres FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id)
);

CREATE TABLE Admin (
    employee_id NUMBER(20) PRIMARY KEY,
    admin_role NUMBER(20),
    CONSTRAINT fk_admin_emp FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Operation_Manager (
    employee_id NUMBER(20) PRIMARY KEY,
    CONSTRAINT fk_om_emp FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Delivery_Boy (
    employee_id NUMBER(20),
    vehicle_ID NUMBER(20),
    PRIMARY KEY (employee_id, vehicle_ID),
    CONSTRAINT fk_db_emp FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);



INSERT INTO Account VALUES (1, 'ahmed_user', 'pass123', 'ahmed@gmail.com', TO_DATE('01-01-2024', 'DD-MM-YYYY'));
INSERT INTO Account VALUES (2, 'sara_user', 'pass456', 'sara@gmail.com', TO_DATE('15-02-2024', 'DD-MM-YYYY'));
INSERT INTO Account VALUES (3, 'mohamed_emp', 'secure789', 'mohamed@pharma.com', TO_DATE('10-01-2023', 'DD-MM-YYYY'));

INSERT INTO Pharmacy_Branch VALUES (10, 'Main Branch', '24 Hours', 'Tahrir St.', 'Cairo');
INSERT INTO Pharmacy_Branch VALUES (20, 'Alex Branch', '9 AM - 10 PM', 'Corniche St.', 'Alexandria');
INSERT INTO Pharmacy_Branch VALUES (30, 'Giza Branch', '8 AM - 12 AM', 'Pyramids St.', 'Giza');

INSERT INTO Medicine VALUES (100, 'Panadol', 'Painkiller', 50.00, TO_DATE('31-12-2026', 'DD-MM-YYYY'));
INSERT INTO Medicine VALUES (200, 'Augmentin', 'Antibiotic', 120.50, TO_DATE('15-10-2025', 'DD-MM-YYYY'));
INSERT INTO Medicine VALUES (300, 'Vitamin C', 'Supplement', 35.00, TO_DATE('01-01-2027', 'DD-MM-YYYY'));

INSERT INTO Customer VALUES (101, 1, 'Ahmed Ali', TO_DATE('10-05-1995', 'DD-MM-YYYY'), '123 Main St, Cairo');
INSERT INTO Customer VALUES (102, 2, 'Sara Hassan', TO_DATE('20-08-2000', 'DD-MM-YYYY'), '456 Sea St, Alex');
INSERT INTO Customer VALUES (103, NULL, 'Guest User', TO_DATE('01-01-1990', 'DD-MM-YYYY'), '789 Desert Rd, Giza');

INSERT INTO Customer_Phone VALUES (101, '01012345678');
INSERT INTO Customer_Phone VALUES (102, '01123456789');
INSERT INTO Customer_Phone VALUES (102, '01234567890');

INSERT INTO Employee VALUES (501, 3, 10, 'Mohamed Salah', TO_DATE('10-01-2023', 'DD-MM-YYYY'), 5000, 'Pharmacist');
INSERT INTO Employee VALUES (502, NULL, 10, 'Ali Kamel', TO_DATE('20-05-2022', 'DD-MM-YYYY'), 8000, 'Admin');
INSERT INTO Employee VALUES (503, NULL, 20, 'Khaled Said', TO_DATE('01-03-2024', 'DD-MM-YYYY'), 3000, 'Driver');

INSERT INTO Employee_Phone VALUES (501, '01099988877');
INSERT INTO Employee_Phone VALUES (502, '01277766655');
INSERT INTO Employee_Phone VALUES (503, '01555544433');

INSERT INTO Branch_Stocks VALUES (10, 100, 500);
INSERT INTO Branch_Stocks VALUES (10, 200, 200);
INSERT INTO Branch_Stocks VALUES (20, 300, 100);

INSERT INTO Prescription VALUES (1, TO_DATE('01-12-2024', 'DD-MM-YYYY'), 'Completed', 101);
INSERT INTO Prescription VALUES (2, TO_DATE('05-12-2024', 'DD-MM-YYYY'), 'Pending', 102);
INSERT INTO Prescription VALUES (3, TO_DATE('06-12-2024', 'DD-MM-YYYY'), 'Cancelled', 101);

INSERT INTO Prescription_Details VALUES (1, 100, 2, 'Twice daily');
INSERT INTO Prescription_Details VALUES (1, 200, 1, 'Every 12 hours');
INSERT INTO Prescription_Details VALUES (2, 300, 3, 'Once daily');

INSERT INTO Payment VALUES (901, 220.50, TO_DATE('01-12-2024', 'DD-MM-YYYY'), 'Cash', 'Paid', 101, 1);
INSERT INTO Payment VALUES (902, 105.00, TO_DATE('05-12-2024', 'DD-MM-YYYY'), 'Visa', 'Pending', 102, 2);
INSERT INTO Payment VALUES (903, 0.00, TO_DATE('06-12-2024', 'DD-MM-YYYY'), 'Cash', 'Refunded', 101, 3);

INSERT INTO Admin VALUES (502, 1);
INSERT INTO Delivery_Boy VALUES (503, 9999);

COMMIT;