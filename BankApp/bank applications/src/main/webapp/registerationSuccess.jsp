<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Success</title>
</head>
<body>
    <h2>Customer Registration Success</h2>
    <p>Account No: <%= request.getParameter("accountNo") %></p>
    <p>Temporary Password: <%= request.getParameter("tempPassword") %></p>
</body>
</html>
