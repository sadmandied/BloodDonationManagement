<%@include file="connection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PreparedStatement ps = null;
    try {
        int id = parsePositiveInt(request.getParameter("id"));
        if (id <= 0) {
            response.sendError(400, "Invalid donor ID.");
            return;
        }
        ps = conn.prepareStatement("DELETE FROM DONORS WHERE DONOR_ID=?");
        ps.setInt(1, id);
        ps.executeUpdate();
        response.sendRedirect("view.jsp");
    } finally {
        closeQuietly(ps);
        closeQuietly(conn);
    }
%>
