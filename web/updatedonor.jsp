<%@include file="connection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = parsePositiveInt(request.getParameter("id"));
    if (id <= 0) {
        closeQuietly(conn);
        response.sendError(400, "Invalid donor ID.");
        return;
    }

    PreparedStatement ps = null;
    ResultSet rs = null;
    String donorName = "";
    String donorBloodType = "";
    String donorAge = "";
    String donorLocation = "";
    String donorContact = "";
    String donorAvailability = "Available";
    boolean found = false;

    try {
        ps = conn.prepareStatement("SELECT * FROM DONORS WHERE DONOR_ID=?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            found = true;
            donorName = rs.getString("name");
            donorBloodType = rs.getString("blood_type");
            donorAge = rs.getString("age");
            donorLocation = rs.getString("location");
            donorContact = rs.getString("contact_info");
            String normalizedAvail = normalizeAvailability(rs.getString("availability"));
            if (normalizedAvail != null) {
                donorAvailability = normalizedAvail;
            }
        }
    } finally {
        closeQuietly(rs);
        closeQuietly(ps);
        closeQuietly(conn);
    }

    if (!found) {
        response.sendError(404, "Donor record not found.");
        return;
    }

    String[] bloodTypes = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Donor</title>
        <link rel="stylesheet" href="newcss.css">
    </head>
    <body>
        <header><h1>Update Donor Information!</h1></header>
        <form action="updateprocess.jsp" method="post">
            <input type="hidden" name="donor_id" value="<%= id %>" required><br><br>
            Name: <input type="text" name="name" maxlength="100" value="<%= escHtml(donorName) %>" required><br><br>
            Blood Type:
            <select name="blood_type">
                <% for (String bt : bloodTypes) { %>
                <option value="<%= bt %>" <%= bt.equals(donorBloodType) ? "selected" : "" %>><%= bt %></option>
                <% } %>
            </select><br><br>
            Age: <input type="number" name="age" min="18" max="100" value="<%= escHtml(donorAge) %>" required><br><br>
            Location: <input type="text" name="location" maxlength="100" value="<%= escHtml(donorLocation) %>" required><br><br>
            Contact Info: <input type="text" name="contact_info" maxlength="50" value="<%= escHtml(donorContact) %>" required><br><br>
            Availability:
            <select name="availability">
                <option value="Available" <%= "Available".equals(donorAvailability) ? "selected" : "" %>>Available</option>
                <option value="Unavailable" <%= "Unavailable".equals(donorAvailability) ? "selected" : "" %>>Unavailable</option>
            </select><br><br>
            <input type="submit" value="Update">
            <a href="view.jsp" class="btn">Cancel</a>
        </form>
    </body>
</html>
