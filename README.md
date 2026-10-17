# Blood Donation Management System

A web-based blood donation management application built with Java (JSP), JDBC, and Oracle Database.

## Features

- **Donor Registration:** Add donor details including blood group, age, location, and contact information.
- **Donor Directory:** View list of registered donors and their availability status.
- **Update Records:** Edit donor location, contact information, and availability status.
- **Delete Records:** Remove donor records from the system.

## Tech Stack

- **Frontend / Backend:** JSP (Java Server Pages), HTML, CSS
- **Database:** Oracle Database (XE) via JDBC
- **Server:** Apache Tomcat

## Database Setup

Create the `Donors` table in your Oracle database:

```sql
CREATE TABLE Donors (
    donor_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    blood_type VARCHAR2(10) NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    age NUMBER(3) NOT NULL,
    location VARCHAR2(100) NOT NULL,
    contact_info VARCHAR2(50) NOT NULL,
    availability VARCHAR2(20) DEFAULT 'Available' CHECK (availability IN ('Available', 'Unavailable'))
);
```

*A complete DDL and seed data script is available in [`schema.sql`](./schema.sql).*

## How to Run

1. Clone the repository.
2. Ensure you have **JDK 8+**, **Apache Tomcat**, and **Oracle Database XE** installed.
3. Execute `schema.sql` in Oracle SQL.
4. Verify database credentials in `web/connection.jsp`.
5. Open the project in Apache NetBeans (or your preferred IDE) and deploy to Tomcat.

## License

This project is licensed under the [MIT License](./LICENSE).
