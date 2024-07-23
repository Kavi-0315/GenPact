<%@ page import="javax.servlet.http.*, java.sql.*, java.util.*" %>
<%
    if (session == null || session.getAttribute("userid") == null) {
        response.sendRedirect("AssociateLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reports</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            const userId = document.getElementById("userId").value;
            drawPieChart(userId);
            drawWeeklyChart(userId);
            drawMonthlyChart(userId);
        }

        function drawPieChart(userId) {
            fetch('chartData2?type=pie&userid=' + userId, { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Task', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Tasks Breakdown' };
                    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }

        function drawWeeklyChart(userId) {
            fetch('chartData2?type=weekly&userid=' + userId, { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Week', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Weekly Work Analysis' };
                    var chart = new google.visualization.ColumnChart(document.getElementById('weeklychart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }

        function drawMonthlyChart(userId) {
            fetch('chartData2?type=monthly&userid=' + userId, { credentials: 'include' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    var dataTable = google.visualization.arrayToDataTable([
                        ['Month', 'Total Time'],
                        ...data
                    ]);

                    var options = { title: 'Monthly Work Analysis' };
                    var chart = new google.visualization.ColumnChart(document.getElementById('monthlychart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                });
        }
    </script>
<style>
        /* Reset some default styles */
        body, h1, label, input, button {
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
            min-height: 100vh;
            text-align: center;
            padding: 20px;
            overflow-x: hidden;
        }

        h1 {
            color: #ecf0f1;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
            animation: fadeIn 1s ease-out;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        form {
            margin-bottom: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            max-width: 400px;
            background: #1e272e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            animation: slideIn 1s ease-out;
        }

        label {
            font-size: 18px;
            color: #ecf0f1;
            margin-bottom: 10px;
            text-align: left;
            width: 100%;
        }

        input[type="number"] {
            padding: 10px;
            border: 2px solid #3498db;
            border-radius: 5px;
            font-size: 16px;
            background: #1e272e;
            color: #ecf0f1;
            margin-bottom: 20px;
            width: 100%;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background: #2ecc71;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        button:hover {
            background: #27ae60;
            transform: scale(1.05);
        }

        #piechart, #weeklychart, #monthlychart {
            width: 100%;
            max-width: 900px;
            height: 500px;
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease-out;
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

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
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
    <h1>Work Analysis Reports</h1>
    <form onsubmit="event.preventDefault(); drawChart();">
        <label for="userId">User ID:</label>
        <input type="number" id="userId" name="userId" required>
        <button type="submit">View Reports</button>
    </form>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
    <div id="weeklychart" style="width: 900px; height: 500px;"></div>
    <div id="monthlychart" style="width: 900px; height: 500px;"></div>
</body>
</html>
