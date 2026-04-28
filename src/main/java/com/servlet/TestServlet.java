package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>System Test</title></head>");
        out.println("<body>");
        out.println("<h1>Hotel Management System - Test Page</h1>");
        
        // Test 1: Servlet is working
        out.println("<h2>✅ Test 1: Servlet is working!</h2>");
        
        // Test 2: Database connection
        out.println("<h2>Test 2: Database Connection</h2>");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcURL = "jdbc:mysql://localhost:3306/hotel_management?useSSL=false&serverTimezone=UTC";
            String jdbcUsername = "root";
            String jdbcPassword = "password"; // Change this to your password
            
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            out.println("<p style='color:green'>✅ Database connected successfully!</p>");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM Reservations");
            if (rs.next()) {
                out.println("<p>Total reservations in database: " + rs.getInt("count") + "</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red'>❌ Database connection failed: " + e.getMessage() + "</p>");
        }
        
        // Test 3: Servlet mappings
        out.println("<h2>Test 3: Available URLs</h2>");
        out.println("<ul>");
        out.println("<li><a href='" + request.getContextPath() + "/addReservation'>/addReservation</a> (POST only)</li>");
        out.println("<li><a href='" + request.getContextPath() + "/updateReservation'>/updateReservation</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/deleteReservation'>/deleteReservation</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/displayReservations'>/displayReservations</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/generateReport'>/generateReport</a> (POST only)</li>");
        out.println("</ul>");
        
        out.println("<br><a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}