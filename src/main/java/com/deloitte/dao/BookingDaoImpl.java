package com.deloitte.dao;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.deloitte.dto.FlightSummaryDto;
import com.deloitte.model.Booking;

@Repository
public class BookingDaoImpl implements BookingDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<Booking> bookingRowMapper = (rs, rowNum) -> {
		Booking b = new Booking();
		b.setBookingId(rs.getLong("booking_id"));
		b.setBookingDate(rs.getString("booking_date"));
		b.setJourneyDate(rs.getString("journey_date"));
		b.setSeats(rs.getInt("seats"));
		b.setTotalPrice(rs.getDouble("total_price"));
		b.setStatus(rs.getString("status"));
		b.setFlightId(rs.getLong("flight_id"));
		b.setUserId(rs.getLong("user_id"));
		try {
			b.setFlightNumber(rs.getString("flight_number"));
			b.setSource(rs.getString("source"));
			b.setDestination(rs.getString("destination"));
		} catch (Exception ignored) {
		}
		return b;
	};

	public BookingDaoImpl() {
	}

	@Autowired
	public BookingDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public long insertBooking(Booking booking) {
		String sql = "INSERT INTO tbl_bookings (booking_date, journey_date, seats, total_price, status, flight_id, user_id) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(connection -> {
			PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, booking.getBookingDate());
			ps.setString(2, booking.getJourneyDate());
			ps.setInt(3, booking.getSeats());
			ps.setDouble(4, booking.getTotalPrice());
			ps.setString(5, booking.getStatus());
			ps.setLong(6, booking.getFlightId());
			ps.setLong(7, booking.getUserId());
			return ps;
		}, keyHolder);

		Number key = keyHolder.getKey();
		return key != null ? key.longValue() : 0L;
	}

	@Override
	public int getBookedSeatsCount(long flightId, String journeyDate) {
		String sql = "SELECT COALESCE(SUM(seats), 0) FROM tbl_bookings "
				+ "WHERE flight_id = ? AND journey_date = ? AND status = 'confirmed'";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, flightId, journeyDate);
		return count != null ? count : 0;
	}

	@Override
	public Booking getBookingById(long bookingId) {
		String sql = "SELECT b.*, f.flight_number, f.source, f.destination FROM tbl_bookings b "
				+ "JOIN tbl_flights f ON b.flight_id = f.flight_id WHERE b.booking_id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, bookingRowMapper, bookingId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<Booking> getBookingsByUserId(long userId) {
		String sql = "SELECT b.*, f.flight_number, f.source, f.destination FROM tbl_bookings b "
				+ "JOIN tbl_flights f ON b.flight_id = f.flight_id WHERE b.user_id = ? "
				+ "ORDER BY b.booking_id DESC";
		return jdbcTemplate.query(sql, bookingRowMapper, userId);
	}

	@Override
	public int cancelBooking(long bookingId) {
		String sql = "UPDATE tbl_bookings SET status = 'cancelled' WHERE booking_id = ?";
		return jdbcTemplate.update(sql, bookingId);
	}

	@Override
	public List<FlightSummaryDto> getUpcomingFlightSummaries() {
		String sql = "SELECT f.flight_number, b.journey_date, "
				+ "COALESCE(SUM(b.seats), 0) AS total_passengers, "
				+ "COUNT(b.booking_id) AS total_bookings, "
				+ "COALESCE(SUM(b.total_price), 0.0) AS total_revenue, "
				+ "DATEDIFF(b.journey_date, CURDATE()) AS days_difference "
				+ "FROM tbl_bookings b "
				+ "JOIN tbl_flights f ON b.flight_id = f.flight_id "
				+ "WHERE b.journey_date >= CURDATE() AND b.status = 'confirmed' "
				+ "GROUP BY f.flight_number, b.journey_date "
				+ "ORDER BY b.journey_date ASC";

		RowMapper<FlightSummaryDto> mapper = (rs, rowNum) -> {
			FlightSummaryDto dto = new FlightSummaryDto();
			dto.setFlightNumber(rs.getString("flight_number"));
			dto.setJourneyDate(rs.getString("journey_date"));
			dto.setTotalPassengers(rs.getInt("total_passengers"));
			dto.setTotalBookings(rs.getInt("total_bookings"));
			dto.setTotalRevenue(rs.getDouble("total_revenue"));
			dto.setDaysDifference(rs.getLong("days_difference"));
			return dto;
		};
		return jdbcTemplate.query(sql, mapper);
	}

	@Override
	public List<FlightSummaryDto> getCompletedFlightSummaries() {
		String sql = "SELECT f.flight_number, b.journey_date, "
				+ "COALESCE(SUM(b.seats), 0) AS total_passengers, "
				+ "COUNT(b.booking_id) AS total_bookings, "
				+ "COALESCE(SUM(b.total_price), 0.0) AS total_revenue, "
				+ "DATEDIFF(CURDATE(), b.journey_date) AS days_difference "
				+ "FROM tbl_bookings b "
				+ "JOIN tbl_flights f ON b.flight_id = f.flight_id "
				+ "WHERE b.journey_date < CURDATE() AND b.status = 'confirmed' "
				+ "GROUP BY f.flight_number, b.journey_date "
				+ "ORDER BY b.journey_date DESC";

		RowMapper<FlightSummaryDto> mapper = (rs, rowNum) -> {
			FlightSummaryDto dto = new FlightSummaryDto();
			dto.setFlightNumber(rs.getString("flight_number"));
			dto.setJourneyDate(rs.getString("journey_date"));
			dto.setTotalPassengers(rs.getInt("total_passengers"));
			dto.setTotalBookings(rs.getInt("total_bookings"));
			dto.setTotalRevenue(rs.getDouble("total_revenue"));
			dto.setDaysDifference(rs.getLong("days_difference"));
			return dto;
		};
		return jdbcTemplate.query(sql, mapper);
	}
}
