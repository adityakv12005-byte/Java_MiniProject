package com.servlet;

import com.dao.ReservationDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        System.out.println("DeleteReservationServlet initialized at /deleteReservation");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DeleteReservationServlet: Processing deletion request");
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/displayReservations");
                return;
            }
            
            int reservationID = Integer.parseInt(idParam);
            System.out.println("Attempting to delete reservation ID: " + reservationID);
            
            boolean deleted = reservationDAO.deleteReservation(reservationID);
            
            if (deleted) {
                System.out.println("Reservation deleted successfully: ID=" + reservationID);
                response.sendRedirect(request.getContextPath() + "/displayReservations?success=deleted");
            } else {
                request.setAttribute("error", "Reservation not found with ID: " + reservationID);
                request.getRequestDispatcher("/reservationdelete.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in DeleteReservationServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error deleting reservation: " + e.getMessage());
            request.getRequestDispatcher("/reservationdelete.jsp").forward(request, response);
        }
    }
}