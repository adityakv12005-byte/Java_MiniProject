<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports - Hotel Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: #667eea;
            text-align: center;
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
        }
        
        .report-card {
            background: #f7fafc;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            transition: transform 0.2s;
            border: 2px solid #e0e0e0;
        }
        
        .report-card:hover {
            transform: translateX(5px);
            border-color: #667eea;
        }
        
        .report-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 600;
            font-size: 14px;
        }
        
        input, select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.2s;
        }
        
        button:hover {
            transform: translateY(-2px);
        }
        
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .error {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .icon {
            font-size: 24px;
            margin-right: 10px;
            vertical-align: middle;
        }
        
        @media (max-width: 768px) {
            .container { padding: 20px; }
            .report-card { padding: 15px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📊 Reports Dashboard</h2>
        <div class="subtitle">Generate insights and analytics</div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="report-card">
            <h3><span class="icon">📅</span> Reservations by Date Range</h3>
            <form action="generateReport" method="post">
                <input type="hidden" name="reportType" value="dateRange">
                <div class="form-group">
                    <label>Start Date:</label>
                    <input type="date" name="startDate" required>
                </div>
                <div class="form-group">
                    <label>End Date:</label>
                    <input type="date" name="endDate" required>
                </div>
                <button type="submit">Generate Report</button>
            </form>
        </div>
        
        <div class="report-card">
            <h3><span class="icon">🏆</span> Most Booked Rooms</h3>
            <p style="margin-bottom: 15px; color: #666;">View which rooms are most frequently booked by guests.</p>
            <form action="generateReport" method="post">
                <input type="hidden" name="reportType" value="mostBookedRooms">
                <button type="submit">View Rankings</button>
            </form>
        </div>
        
        <div class="report-card">
            <h3><span class="icon">💰</span> Revenue Report</h3>
            <form action="generateReport" method="post">
                <input type="hidden" name="reportType" value="revenue">
                <div class="form-group">
                    <label>Start Date:</label>
                    <input type="date" name="startDate" required>
                </div>
                <div class="form-group">
                    <label>End Date:</label>
                    <input type="date" name="endDate" required>
                </div>
                <button type="submit">Calculate Revenue</button>
            </form>
        </div>
        
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>
    
    <script>
        // Set default dates for date range (last 30 days)
        const today = new Date();
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(today.getDate() - 30);
        
        document.querySelectorAll('input[type="date"]').forEach(input => {
            if (!input.value) {
                if (input.name === 'startDate') {
                    input.value = thirtyDaysAgo.toISOString().split('T')[0];
                } else if (input.name === 'endDate') {
                    input.value = today.toISOString().split('T')[0];
                }
            }
        });
    </script>
</body>
</html>