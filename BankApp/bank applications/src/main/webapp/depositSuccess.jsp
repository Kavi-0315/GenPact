<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Successful</title>
</head>
<body>
    <h1>Deposit Successful</h1>
    <p>Amount Deposited: <%= request.getAttribute("amount") %></p>
    <p>New Balance: <%= request.getAttribute("balance") %></p>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
