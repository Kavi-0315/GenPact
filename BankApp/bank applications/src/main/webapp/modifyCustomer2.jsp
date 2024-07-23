<%@ page import="java.sql.*" %>
<%
    String accountNo = request.getParameter("accountNo");
    String fullName = "";
    String address = "";
    String mobileNo = "";
    String emailId = "";
    String accountType = "";
    String dateOfBirth = "";
    String idProof = "";

    if (accountNo != null && !accountNo.isEmpty()) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

            String sql = "SELECT * FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                fullName = rs.getString("full_name");
                address = rs.getString("address");
                mobileNo = rs.getString("mobile_no");
                emailId = rs.getString("email_id");
                accountType = rs.getString("account_type");
                dateOfBirth = rs.getString("date_of_birth");
                idProof = rs.getString("id_proof");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Modify Customer</title>
</head>
<body>
    <h1>Modify Customer Details</h1>
    <form action="ModifyCustomerServlet" method="post">
        <input type="hidden" name="accountNo" value="<%= accountNo %>">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" value="<%= fullName %>" required><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%= address %>" required><br>
        <label for="mobileNo">Mobile No:</label>
        <input type="text" id="mobileNo" name="mobileNo" value="<%= mobileNo %>" required><br>
        <label for="emailId">Email Id:</label>
        <input type="email" id="emailId" name="emailId" value="<%= emailId %>" required><br>
        <label for="accountType">Account Type:</label>
        <input type="text" id="accountType" name="accountType" value="<%= accountType %>" required><br>
        <label for="dateOfBirth">Date of Birth:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dateOfBirth %>" required><br>
        <label for="idProof">ID Proof:</label>
        <input type="text" id="idProof" name="idProof" value="<%= idProof %>" required><br>
        <button type="submit">Modify</button>
    </form>
</body>
</html>
