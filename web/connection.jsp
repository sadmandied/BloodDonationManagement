<%@page import="java.sql.*, java.util.Set" %>
<%!
    private static final Set<String> VALID_BLOOD_TYPES = Set.of(
        "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"
    );
    private static final Set<String> VALID_AVAILABILITY = Set.of(
        "Available", "Unavailable"
    );

    private static String escHtml(String value) {
        if (value == null) return "";
        StringBuilder sb = new StringBuilder(value.length());
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '&': sb.append("&amp;"); break;
                case '<': sb.append("&lt;"); break;
                case '>': sb.append("&gt;"); break;
                case '"': sb.append("&quot;"); break;
                case '\'': sb.append("&#39;"); break;
                default: sb.append(c);
            }
        }
        return sb.toString();
    }

    private static int parsePositiveInt(String raw) {
        if (raw == null || raw.trim().isEmpty()) return -1;
        try {
            int val = Integer.parseInt(raw.trim());
            return val > 0 ? val : -1;
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private static boolean isAllowedBloodType(String bt) {
        return bt != null && VALID_BLOOD_TYPES.contains(bt.trim());
    }

    private static String normalizeAvailability(String raw) {
        if (raw == null) return null;
        String trimmed = raw.trim();
        if ("Yes".equalsIgnoreCase(trimmed)) return "Available";
        if ("No".equalsIgnoreCase(trimmed)) return "Unavailable";
        return VALID_AVAILABILITY.contains(trimmed) ? trimmed : null;
    }

    private static void closeQuietly(AutoCloseable res) {
        if (res != null) {
            try {
                res.close();
            } catch (Exception ignored) {
            }
        }
    }
%>
<%
    String envUrl = System.getenv("BLOOD_DB_URL");
    String envUser = System.getenv("BLOOD_DB_USER");
    String envPass = System.getenv("BLOOD_DB_PASSWORD");

    String url = (envUrl != null && !envUrl.isEmpty()) ? envUrl : "jdbc:oracle:thin:@localhost:1521:xe";
    String user = (envUser != null && !envUser.isEmpty()) ? envUser : "PROJECT";
    String password = (envPass != null) ? envPass : "";

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection(url, user, password);
%>
