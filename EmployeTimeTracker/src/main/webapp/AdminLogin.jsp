<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #2c3e50, #34495e);
        color: #ecf0f1;
        display: flex;
        flex-direction:column;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        background: rgba(44, 62, 80, 0.9);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        text-align: center;
        max-width: 400px;
        width: 100%;
        animation: fadeIn 1s ease-out;
    }

    h2 {
        margin-bottom: 20px;
        font-size: 28px;
        font-weight: 600;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    form input[type="text"],
    form input[type="password"] {
        margin-bottom: 10px;
        padding: 10px;
        width: 100%;
        max-width: 300px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    form input[type="submit"] {
        padding: 10px 20px;
        background: #3498db;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s, transform 0.3s;
    }

    form input[type="submit"]:hover {
        background: #2980b9;
        transform: scale(1.05);
    }

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
    <h2>Admin Login</h2>
    <form action="AdminLoginServlet" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
