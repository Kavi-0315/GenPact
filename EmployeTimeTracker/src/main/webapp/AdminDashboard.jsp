<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
    /* Reset some default styles */
body, h2, a {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    color: #ecf0f1;
}

.container {
    background: rgba(44, 62, 80, 0.9);
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    padding: 20px;
    max-width: 400px;
    width: 100%;
    text-align: center;
    animation: fadeIn 1s ease-out;
}

h2 {
    color: #ecf0f1;
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: 600;
    animation: slideInFromTop 1s ease-out;
}

.nav-links {
    margin-bottom: 20px;
}

.nav-links a {
    display: block;
    padding: 10px 15px;
    margin: 10px 0;
    text-decoration: none;
    color: #3498db;
    background: #1e272e;
    border-radius: 5px;
    font-size: 18px;
    font-weight: 500;
    transition: background 0.3s, transform 0.3s;
}

.nav-links a:hover {
    background: #2ecc71;
    color: #fff;
    transform: scale(1.05);
}

.logout {
    margin-top: 20px;
}

.logout a {
    text-decoration: none;
    color: #e74c3c;
    font-size: 16px;
    font-weight: 600;
    transition: color 0.3s;
}

.logout a:hover {
    color: #c0392b;
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

@keyframes slideInFromTop {
    from {
        transform: translateY(-20px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
    </style>
    
</head>
<body>
    <div class="container">
        <h2>Admin Dashboard</h2>
        <div class="nav-links">
        	<a href="taskEdit.jsp">Task Management</a>
            <a href="viewReportsAdmin.jsp">View Reports</a>
        </div>
        <div class="logout">
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</body>
</html>
