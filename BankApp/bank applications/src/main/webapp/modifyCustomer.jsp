<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enter Account Number</title>
</head>
<body>
    <h1>Enter Account Number to Modify Customer Details</h1>
    <form action="modifyCustomer2.jsp" method="get">
        <label for="accountNo">Account Number:</label>
        <input type="text" id="accountNo" name="accountNo" required><br><br>
        <input type="submit" value="Get Details">
    </form>
</body>
</html>
