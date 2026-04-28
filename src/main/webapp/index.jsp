<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hotel Management System</title>
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
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            color: white;
            padding: 50px 0 30px;
        }
        
        .header h1 {
            font-size: 48px;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        
        .header p {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 40px;
        }
        
        .menu-card {
            background: white;
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        
        .menu-card .icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        
        .menu-card h3 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 22px;
        }
        
        .menu-card p {
            color: #666;
            font-size: 14px;
        }
        
        .footer {
            text-align: center;
            color: white;
            margin-top: 50px;
            padding: 20px;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .header h1 { font-size: 32px; }
            .menu { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏨 Hotel Management System</h1>
            <p>Efficiently manage reservations, track occupancy, and generate reports</p>
        </div>
        
        <div class="menu">
            <a href="reservationadd.jsp" class="menu-card">
                <div class="icon">➕</div>
                <h3>Add Reservation</h3>
                <p>Create new booking for guests</p>
            </a>
            
            <a href="reservationupdate.jsp" class="menu-card">
                <div class="icon">✏️</div>
                <h3>Update Reservation</h3>
                <p>Modify existing booking details</p>
            </a>
            
            <a href="reservationdelete.jsp" class="menu-card">
                <div class="icon">🗑️</div>
                <h3>Cancel Reservation</h3>
                <p>Cancel booking by ID</p>
            </a>
            
            <a href="displayReservations" class="menu-card">
                <div class="icon">📋</div>
                <h3>View All Reservations</h3>
                <p>Display all current bookings</p>
            </a>
            
            <a href="reports.jsp" class="menu-card">
                <div class="icon">📊</div>
                <h3>Reports</h3>
                <p>Generate various reports</p>
            </a>
        </div>
        
        <div class="footer">
            <p>Hotel Management System © 2024 | All Rights Reserved</p>
        </div>
    </div>
</body>
</html>