<%@include file="connection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PreparedStatement ps = null;
    try {
        int id = parsePositiveInt(request.getParameter("donor_id"));
        int age = parsePositiveInt(request.getParameter("age"));
        String name = request.getParameter("name");
        String bloodType = request.getParameter("blood_type");
        String location = request.getParameter("location");
        String contactInfo = request.getParameter("contact_info");
        String availability = normalizeAvailability(request.getParameter("availability"));

        if (id <= 0 || age < 18 || age > 100
                || name == null || name.trim().isEmpty()
                || location == null || location.trim().isEmpty()
                || contactInfo == null || contactInfo.trim().isEmpty()
                || !isAllowedBloodType(bloodType)
                || availability == null) {
            response.sendError(400, "Invalid donor registration input.");
            return;
        }

        ps = conn.prepareStatement(
            "INSERT INTO Donors (DONOR_ID, NAME, BLOOD_TYPE, AGE, LOCATION, CONTACT_INFO, AVAILABILITY) VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        ps.setInt(1, id);
        ps.setString(2, name.trim());
        ps.setString(3, bloodType.trim());
        ps.setInt(4, age);
        ps.setString(5, location.trim());
        ps.setString(6, contactInfo.trim());
        ps.setString(7, availability);
        ps.executeUpdate();
        response.sendRedirect("view.jsp");
    } finally {
        closeQuietly(ps);
        closeQuietly(conn);
    }
%>
