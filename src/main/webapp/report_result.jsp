<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Result - Hotel Management</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: #667eea;
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        tr:hover {
            background: #f7fafc;
        }
        
        .back-link {
            display: inline-block;
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
        
        .revenue-box {
            text-align: center;
            padding: 50px;
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-radius: 15px;
            margin: 30px 0;
        }
        
        .revenue-amount {
            font-size: 64px;
            color: #48bb78;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .revenue-label {
            font-size: 18px;
            color: #666;
        }
        
        .ranking-card {
            display: inline-block;
            width: 200px;
            margin: 10px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 10px;
            text-align: center;
        }
        
        .ranking-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
        }
        
        .ranking-room {
            font-size: 20px;
            margin: 10px 0;
        }
        
        .ranking-count {
            color: #666;
        }
        
        .print-btn {
            background: #48bb78;
            margin-left: 10px;
        }
        
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        
        button {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 5px;
        }
        
        button:hover {
            opacity: 0.9;
        }
        
        @media print {
            body {
                background: white;
                padding: 0;
            }
            .button-group, .back-link {
                display: none;
            }
            .container {
                box-shadow: none;
                padding: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📈 Report Result</h2>
        <div class="subtitle"><%= request.getAttribute("reportTitle") %></div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <%-- Date Range Report --%>
        <% if(request.getAttribute("reservations") != null) { 
            List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
            if(reservations != null && !reservations.isEmpty()) {
                double total = 0;
                for(Reservation r : reservations) {
                    total += r.getTotalAmount();
                }
        %>
            <div style="margin-bottom: 20px; padding: 15px; background: #f7fafc; border-radius: 10px;">
                <strong>Summary:</strong> Found <%= reservations.size() %> reservation(s) | Total Revenue: $<%= String.format("%.2f", total) %>
            </div>
            
            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Room Number</th>
                            <th>Check-in Date</th>
                            <th>Check-out Date</th>
                            <th>Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Reservation r : reservations) { %>
                        <tr>
                            <td><%= r.getReservationID() %></td>
                            <td><%= r.getCustomerName() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= r.getFormattedCheckIn() %></td>
                            <td><%= r.getFormattedCheckOut() %></td>
                            <td>$<%= String.format("%.2f", r.getTotalAmount()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="error">No reservations found in this date range.</div>
        <% } %>
        
        <%-- Most Booked Rooms Report --%>
        <% } else if(request.getAttribute("rooms") != null) { 
            List<Object[]> rooms = (List<Object[]>) request.getAttribute("rooms");
            if(rooms != null && !rooms.isEmpty()) {
        %>
            <div style="text-align: center; margin: 30px 0;">
                <% for(int i = 0; i < rooms.size(); i++) { 
                    Object[] room = rooms.get(i);
                %>
                    <div class="ranking-card">
                        <div class="ranking-number">#<%= i + 1 %></div>
                        <div class="ranking-room">Room <%= room[0] %></div>
                        <div class="ranking-count">Booked <%= room[1] %> time(s)</div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="error">No booking data available.</div>
        <% } %>
        
        <%-- Revenue Report --%>
        <% } else if(request.getAttribute("revenue") != null) { 
            double revenue = (Double) request.getAttribute("revenue");
            String startDate = (String) request.getAttribute("startDate");
            String endDate = (String) request.getAttribute("endDate");
        %>
            <div class="revenue-box">
                <div class="revenue-amount">$<%= String.format("%.2f", revenue) %></div>
                <div class="revenue-label">Total Revenue from <%= startDate %> to <%= endDate %></div>
            </div>
        <% } %>
        
        <div class="button-group">
            <button onclick="window.print()">🖨️ Print Report</button>
        </div>
        
        <div style="text-align: center;">
            <a href="reports.jsp" class="back-link">← Back to Reports</a>
        </div>
    </div>
</body>
</html>