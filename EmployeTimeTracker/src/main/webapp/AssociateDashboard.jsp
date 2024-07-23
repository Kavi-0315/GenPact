<!DOCTYPE html>
<html>
<head>
    <title>Associate Dashboard</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #2c3e50, #34495e);
        color: #ecf0f1;
        display: flex;
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
        max-width: 600px;
        width: 100%;
        animation: fadeIn 1s ease-out;
    }

    h2 {
        margin-bottom: 20px;
        font-size: 28px;
        font-weight: 600;
    }

    .nav-links {
        margin-bottom: 20px;
    }

    .nav-links a {
        display: inline-block;
        margin: 10px;
        padding: 10px 20px;
        background: #3498db;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        transition: background 0.3s, transform 0.3s;
    }

    .nav-links a:hover {
        background: #2980b9;
        transform: scale(1.05);
    }

    .logout a {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background: #e74c3c;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        transition: background 0.3s, transform 0.3s;
    }

    .logout a:hover {
        background: #c0392b;
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
    <div class="container">
        <h2>Associate Dashboard</h2>
        <div class="nav-links">
            <a href="work.jsp"> Task Management</a>
            <a href="viewReportsAssociate.jsp">View Reports</a>
            <!-- Add more associate-specific functionalities here -->
        </div>
        <div class="logout">
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</body>
</html>
