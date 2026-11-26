<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Donor Registration</title>
        <link rel="stylesheet" href="newcss.css">
    </head>
    <body>
        <header>
            <h1>Register New Donor!</h1>
        </header>
        <form action="registerprocess.jsp" method="post">
            ID: <input type="number" name="donor_id" min="1" required><br><br>
            Name: <input type="text" name="name" maxlength="100" required><br><br>
            Blood Type:
            <select name="blood_type">
                <option value="A+">A+</option>
                <option value="A-">A-</option>
                <option value="B+">B+</option>
                <option value="B-">B-</option>
                <option value="AB+">AB+</option>
                <option value="AB-">AB-</option>
                <option value="O+">O+</option>
                <option value="O-">O-</option>
            </select><br><br>
            Age: <input type="number" name="age" min="18" max="100" required><br><br>
            Location: <input type="text" name="location" maxlength="100" required><br><br>
            Contact Info: <input type="text" name="contact_info" maxlength="50" required><br><br>
            Availability:
            <select name="availability">
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select><br><br>
            <input type="submit" value="Register">
            <a href="home.jsp" class="btn">Back to Home</a>
        </form>
    </body>
</html>
