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
            response.sendError(400, "Invalid donor update input.");
            return;
        }

        ps = conn.prepareStatement(
            "UPDATE DONORS SET name=?, blood_type=?, age=?, location=?, contact_info=?, availability=? WHERE donor_id=?"
        );
        ps.setString(1, name.trim());
        ps.setString(2, bloodType.trim());
        ps.setInt(3, age);
        ps.setString(4, location.trim());
        ps.setString(5, contactInfo.trim());
        ps.setString(6, availability);
        ps.setInt(7, id);
        ps.executeUpdate();
        response.sendRedirect("view.jsp");
    } finally {
        closeQuietly(ps);
        closeQuietly(conn);
    }
%>
