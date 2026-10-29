package com.deloitte.dao;

import java.util.List;

import com.deloitte.model.Flight;

public interface FlightDao {

	int insertFlight(Flight flight);

	Flight getFlightById(long flightId);

	Flight getFlightByNumber(String flightNumber);

	List<Flight> getAllFlights();

	List<Flight> searchFlights(String source, String destination);
}
