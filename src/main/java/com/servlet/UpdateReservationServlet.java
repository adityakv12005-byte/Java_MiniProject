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

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        System.out.println("UpdateReservationServlet initialized at /updateReservation");
    }
    
    // Handle GET request - Show form with existing data
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("UpdateReservationServlet: Processing GET request");
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/displayReservations");
                return;
            }
            
            int reservationID = Integer.parseInt(idParam);
            System.out.println("Fetching reservation with ID: " + reservationID);
            
            Reservation reservation = reservationDAO.getReservationById(reservationID);
            
            if (reservation != null) {
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/reservationupdate.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Reservation not found with ID: " + reservationID);
                request.getRequestDispatcher("/reservationupdate.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in UpdateReservationServlet GET: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error fetching reservation: " + e.getMessage());
            request.getRequestDispatcher("/reservationupdate.jsp").forward(request, response);
        }
    }
    
    // Handle POST request - Update reservation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("UpdateReservationServlet: Processing POST request");
        
        try {
            // Get parameters
            int reservationID = Integer.parseInt(request.getParameter("reservationID"));
            String customerName = request.getParameter("customerName");
            String roomNumber = request.getParameter("roomNumber");
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            
            System.out.println("Updating reservation ID: " + reservationID);
            
            // Parse dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = dateFormat.parse(checkInStr);
            Date checkOut = dateFormat.parse(checkOutStr);
            
            // Create reservation object
            Reservation reservation = new Reservation();
            reservation.setReservationID(reservationID);
            reservation.setCustomerName(customerName);
            reservation.setRoomNumber(roomNumber);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);
            reservation.setTotalAmount(totalAmount);
            
            // Update in database
            boolean updated = reservationDAO.updateReservation(reservation);
            
            if (updated) {
                System.out.println("Reservation updated successfully: ID=" + reservationID);
                response.sendRedirect(request.getContextPath() + "/displayReservations?success=updated");
            } else {
                throw new Exception("Reservation not found or update failed");
            }
            
        } catch (Exception e) {
            System.err.println("Error in UpdateReservationServlet POST: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error updating reservation: " + e.getMessage());
            request.getRequestDispatcher("/reservationupdate.jsp").forward(request, response);
        }
    }
}