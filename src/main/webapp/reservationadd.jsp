<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Reservation - Hotel Management</title>
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
        
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        button {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            border-left: 4px solid #c33;
        }
        
        .info {
            background: #e3f2fd;
            color: #1976d2;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>➕ Add New Reservation</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="info">
            💡 Tip: Check-out date must be after check-in date
        </div>
        
        <form action="addReservation" method="post">
            <div class="form-group">
                <label>Customer Name:</label>
                <input type="text" name="customerName" placeholder="Enter full name" required>
            </div>
            
            <div class="form-group">
                <label>Room Number:</label>
                <input type="text" name="roomNumber" placeholder="e.g., 101, 102, 201" required>
            </div>
            
            <div class="form-group">
                <label>Check-in Date:</label>
                <input type="date" name="checkIn" required>
            </div>
            
            <div class="form-group">
                <label>Check-out Date:</label>
                <input type="date" name="checkOut" required>
            </div>
            
            <div class="form-group">
                <label>Total Amount ($):</label>
                <input type="number" step="0.01" name="totalAmount" placeholder="0.00" required>
            </div>
            
            <button type="submit">Add Reservation</button>
        </form>
        
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>
    
    <script>
        // Set minimum dates
        const today = new Date().toISOString().split('T')[0];
        document.querySelector('input[name="checkIn"]').min = today;
        document.querySelector('input[name="checkOut"]').min = today;
        
        // Validate check-out date is after check-in
        const checkIn = document.querySelector('input[name="checkIn"]');
        const checkOut = document.querySelector('input[name="checkOut"]');
        
        checkIn.addEventListener('change', function() {
            checkOut.min = this.value;
            if (checkOut.value && checkOut.value < this.value) {
                checkOut.value = this.value;
            }
        });
    </script>
</body>
</html>