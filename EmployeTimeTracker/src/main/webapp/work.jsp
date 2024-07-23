<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page session="true" %>
<%
    if (session == null || session.getAttribute("userid") == null) {
        response.sendRedirect("AssociateLogin.jsp");
        return;
    }

    Long startTime = (Long) session.getAttribute("startTime");
    Long currentTime = System.currentTimeMillis();
    Long elapsedTime = startTime != null ? currentTime - startTime : 0L;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Work Tracker</title>
    <style>
      body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: #ecf0f1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    text-align: center;
    padding: 20px;
    overflow-x: hidden;
}

.container {
    width: 100%;
    max-width: 600px;
    background: #1e272e;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
    padding: 20px;
    margin: 20px;
}

h2 {
    color: #ecf0f1;
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: 600;
}

select, button {
    padding: 10px 15px;
    margin: 10px;
    font-size: 16px;
    border-radius: 5px;
    border: none;
}

select {
    background: #34495e;
    color: #ecf0f1;
}

button {
    background: #3498db;
    color: #ecf0f1;
    cursor: pointer;
    transition: background 0.3s;
}

button:hover {
    background: #2980b9;
}

#timer {
    font-size: 24px;
    margin: 20px;
    background: #34495e;
    padding: 10px;
    border-radius: 5px;
}

    </style>
    <script>
        var timer;
        var startTime = <%= startTime != null ? startTime : "null" %>;
        var elapsedTime = <%= elapsedTime %>;

        function startTimer() {
            if (!startTime) {
                startTime = new Date().getTime();
                elapsedTime = 0;
                <% session.setAttribute("startTime", new java.util.Date().getTime()); %>
            }
            timer = setInterval(updateTimer, 1000);
            document.getElementById("startButton").disabled = true;
            document.getElementById("stopButton").disabled = false;
        }

        function updateTimer() {
            var currentTime = new Date().getTime();
            var totalElapsedTime = currentTime - startTime + elapsedTime;
            var seconds = Math.floor((totalElapsedTime / 1000) % 60);
            var minutes = Math.floor((totalElapsedTime / (1000 * 60)) % 60);
            var hours = Math.floor((totalElapsedTime / (1000 * 60 * 60)) % 24);

            document.getElementById("timer").innerHTML = 
                (hours < 10 ? "0" + hours : hours) + ":" +
                (minutes < 10 ? "0" + minutes : minutes) + ":" +
                (seconds < 10 ? "0" + seconds : seconds);
        }

        function stopTimer() {
            clearInterval(timer);
            document.getElementById("endTime").value = new Date().getTime();
            document.getElementById("workForm").submit();
        }
    </script>
</head>
<body onload="if (startTime) startTimer()">
    <div class="container">
        <h2>Work Tracker</h2>
   <form id="workForm" action="AssociateWorkServlet" method="post">
    <input type="hidden" name="startTime" value="<%= session.getAttribute("startTime") != null ? session.getAttribute("startTime") : new java.util.Date().getTime() %>">
    <input type="hidden" id="endTime" name="endTime" value="">
    <select name="taskId" required>
        <option value="" disabled selected>Select a Task</option>
        <% 
            // Retrieve tasks from the database
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/EmployeeTimeTracker", "root", "Kavi@1503");
                ps = con.prepareStatement("SELECT id, taskName FROM tasksManagement");
                rs = ps.executeQuery();
                while(rs.next()) {
        %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("taskName") %></option>
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
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
    </select>
    <br>
    <button type="button" id="startButton" onclick="startTimer()">Start</button>
    <button type="button" id="stopButton" onclick="stopTimer()" disabled>Stop</button>
</form>

        <div id="timer">00:00:00</div>
    </div>
</body>
</html>
