package com.dao;

import com.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    
    // UPDATE THESE WITH YOUR MYSQL CREDENTIALS
    private String jdbcURL = "jdbc:mysql://localhost:3306/hotel_management?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";  // Change this
    private String jdbcPassword = "root";  // Change this
    
    private static final String INSERT_RESERVATION = 
        "INSERT INTO Reservations (CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount) VALUES (?, ?, ?, ?, ?)";
    
    private static final String UPDATE_RESERVATION = 
        "UPDATE Reservations SET CustomerName=?, RoomNumber=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
    
    private static final String DELETE_RESERVATION = 
        "DELETE FROM Reservations WHERE ReservationID=?";
    
    private static final String SELECT_ALL_RESERVATIONS = 
        "SELECT * FROM Reservations ORDER BY CheckIn DESC";
    
    private static final String SELECT_RESERVATION_BY_ID = 
        "SELECT * FROM Reservations WHERE ReservationID=?";
    
    private static final String SELECT_RESERVATIONS_BY_DATE_RANGE = 
        "SELECT * FROM Reservations WHERE CheckIn BETWEEN ? AND ? ORDER BY CheckIn";
    
    private static final String SELECT_MOST_BOOKED_ROOMS = 
        "SELECT RoomNumber, COUNT(*) as BookingCount FROM Reservations GROUP BY RoomNumber ORDER BY BookingCount DESC LIMIT 5";
    
    private static final String SELECT_REVENUE_BY_DATE_RANGE = 
        "SELECT COALESCE(SUM(TotalAmount), 0) as TotalRevenue FROM Reservations WHERE CheckIn BETWEEN ? AND ?";
    
    public ReservationDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading MySQL Driver: " + e.getMessage());
        }
    }
    
    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
    
    public boolean addReservation(Reservation reservation) throws SQLException {
        boolean success = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESERVATION)) {
            
            preparedStatement.setString(1, reservation.getCustomerName());
            preparedStatement.setString(2, reservation.getRoomNumber());
            preparedStatement.setDate(3, new java.sql.Date(reservation.getCheckIn().getTime()));
            preparedStatement.setDate(4, new java.sql.Date(reservation.getCheckOut().getTime()));
            preparedStatement.setDouble(5, reservation.getTotalAmount());
            
            int rowsAffected = preparedStatement.executeUpdate();
            success = rowsAffected > 0;
        }
        return success;
    }
    
    public boolean updateReservation(Reservation reservation) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RESERVATION)) {
            
            preparedStatement.setString(1, reservation.getCustomerName());
            preparedStatement.setString(2, reservation.getRoomNumber());
            preparedStatement.setDate(3, new java.sql.Date(reservation.getCheckIn().getTime()));
            preparedStatement.setDate(4, new java.sql.Date(reservation.getCheckOut().getTime()));
            preparedStatement.setDouble(5, reservation.getTotalAmount());
            preparedStatement.setInt(6, reservation.getReservationID());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    public boolean deleteReservation(int reservationID) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_RESERVATION)) {
            
            preparedStatement.setInt(1, reservationID);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    
    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_RESERVATIONS)) {
            
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        }
        return reservations;
    }
    
    public Reservation getReservationById(int reservationID) throws SQLException {
        Reservation reservation = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATION_BY_ID)) {
            
            preparedStatement.setInt(1, reservationID);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                reservation = extractReservationFromResultSet(rs);
            }
        }
        return reservation;
    }
    
    public List<Reservation> getReservationsByDateRange(String startDate, String endDate) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATIONS_BY_DATE_RANGE)) {
            
            preparedStatement.setString(1, startDate);
            preparedStatement.setString(2, endDate);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        }
        return reservations;
    }
    
    public List<Object[]> getMostBookedRooms() throws SQLException {
        List<Object[]> rooms = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MOST_BOOKED_ROOMS)) {
            
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Object[] room = new Object[2];
                room[0] = rs.getString("RoomNumber");
                room[1] = rs.getInt("BookingCount");
                rooms.add(room);
            }
        }
        return rooms;
    }
    
    public double getRevenueByDateRange(String startDate, String endDate) throws SQLException {
        double revenue = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_REVENUE_BY_DATE_RANGE)) {
            
            preparedStatement.setString(1, startDate);
            preparedStatement.setString(2, endDate);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("TotalRevenue");
            }
        }
        return revenue;
    }
    
    private Reservation extractReservationFromResultSet(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setReservationID(rs.getInt("ReservationID"));
        reservation.setCustomerName(rs.getString("CustomerName"));
        reservation.setRoomNumber(rs.getString("RoomNumber"));
        reservation.setCheckIn(rs.getDate("CheckIn"));
        reservation.setCheckOut(rs.getDate("CheckOut"));
        reservation.setTotalAmount(rs.getDouble("TotalAmount"));
        return reservation;
    }
}