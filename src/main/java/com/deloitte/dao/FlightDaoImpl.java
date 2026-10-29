package com.deloitte.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.deloitte.model.Flight;

@Repository
public class FlightDaoImpl implements FlightDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<Flight> flightRowMapper = (rs, rowNum) -> {
		Flight f = new Flight();
		f.setFlightId(rs.getLong("flight_id"));
		f.setFlightNumber(rs.getString("flight_number"));
		f.setSource(rs.getString("source"));
		f.setDestination(rs.getString("destination"));
		f.setDepartureTime(rs.getString("departure_time"));
		f.setArrivalTime(rs.getString("arrival_time"));
		f.setCapacity(rs.getInt("capacity"));
		f.setPricePerSeat(rs.getDouble("price_per_seat"));
		return f;
	};

	public FlightDaoImpl() {
	}

	@Autowired
	public FlightDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertFlight(Flight flight) {
		String sql = "INSERT INTO tbl_flights (flight_number, source, destination, departure_time, arrival_time, capacity, price_per_seat) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		int capacity = (flight.getCapacity() != null && flight.getCapacity() > 0) ? flight.getCapacity() : 20;
		return jdbcTemplate.update(sql, flight.getFlightNumber(), flight.getSource(), flight.getDestination(),
				flight.getDepartureTime(), flight.getArrivalTime(), capacity, flight.getPricePerSeat());
	}

	@Override
	public Flight getFlightById(long flightId) {
		String sql = "SELECT * FROM tbl_flights WHERE flight_id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, flightRowMapper, flightId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public Flight getFlightByNumber(String flightNumber) {
		String sql = "SELECT * FROM tbl_flights WHERE flight_number = ?";
		try {
			return jdbcTemplate.queryForObject(sql, flightRowMapper, flightNumber);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<Flight> getAllFlights() {
		String sql = "SELECT * FROM tbl_flights ORDER BY flight_id ASC";
		return jdbcTemplate.query(sql, flightRowMapper);
	}

	@Override
	public List<Flight> searchFlights(String source, String destination) {
		String sql = "SELECT * FROM tbl_flights WHERE LOWER(TRIM(source)) = LOWER(TRIM(?)) AND LOWER(TRIM(destination)) = LOWER(TRIM(?))";
		return jdbcTemplate.query(sql, flightRowMapper, source, destination);
	}
}
