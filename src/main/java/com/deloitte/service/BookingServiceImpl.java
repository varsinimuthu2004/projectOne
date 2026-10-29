package com.deloitte.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deloitte.dao.BookingDao;
import com.deloitte.dao.FlightDao;
import com.deloitte.dao.TicketDao;
import com.deloitte.dto.BookingDraftDto;
import com.deloitte.dto.FlightSummaryDto;
import com.deloitte.dto.PassengerDto;
import com.deloitte.model.Booking;
import com.deloitte.model.Flight;
import com.deloitte.model.Ticket;

@Service
public class BookingServiceImpl implements BookingService {

	@Autowired
	private BookingDao bookingDao;

	@Autowired
	private TicketDao ticketDao;

	@Autowired
	private FlightDao flightDao;

	public BookingServiceImpl() {
	}

	@Autowired
	public BookingServiceImpl(BookingDao bookingDao, TicketDao ticketDao, FlightDao flightDao) {
		this.bookingDao = bookingDao;
		this.ticketDao = ticketDao;
		this.flightDao = flightDao;
	}

	@Override
	public int getAvailableSeats(long flightId, String journeyDate) {
		Flight flight = flightDao.getFlightById(flightId);
		if (flight == null) {
			return 0;
		}
		int capacity = flight.getCapacity() != null ? flight.getCapacity() : 20;
		int bookedSeats = bookingDao.getBookedSeatsCount(flightId, journeyDate);
		return Math.max(0, capacity - bookedSeats);
	}

	@Override
	public long bookFlight(BookingDraftDto draft, long userId) {
		if (draft == null || draft.getPassengers() == null || draft.getPassengers().isEmpty()) {
			return 0L;
		}

		String bookingDate = LocalDate.now().toString();

		Booking booking = new Booking();
		booking.setBookingDate(bookingDate);
		booking.setJourneyDate(draft.getJourneyDate());
		booking.setSeats(draft.getPassengers().size());
		booking.setTotalPrice(draft.getTotalPrice());
		booking.setStatus("confirmed");
		booking.setFlightId(draft.getFlightId());
		booking.setUserId(userId);

		long bookingId = bookingDao.insertBooking(booking);
		if (bookingId <= 0) {
			return 0L;
		}

		int baseIndex = ticketDao.getAssignedTicketCountForDate(draft.getFlightId(), draft.getJourneyDate());

		char[] seatLetters = new char[] { 'A', 'B', 'C', 'D', 'E', 'F' };

		for (int i = 0; i < draft.getPassengers().size(); i++) {
			PassengerDto p = draft.getPassengers().get(i);
			int seatNum = baseIndex + i;
			int row = (seatNum / seatLetters.length) + 1;
			char col = seatLetters[seatNum % seatLetters.length];
			String seatNo = row + "" + col;

			Ticket ticket = new Ticket();
			ticket.setPassengerName(p.getPassengerName());
			ticket.setGender(p.getGender());
			ticket.setAge(p.getAge());
			ticket.setJourneyDate(draft.getJourneyDate());
			ticket.setSeatNo(seatNo);
			ticket.setBookingId(bookingId);
			ticket.setStatus("confirmed");

			ticketDao.insertTicket(ticket);
		}

		return bookingId;
	}

	@Override
	public Booking getBookingById(long bookingId) {
		return bookingDao.getBookingById(bookingId);
	}

	@Override
	public List<Booking> getBookingsByUserId(long userId) {
		return bookingDao.getBookingsByUserId(userId);
	}

	@Override
	public List<Ticket> getTicketsForBooking(long bookingId) {
		return ticketDao.getTicketsByBookingId(bookingId);
	}

	@Override
	public boolean cancelBooking(long bookingId) {
		int rowsBooking = bookingDao.cancelBooking(bookingId);
		int rowsTickets = ticketDao.cancelTicketsByBookingId(bookingId);
		return rowsBooking > 0;
	}

	@Override
	public List<FlightSummaryDto> getUpcomingFlightSummaries() {
		return bookingDao.getUpcomingFlightSummaries();
	}

	@Override
	public List<FlightSummaryDto> getCompletedFlightSummaries() {
		return bookingDao.getCompletedFlightSummaries();
	}
}
