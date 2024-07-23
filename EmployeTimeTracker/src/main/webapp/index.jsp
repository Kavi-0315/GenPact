<!DOCTYPE html>
<html>
<head>
    <title>Employee Time Tracker</title>
    <style type="text/css">/* Reset some default styles */
body, h2, a {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: #ecf0f1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    text-align: center;
    padding: 20px;
}

h2 {
    color: #ecf0f1;
    margin-bottom: 20px;
    font-size: 28px;
    font-weight: 600;
    animation: fadeIn 1s ease-out;
}

a {
    display: inline-block;
    padding: 10px 20px;
    text-decoration: none;
    color: #3498db;
    background: #1e272e;
    border-radius: 5px;
    font-size: 18px;
    font-weight: 500;
    margin: 10px;
    transition: background 0.3s, color 0.3s, transform 0.3s;
}

a:hover {
    background: #3498db;
    color: #fff;
    transform: scale(1.05);
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
    </style>
</head>
<body>
    <h2>Welcome to Employee Time Tracker</h2>
    <a href="AdminLogin.jsp">Admin Login</a><br>
    <a href="AssociateLogin.jsp">Associate Login</a>
</body>
</html>
