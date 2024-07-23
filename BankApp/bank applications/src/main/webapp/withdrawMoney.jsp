<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Withdraw Money</title>
</head>
<body>
    <h1>Withdraw Money</h1>
    <form action="WithdrawMoneyServlet" method="post">
        <label for="amount">Amount to Withdraw:</label>
        <input type="text" id="amount" name="amount" required>
        <input type="submit" value="Withdraw">
    </form>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
