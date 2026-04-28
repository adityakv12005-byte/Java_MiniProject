<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancel Reservation - Hotel Management</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:Arial, sans-serif;
            background:linear-gradient(135deg,#667eea,#764ba2);
            min-height:100vh;
            padding:40px 20px;
        }

        .container{
            max-width:500px;
            margin:auto;
            background:white;
            padding:40px;
            border-radius:20px;
            box-shadow:0 10px 30px rgba(0,0,0,0.2);
        }

        h2{
            text-align:center;
            color:#667eea;
            margin-bottom:30px;
        }

        label{
            font-weight:bold;
            display:block;
            margin-bottom:10px;
        }

        input{
            width:100%;
            padding:12px;
            border:2px solid #ddd;
            border-radius:8px;
            margin-bottom:20px;
        }

        button{
            width:100%;
            padding:14px;
            border:none;
            border-radius:8px;
            background:#e53e3e;
            color:white;
            font-size:16px;
            cursor:pointer;
        }

        button:hover{
            background:#c53030;
        }

        .back{
            display:block;
            text-align:center;
            margin-top:20px;
            text-decoration:none;
            color:#667eea;
            font-weight:bold;
        }

        .error{
            background:#ffe5e5;
            color:red;
            padding:10px;
            border-radius:8px;
            margin-bottom:20px;
            text-align:center;
        }
    </style>

    <script>
        function confirmDelete(){
            return confirm("Are you sure you want to cancel this reservation?");
        }
    </script>

</head>

<body>

<div class="container">

    <h2>Cancel Reservation</h2>

    <% if(request.getAttribute("error") != null){ %>
        <div class="error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="deleteReservation" method="get" onsubmit="return confirmDelete()">
        <label>Enter Reservation ID:</label>
        <input type="number" name="id" required>

        <button type="submit">Cancel Reservation</button>
    </form>

    <a href="index.jsp" class="back">← Back to Home</a>

</div>

</body>
</html>