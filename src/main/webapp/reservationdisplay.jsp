<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.text.DecimalFormat,com.model.Reservation" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Reservations - Hotel Management</title>

<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
font-family:Arial, Helvetica, sans-serif;
background:linear-gradient(135deg,#4facfe,#00f2fe);
min-height:100vh;
padding:30px;
}

.container{
width:95%;
max-width:1300px;
margin:auto;
background:white;
padding:30px;
border-radius:15px;
box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

h1{
text-align:center;
color:#333;
margin-bottom:10px;
}

.subtitle{
text-align:center;
color:#666;
margin-bottom:25px;
font-size:16px;
}

.message{
padding:12px;
border-radius:6px;
margin-bottom:15px;
text-align:center;
font-weight:bold;
}

.success{
background:#d4edda;
color:#155724;
border-left:5px solid green;
}

.error{
background:#f8d7da;
color:#721c24;
border-left:5px solid red;
}

.stats{
display:flex;
gap:15px;
margin-bottom:25px;
flex-wrap:wrap;
}

.card{
flex:1;
min-width:220px;
background:#f8f9fa;
padding:18px;
border-radius:10px;
text-align:center;
border:1px solid #ddd;
}

.card h2{
color:#007bff;
font-size:28px;
margin-bottom:5px;
}

.card p{
color:#555;
font-size:14px;
}

.table-box{
overflow-x:auto;
}

table{
width:100%;
border-collapse:collapse;
margin-top:10px;
}

th{
background:#007bff;
color:white;
padding:12px;
text-align:center;
}

td{
padding:10px;
border-bottom:1px solid #ddd;
text-align:center;
}

tr:nth-child(even){
background:#f9f9f9;
}

tr:hover{
background:#eef7ff;
}

.btn{
padding:6px 12px;
text-decoration:none;
color:white;
border-radius:5px;
font-size:13px;
margin:2px;
display:inline-block;
}

.edit{
background:#28a745;
}

.delete{
background:#dc3545;
}

.home{
display:inline-block;
margin-top:25px;
padding:10px 18px;
background:#007bff;
color:white;
text-decoration:none;
border-radius:6px;
}

.home:hover{
background:#0056b3;
}

.no-data{
text-align:center;
padding:30px;
font-size:18px;
color:#777;
}
</style>

</head>
<body>

<div class="container">

<h1>Hotel Reservation Report</h1>
<div class="subtitle">View all customer reservations and booking details</div>

<% if(request.getAttribute("successMessage") != null){ %>
<div class="message success">
<%= request.getAttribute("successMessage") %>
</div>
<% } %>

<% if(request.getAttribute("error") != null){ %>
<div class="message error">
<%= request.getAttribute("error") %>
</div>
<% } %>

<%
List<Reservation> reservations =
(List<Reservation>)request.getAttribute("reservations");

DecimalFormat df = new DecimalFormat("0.00");

if(reservations != null && reservations.size() > 0){

double totalRevenue = 0;

for(Reservation r : reservations){
totalRevenue += r.getTotalAmount();
}

double average = totalRevenue / reservations.size();
%>

<div class="stats">

<div class="card">
<h2><%= reservations.size() %></h2>
<p>Total Reservations</p>
</div>

<div class="card">
<h2>₹ <%= df.format(totalRevenue) %></h2>
<p>Total Revenue</p>
</div>

<div class="card">
<h2>₹ <%= df.format(average) %></h2>
<p>Average Booking</p>
</div>

</div>

<div class="table-box">

<table>

<tr>
<th>ID</th>
<th>Customer Name</th>
<th>Room No</th>
<th>Check In</th>
<th>Check Out</th>
<th>Total Amount</th>
<th>Actions</th>
</tr>

<%
for(Reservation r : reservations){
%>

<tr>
<td><%= r.getReservationID() %></td>
<td><%= r.getCustomerName() %></td>
<td><%= r.getRoomNumber() %></td>
<td><%= r.getFormattedCheckIn() %></td>
<td><%= r.getFormattedCheckOut() %></td>
<td>₹ <%= df.format(r.getTotalAmount()) %></td>

<td>
<a href="updateReservation?id=<%= r.getReservationID() %>" class="btn edit">Edit</a>

<a href="deleteReservation?id=<%= r.getReservationID() %>"
class="btn delete"
onclick="return confirm('Delete this reservation?')">
Delete
</a>
</td>
</tr>

<%
}
%>

</table>

</div>

<%
}else{
%>

<div class="no-data">
No reservations available.<br><br>
<a href="reservationadd.jsp" class="home">Add Reservation</a>
</div>

<%
}
%>

<div style="text-align:center;">
<a href="index.jsp" class="home">Back to Home</a>
</div>

</div>

</body>
</html>