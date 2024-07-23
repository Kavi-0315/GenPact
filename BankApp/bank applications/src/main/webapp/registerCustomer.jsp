<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Customer</title>
</head>
<body>
    <h2>Register Customer</h2>
    <form action="RegisterCustomerServlet" method="post">
        Full Name: <input type="text" name="fullName" required><br>
        Address: <input type="text" name="address" required><br>
        Mobile No: <input type="text" name="mobileNo" required><br>
        Email ID: <input type="email" name="emailId" required><br>
        Account Type: 
        <select name="accountType" required>
            <option value="Saving">Saving</option>
            <option value="Current">Current</option>
        </select><br>
        Initial Balance: <input type="number" name="balance" min="1000" required><br>
        Date of Birth: <input type="date" name="dateOfBirth" required><br>
        ID Proof: <input type="text" name="idProof" required><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
