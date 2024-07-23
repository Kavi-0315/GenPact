<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // HttpSession session = request.getSession(false); // This line is not needed
    if (session == null || session.getAttribute("accountNo") == null) {
        response.sendRedirect("customerLogin.jsp");
        return;
    }

    String accountNo = (String) session.getAttribute("accountNo");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String dbURL = "jdbc:mysql://localhost:3306/details";
    String dbUser = "root";
    String dbPassword = "Kavi@1503";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        String query = "SELECT * FROM TransactionHistory WHERE account_no = ? ORDER BY date DESC";
        ps = conn.prepareStatement(query);
        ps.setString(1, accountNo);
        rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
</head>
<body>
    <h1>Transaction History</h1>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Action</th>
            <th>Amount</th>
            <th>Balance After</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getTimestamp("date") %></td>
            <td><%= rs.getString("action") %></td>
            <td><%= rs.getDouble("amount") %></td>
            <td><%= rs.getDouble("balance_after") %></td>
        </tr>
        <%
            }
        %>
    </table>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
<%
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
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
