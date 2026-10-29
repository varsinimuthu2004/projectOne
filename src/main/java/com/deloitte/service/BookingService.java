package com.deloitte.service;

import java.util.List;

import com.deloitte.dto.BookingDraftDto;
import com.deloitte.dto.FlightSummaryDto;
import com.deloitte.model.Booking;
import com.deloitte.model.Ticket;

public interface BookingService {

	int getAvailableSeats(long flightId, String journeyDate);

	long bookFlight(BookingDraftDto draft, long userId);

	Booking getBookingById(long bookingId);

	List<Booking> getBookingsByUserId(long userId);

	List<Ticket> getTicketsForBooking(long bookingId);

	boolean cancelBooking(long bookingId);

	List<FlightSummaryDto> getUpcomingFlightSummaries();

	List<FlightSummaryDto> getCompletedFlightSummaries();
}
