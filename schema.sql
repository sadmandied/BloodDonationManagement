CREATE TABLE Donors (
    donor_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    blood_type VARCHAR2(10) NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    age NUMBER(3) NOT NULL,
    location VARCHAR2(100) NOT NULL,
    contact_info VARCHAR2(50) NOT NULL,
    availability VARCHAR2(20) DEFAULT 'Available' CHECK (availability IN ('Available', 'Unavailable'))
);

CREATE SEQUENCE donor_seq START WITH 1 INCREMENT BY 1;

INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY)
VALUES (1, 'Sadman Fahmid', 'O+', 22, 'Dhaka, Bangladesh', '01700000000', 'Available');

INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY)
VALUES (2, 'Rahim Ahmed', 'A+', 25, 'Uttara, Dhaka', '01811111111', 'Available');

INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY)
VALUES (3, 'Karim Ullah', 'B+', 28, 'Mirpur, Dhaka', '01922222222', 'Unavailable');

INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY)
VALUES (4, 'Tanvir Hasan', 'AB+', 24, 'Dhanmondi, Dhaka', '01633333333', 'Available');

INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY)
VALUES (5, 'Nusrat Jahan', 'O-', 21, 'Gulshan, Dhaka', '01544444444', 'Available');

COMMIT;
