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

@WebServlet("/generateReport")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        System.out.println("ReportServlet initialized at /generateReport");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String reportType = request.getParameter("reportType");
            System.out.println("ReportServlet: Generating report - " + reportType);
            
            if ("dateRange".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                System.out.println("Date range: " + startDate + " to " + endDate);
                
                List<Reservation> reservations = reservationDAO.getReservationsByDateRange(startDate, endDate);
                request.setAttribute("reservations", reservations);
                request.setAttribute("reportTitle", "Reservations from " + startDate + " to " + endDate);
                
            } else if ("mostBookedRooms".equals(reportType)) {
                System.out.println("Getting most booked rooms");
                
                List<Object[]> rooms = reservationDAO.getMostBookedRooms();
                request.setAttribute("rooms", rooms);
                request.setAttribute("reportTitle", "Most Frequently Booked Rooms");
                
            } else if ("revenue".equals(reportType)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                
                System.out.println("Revenue report: " + startDate + " to " + endDate);
                
                double revenue = reservationDAO.getRevenueByDateRange(startDate, endDate);
                request.setAttribute("revenue", revenue);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.setAttribute("reportTitle", "Revenue Report");
            }
            
            request.getRequestDispatcher("/report_result.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in ReportServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error generating report: " + e.getMessage());
            request.getRequestDispatcher("/reports.jsp").forward(request, response);
        }
    }
}