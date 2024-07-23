<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Check if the user is logged in
    if (session.getAttribute("accountNo") == null) {
        response.sendRedirect("customerLogin.jsp");
        return;
    }

    String accountNo = (String) session.getAttribute("accountNo");
    double balance = 0.0;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

        String sql = "SELECT balance FROM Customer WHERE account_no = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, accountNo);
        rs = ps.executeQuery();

        if (rs.next()) {
            balance = rs.getDouble("balance");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Account Balance</title>
</head>
<body>
    <h1>Account Balance</h1>
    <p>Account Number: <%= accountNo %></p>
    <p>Balance: <%= balance %></p>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
