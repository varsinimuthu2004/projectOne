package com.deloitte.dao;

import java.util.List;

import com.deloitte.dto.FlightSummaryDto;
import com.deloitte.model.Booking;

public interface BookingDao {

	long insertBooking(Booking booking);

	int getBookedSeatsCount(long flightId, String journeyDate);

	Booking getBookingById(long bookingId);

	List<Booking> getBookingsByUserId(long userId);

	int cancelBooking(long bookingId);

	List<FlightSummaryDto> getUpcomingFlightSummaries();

	List<FlightSummaryDto> getCompletedFlightSummaries();
}
