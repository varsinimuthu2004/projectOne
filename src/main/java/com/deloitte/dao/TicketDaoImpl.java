package com.deloitte.dao;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.deloitte.model.Ticket;

@Repository
public class TicketDaoImpl implements TicketDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<Ticket> ticketRowMapper = (rs, rowNum) -> {
		Ticket t = new Ticket();
		t.setPnrNo(rs.getLong("pnr_no"));
		t.setPassengerName(rs.getString("passenger_name"));
		t.setGender(rs.getString("gender"));
		t.setAge(rs.getInt("age"));
		t.setJourneyDate(rs.getString("journey_date"));
		t.setSeatNo(rs.getString("seat_no"));
		t.setBookingId(rs.getLong("booking_id"));
		t.setStatus(rs.getString("status"));
		try {
			t.setFlightNumber(rs.getString("flight_number"));
		} catch (Exception ignored) {
		}
		return t;
	};

	public TicketDaoImpl() {
	}

	@Autowired
	public TicketDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public long insertTicket(Ticket ticket) {
		String sql = "INSERT INTO tbl_tickets (passenger_name, gender, age, journey_date, seat_no, booking_id, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(connection -> {
			PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, ticket.getPassengerName());
			ps.setString(2, ticket.getGender().toLowerCase());
			ps.setInt(3, ticket.getAge());
			ps.setString(4, ticket.getJourneyDate());
			ps.setString(5, ticket.getSeatNo());
			ps.setLong(6, ticket.getBookingId());
			ps.setString(7, ticket.getStatus());
			return ps;
		}, keyHolder);

		Number key = keyHolder.getKey();
		return key != null ? key.longValue() : 0L;
	}

	@Override
	public List<Ticket> getTicketsByBookingId(long bookingId) {
		String sql = "SELECT t.*, f.flight_number FROM tbl_tickets t "
				+ "JOIN tbl_bookings b ON t.booking_id = b.booking_id "
				+ "JOIN tbl_flights f ON b.flight_id = f.flight_id "
				+ "WHERE t.booking_id = ? ORDER BY t.pnr_no ASC";
		return jdbcTemplate.query(sql, ticketRowMapper, bookingId);
	}

	@Override
	public int cancelTicketsByBookingId(long bookingId) {
		String sql = "UPDATE tbl_tickets SET status = 'cancelled' WHERE booking_id = ?";
		return jdbcTemplate.update(sql, bookingId);
	}

	@Override
	public int getAssignedTicketCountForDate(long flightId, String journeyDate) {
		String sql = "SELECT COUNT(t.pnr_no) FROM tbl_tickets t "
				+ "JOIN tbl_bookings b ON t.booking_id = b.booking_id "
				+ "WHERE b.flight_id = ? AND t.journey_date = ? AND t.status = 'confirmed'";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, flightId, journeyDate);
		return count != null ? count : 0;
	}
}
