<%@ page import="javax.servlet.http.*, java.sql.*, java.util.*" %>
<%
  
    if (session == null || session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
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
            drawPieChart();
            drawWeeklyChart();
            drawMonthlyChart();
        }

        function drawPieChart() {
            fetch('chartData?type=pie', { credentials: 'include' })
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

        function drawWeeklyChart() {
            fetch('chartData?type=weekly', { credentials: 'include' })
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

        function drawMonthlyChart() {
            fetch('chartData?type=monthly', { credentials: 'include' })
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
    body, h1, div {
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
    justify-content: flex-start;
    min-height: 100vh;
    text-align: center;
    padding: 20px;
    overflow-x: hidden;
    overflow-y: auto;
}

h1 {
    color: #ecf0f1;
    margin-bottom: 20px;
    font-size: 28px;
    font-weight: 600;
    animation: fadeIn 1s ease-out;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.chart-container {
    width: 100%;
    max-width: 900px;
    height: 500px;
    margin: 20px 0;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    animation: fadeIn 1s ease-out;
    background: #1e272e;
    display: flex;
    align-items: center;
    justify-content: center;
}

.piechart-box {
    border: 2px solid #3498db;
}

.weeklychart-box {
    border: 2px solid #e74c3c;
}

.monthlychart-box {
    border: 2px solid #2ecc71;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
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
    </style>
</head>
<body>
    <h1>Work Analysis Reports</h1>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
    <div id="weeklychart" style="width: 900px; height: 500px;"></div>
    <div id="monthlychart" style="width: 900px; height: 500px;"></div>
</body>
</html>
