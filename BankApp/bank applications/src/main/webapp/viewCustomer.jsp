<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Customer Details</title>
</head>
<body>
    <h1>Enter Account Number to View Customer Details</h1>
    <form action="ViewCustomerServlet" method="post">
        <label for="accountNo">Account Number:</label>
        <input type="text" id="accountNo" name="accountNo" required><br><br>
        <input type="submit" value="View Details">
    </form>
</body>
</html>
