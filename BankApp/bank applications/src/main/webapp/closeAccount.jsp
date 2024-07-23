<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
</head>
<body>
    <h1>Close Account</h1>
    <form action="CloseAccountServlet" method="post">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="Close Account">
    </form>
</body>
</html>
