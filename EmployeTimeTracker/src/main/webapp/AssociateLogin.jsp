<!DOCTYPE html>
<html>
<head>
    <title>Associate Login</title>
    <style> 
        body, h2, form, input {
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
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .container {
            text-align: center;
        }

        h2 {
            color: #ecf0f1;
            margin-bottom: 50px;
            font-size: 28px;
            font-weight: 600;
            animation: fadeIn 1s ease-out;
        }

        form {
            background: rgba(44, 62, 80, 0.9);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            padding: 20px;
            width: 300px;
            text-align: left;
            margin: 0 auto;
        }

        form input[type="text"], form input[type="password"] {
            margin: 10px 0;
            padding: 10px;
            width: calc(100% - 20px);
            border: 2px solid #3498db;
            border-radius: 5px;
            background: #1e272e;
            color: #ecf0f1;
            font-size: 16px;
        }

        form input[type="submit"] {
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            background: #2ecc71;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        form input[type="submit"]:hover {
            background: #27ae60;
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
    <h2>Associate Login</h2>
    <form action="AssociateLoginServlet" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
