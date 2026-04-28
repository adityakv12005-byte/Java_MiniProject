<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Reservation - Hotel Management</title>
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
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        
        input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        button {
            width: 100%;
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.2s;
        }
        
        button:hover {
            transform: translateY(-2px);
        }
        
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
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
        
        .search-box {
            background: #f7fafc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            border: 2px solid #e0e0e0;
        }
        
        .search-box button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin-top: 10px;
        }
        
        hr {
            margin: 20px 0;
            border: none;
            border-top: 2px solid #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>✏️ Update Reservation</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="search-box">
            <form action="updateReservation" method="get">
                <div class="form-group">
                    <label>Enter Reservation ID to Update:</label>
                    <input type="number" name="id" placeholder="Reservation ID" required>
                </div>
                <button type="submit">🔍 Search Reservation</button>
            </form>
        </div>
        
        <% 
        Reservation reservation = (Reservation) request.getAttribute("reservation");
        if(reservation != null) {
        %>
            <hr>
            <form action="updateReservation" method="post">
                <input type="hidden" name="reservationID" value="<%= reservation.getReservationID() %>">
                
                <div class="form-group">
                    <label>Customer Name:</label>
                    <input type="text" name="customerName" value="<%= reservation.getCustomerName() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Room Number:</label>
                    <input type="text" name="roomNumber" value="<%= reservation.getRoomNumber() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Check-in Date:</label>
                    <input type="date" name="checkIn" value="<%= reservation.getFormattedCheckIn() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Check-out Date:</label>
                    <input type="date" name="checkOut" value="<%= reservation.getFormattedCheckOut() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Total Amount ($):</label>
                    <input type="number" step="0.01" name="totalAmount" value="<%= reservation.getTotalAmount() %>" required>
                </div>
                
                <button type="submit">💾 Update Reservation</button>
            </form>
        <% } %>
        
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>
</body>
</html>