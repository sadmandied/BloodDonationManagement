<p align="center">
  <img src="https://i.postimg.cc/9FrhPvyR/bloodbanner.jpg" alt="Blood Donation Management System Banner" width="100%">
</p>

# 🩸 Blood Donation Management System

[![Build Verification](https://github.com/sadmandied/BloodDonationManagement/actions/workflows/ci.yml/badge.svg)](https://github.com/sadmandied/BloodDonationManagement/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java](https://img.shields.io/badge/Java-JSP_Scriptlets-ED8B00?logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Server](https://img.shields.io/badge/Server-Apache_Tomcat_10-F8DC75?logo=apachetomcat&logoColor=black)](https://tomcat.apache.org/)
[![Database](https://img.shields.io/badge/Database-Oracle_XE_11g-F80000?logo=oracle&logoColor=white)](https://www.oracle.com/database/)

A Java-based web application developed using **JSP Scriptlets**, **JDBC**, and **Oracle Database XE** to streamline voluntary blood donor registration, blood group queries, and record management.

---

## 🌟 Overview
The **Blood Donation Management System** simplifies blood bank and donor operations. It enables healthcare coordinators and blood banks to manage active donors, search for compatible blood types, update donor availability, and maintain emergency contact channels.

Developed in **Apache NetBeans** with pure JSP scriptlets and Oracle Database connectivity.

---

## 🏛️ System Architecture

```mermaid
graph TD
    Client([Web Browser / User])

    subgraph Presentation Layer
        Index[index.html - Landing Page]
        Home[home.jsp - Donor Dashboard]
        View[view.jsp - Donor Directory]
        Register[registerdonor.jsp]
        Update[updatedonor.jsp]
    end

    subgraph Processing Layer
        RegProc[registerprocess.jsp]
        UpdProc[updateprocess.jsp]
        DelProc[delete.jsp]
    end

    subgraph Data Access
        Conn[connection.jsp - Oracle JDBC]
    end

    subgraph Oracle Database
        Donors[(Donors Table)]
    end

    Client --> Index --> Home
    Home --> Register --> RegProc --> Conn --> Donors
    Home --> View --> Update --> UpdProc --> Conn --> Donors
    View --> DelProc --> Conn --> Donors
```

---

## ⚙️ Key Features
- 🩸 **Comprehensive Donor Registration:** Capture name, blood group (A+, A-, B+, B-, AB+, AB-, O+, O-), age, location, and contact phone.
- 📋 **Live Donor Directory:** View all registered donors with their real-time availability status.
- ✏️ **Edit & Update Donors:** Modify location, contact details, or toggle availability between `Available` and `Unavailable`.
- 🗑️ **Record Management:** Safely remove inactive or outdated donor entries.
- 🗄️ **Oracle Database Integration:** Reliable data storage powered by Oracle XE and JDBC `PreparedStatement`.

---

## 📸 Screenshots

<p align="center">
  <img src="screenshots/Screenshot (386).png" width="45%" style="margin: 5px;">
  <img src="screenshots/Screenshot (387).png" width="45%" style="margin: 5px;">
  <img src="screenshots/Screenshot (388).png" width="45%" style="margin: 5px;">
  <img src="screenshots/Screenshot (390).png" width="45%" style="margin: 5px;">
</p>

---

## 🗄️ Database Schema

The system uses the `Donors` table in Oracle:

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

*A ready-to-run DDL and seed data script is provided in [`schema.sql`](./schema.sql).*

---

## 🚀 Setup & Execution

1. **Prerequisites:**
   - JDK 8 or higher
   - Apache Tomcat 9/10
   - Oracle Database XE 11g+
   - Apache NetBeans IDE
2. **Database Setup:**
   - Run `schema.sql` in Oracle SQL Commands or SQL*Plus under user `PROJECT` (or update credentials in `web/connection.jsp`).
3. **Deploy & Run:**
   - Open project in NetBeans, set server to Tomcat, and run.

---

## 📜 License

This project is licensed under the [MIT License](./LICENSE).

---

## 👤 Author

- **Sadman Fahmid Raj**
- University of Scholars
