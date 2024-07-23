<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Header File</title>
</head>
<body>
       <div class="container">
        <h1>Welcome to Bank Application</h1>
        <div class="link-container">
            <a href="${pageContext.request.contextPath}/Admin/adminLogin.jsp" class="button">Admin</a>
            <a href="${pageContext.request.contextPath}/Customer/customerLogin.jsp" class="button">Customer</a>
        </div>
    </div>

</body>
</html>