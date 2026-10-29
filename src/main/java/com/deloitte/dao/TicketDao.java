package com.deloitte.dao;

import java.util.List;

import com.deloitte.model.Ticket;

public interface TicketDao {

	long insertTicket(Ticket ticket);

	List<Ticket> getTicketsByBookingId(long bookingId);

	int cancelTicketsByBookingId(long bookingId);

	int getAssignedTicketCountForDate(long flightId, String journeyDate);
}
