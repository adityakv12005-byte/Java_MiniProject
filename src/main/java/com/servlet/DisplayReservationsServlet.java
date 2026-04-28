package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/displayReservations")
public class DisplayReservationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        System.out.println("DisplayReservationsServlet initialized at /displayReservations");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DisplayReservationsServlet: Fetching all reservations");
        
        try {
            // Get success message if any
            String success = request.getParameter("success");
            if (success != null) {
                String message = "";
                switch(success) {
                    case "added":
                        message = "✅ Reservation added successfully!";
                        break;
                    case "updated":
                        message = "✅ Reservation updated successfully!";
                        break;
                    case "deleted":
                        message = "✅ Reservation deleted successfully!";
                        break;
                }
                request.setAttribute("successMessage", message);
            }
            
            // Get all reservations
            List<Reservation> reservations = reservationDAO.getAllReservations();
            System.out.println("Found " + reservations.size() + " reservations");
            request.setAttribute("reservations", reservations);
            
            // Forward to JSP
            request.getRequestDispatcher("/reservationdisplay.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in DisplayReservationsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error fetching reservations: " + e.getMessage());
            request.getRequestDispatcher("/reservationdisplay.jsp").forward(request, response);
        }
    }
}