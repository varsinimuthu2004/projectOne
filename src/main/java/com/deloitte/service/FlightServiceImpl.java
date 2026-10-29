package com.deloitte.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deloitte.dao.FlightDao;
import com.deloitte.model.Flight;

@Service
public class FlightServiceImpl implements FlightService {

	@Autowired
	private FlightDao flightDao;

	public FlightServiceImpl() {
	}

	@Autowired
	public FlightServiceImpl(FlightDao flightDao) {
		this.flightDao = flightDao;
	}

	@Override
	public int addFlight(Flight flight) {
		if (flight == null || flight.getFlightNumber() == null) {
			return 0;
		}

		String flightNumber = flight.getFlightNumber().trim().toUpperCase();
		flight.setFlightNumber(flightNumber);

		// Check for duplicate flight number
		Flight existing = flightDao.getFlightByNumber(flightNumber);
		if (existing != null) {
			return -1; // Duplicate flight number
		}

		// Wireframe requirement: default capacity 20
		if (flight.getCapacity() == null || flight.getCapacity() <= 0) {
			flight.setCapacity(20);
		}

		return flightDao.insertFlight(flight);
	}

	@Override
	public Flight getFlightById(long flightId) {
		return flightDao.getFlightById(flightId);
	}

	@Override
	public Flight getFlightByNumber(String flightNumber) {
		if (flightNumber == null) {
			return null;
		}
		return flightDao.getFlightByNumber(flightNumber.trim().toUpperCase());
	}

	@Override
	public List<Flight> getAllFlights() {
		return flightDao.getAllFlights();
	}

	@Override
	public List<Flight> searchFlights(String source, String destination) {
		if (source == null || destination == null) {
			return getAllFlights();
		}
		return flightDao.searchFlights(source.trim(), destination.trim());
	}
}
