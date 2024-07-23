<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management</title>
    <style>
/* Reset some default styles */
body, h2, form, table, th, td {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: #ecf0f1;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    padding: 20px;
}

.container {
    background: rgba(44, 62, 80, 0.9);
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    padding: 20px;
    width: 80%;
    max-width: 900px;
}

h2 {
    color: #ecf0f1;
    text-align: center;
    margin-bottom: 30px;
    font-size: 28px;
    font-weight: 600;
    animation: fadeIn 1s ease-out;
}

.task-form {
    margin-bottom: 20px;
    text-align: center;
}

.task-form input, .task-form button {
    margin: 10px 0;
    padding: 10px;
    width: 100%;
    max-width: 300px;
    border-radius: 5px;
    border: 2px solid #3498db;
    background: #1e272e;
    color: #ecf0f1;
    font-size: 16px;
}

.task-form button {
    background: #2ecc71;
    border: none;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s, transform 0.3s;
}

.task-form button:hover {
    background: #27ae60;
    transform: scale(1.05);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table, th, td {
    border: 1px solid #34495e;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background: #1e272e;
    color: #ecf0f1;
}

td {
    background: #34495e;
}

.actions {
    display: flex;
    justify-content: center;
}

.actions form {
    margin: 0 5px;
}

.actions button {
    background: #e74c3c;
    border: none;
    color: #fff;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s, transform 0.3s;
}

.actions button:hover {
    background: #c0392b;
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
    <div class="container">
        <h2>Task Management</h2>
        <form class="task-form" action="AdminTaskServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="taskName" placeholder="Task Name" required>
            <button type="submit">Add Task</button>
        </form>
        <table>
            <tr>
                <th>ID</th>
                <th>Task Name</th>
                <th>Actions</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/EmployeeTimeTracker", "root", "Kavi@1503");
                    ps = con.prepareStatement("SELECT * FROM tasksManagement");
                    rs = ps.executeQuery();
                    if (!rs.isBeforeFirst()) { // If no data is returned
                        out.println("<tr><td colspan='3'>No tasks found.</td></tr>");
                    } else {
                        while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("taskName") %></td>
                <td class="actions">
                    <form action="AdminTaskServlet" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="taskId" value="<%= rs.getInt("id") %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                        }
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    try {
                        if(rs != null) rs.close();
                        if(ps != null) ps.close();
                        if(con != null) con.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
