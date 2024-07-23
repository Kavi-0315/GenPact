<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Money</title>
</head>
<body>
    <h1>Deposit Money</h1>
    <form action="DepositMoneyServlet" method="post">
        <label for="amount">Amount to Deposit:</label>
        <input type="text" id="amount" name="amount" required>
        <input type="submit" value="Deposit">
    </form>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
