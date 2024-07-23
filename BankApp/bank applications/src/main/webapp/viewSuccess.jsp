<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
</head>
<body>
    <h1>Customer Details</h1>
    <p>Account Number: <%= request.getAttribute("accountNo") %></p>
    <p>Full Name: <%= request.getAttribute("fullName") %></p>
    <p>Address: <%= request.getAttribute("address") %></p>
    <p>Mobile Number: <%= request.getAttribute("mobileNo") %></p>
    <p>Email: <%= request.getAttribute("emailId") %></p>
    <p>Account Type: <%= request.getAttribute("accountType") %></p>
    <p>Balance: <%= request.getAttribute("balance") %></p>
    <p>Date of Birth: <%= request.getAttribute("dateOfBirth") %></p>
    <p>ID Proof: <%= request.getAttribute("idProof") %></p>
</body>
</html>
