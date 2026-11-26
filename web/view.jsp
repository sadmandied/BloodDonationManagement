<%@include file="connection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Donors</title>
        <link rel="stylesheet" href="newcss.css">
    </head>
    <body>
        <header>
            <h1>Blood Donation Management System</h1>
        </header>

        <div class="container">
            <h2>Donor List</h2>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Blood Type</th>
                    <th>Age</th>
                    <th>Location</th>
                    <th>Availability</th>
                    <th>Contact Info</th>
                    <th>Actions</th>
                </tr>
                <%
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        stmt = conn.prepareStatement("SELECT * FROM donors ORDER BY donor_id");
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            int donorId = rs.getInt("donor_id");
                %>
                <tr>
                    <td><%= donorId %></td>
                    <td><%= escHtml(rs.getString("name")) %></td>
                    <td><%= escHtml(rs.getString("blood_type")) %></td>
                    <td><%= escHtml(rs.getString("age")) %></td>
                    <td><%= escHtml(rs.getString("location")) %></td>
                    <td><%= escHtml(rs.getString("availability")) %></td>
                    <td><%= escHtml(rs.getString("contact_info")) %></td>
                    <td style="text-align:center;">
                        <a href="updatedonor.jsp?id=<%= donorId %>" class="btn">Edit</a>
                        <a href="delete.jsp?id=<%= donorId %>" class="btn" onclick="return confirm('Are you sure?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } finally {
                        closeQuietly(rs);
                        closeQuietly(stmt);
                        closeQuietly(conn);
                    }
                %>
            </table>

            <div style="text-align:center; margin-top:20px;">
                <a href="home.jsp" class="btn">Back to Home</a>
            </div>
        </div>
    </body>
</html>
