package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        System.out.println("AddReservationServlet initialized successfully at /addReservation");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("AddReservationServlet: Processing new reservation");
        
        try {
            // Get parameters from form
            String customerName = request.getParameter("customerName");
            String roomNumber = request.getParameter("roomNumber");
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String totalAmountStr = request.getParameter("totalAmount");
            
            // Debug output
            System.out.println("Customer: " + customerName);
            System.out.println("Room: " + roomNumber);
            System.out.println("Check-in: " + checkInStr);
            System.out.println("Check-out: " + checkOutStr);
            System.out.println("Amount: " + totalAmountStr);
            
            // Validate input
            if (customerName == null || customerName.trim().isEmpty()) {
                throw new Exception("Customer name is required");
            }
            if (roomNumber == null || roomNumber.trim().isEmpty()) {
                throw new Exception("Room number is required");
            }
            if (checkInStr == null || checkOutStr == null) {
                throw new Exception("Check-in and Check-out dates are required");
            }
            
            // Parse dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = dateFormat.parse(checkInStr);
            Date checkOut = dateFormat.parse(checkOutStr);
            
            // Validate dates
            if (checkOut.before(checkIn)) {
                throw new Exception("Check-out date cannot be before check-in date");
            }
            
            double totalAmount = Double.parseDouble(totalAmountStr);
            if (totalAmount <= 0) {
                throw new Exception("Total amount must be greater than 0");
            }
            
            // Create reservation object
            Reservation reservation = new Reservation();
            reservation.setCustomerName(customerName);
            reservation.setRoomNumber(roomNumber);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);
            reservation.setTotalAmount(totalAmount);
            
            // Add to database
            boolean success = reservationDAO.addReservation(reservation);
            
            if (success) {
                System.out.println("Reservation added successfully for: " + customerName);
                response.sendRedirect(request.getContextPath() + "/displayReservations?success=added");
            } else {
                throw new Exception("Failed to add reservation to database");
            }
            
        } catch (Exception e) {
            System.err.println("Error in AddReservationServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error adding reservation: " + e.getMessage());
            request.getRequestDispatcher("/reservationadd.jsp").forward(request, response);
        }
    }
}