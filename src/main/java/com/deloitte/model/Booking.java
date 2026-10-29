package com.deloitte.model;

public class Booking {

	private Long bookingId;
	private String bookingDate;
	private String journeyDate;
	private Integer seats;
	private Double totalPrice;
	private String status; // 'confirmed' or 'cancelled'
	private Long flightId;
	private Long userId;

	// Extra fields for joined queries
	private String flightNumber;
	private String source;
	private String destination;

	public Booking() {
	}

	public Booking(Long bookingId, String bookingDate, String journeyDate, Integer seats, Double totalPrice,
			String status, Long flightId, Long userId) {
		this.bookingId = bookingId;
		this.bookingDate = bookingDate;
		this.journeyDate = journeyDate;
		this.seats = seats;
		this.totalPrice = totalPrice;
		this.status = status;
		this.flightId = flightId;
		this.userId = userId;
	}

	public Long getBookingId() {
		return bookingId;
	}

	public void setBookingId(Long bookingId) {
		this.bookingId = bookingId;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getJourneyDate() {
		return journeyDate;
	}

	public void setJourneyDate(String journeyDate) {
		this.journeyDate = journeyDate;
	}

	public Integer getSeats() {
		return seats;
	}

	public void setSeats(Integer seats) {
		this.seats = seats;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getFlightId() {
		return flightId;
	}

	public void setFlightId(Long flightId) {
		this.flightId = flightId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	@Override
	public String toString() {
		return "Booking [bookingId=" + bookingId + ", bookingDate=" + bookingDate + ", journeyDate=" + journeyDate
				+ ", seats=" + seats + ", totalPrice=" + totalPrice + ", status=" + status + ", flightId=" + flightId
				+ ", userId=" + userId + ", flightNumber=" + flightNumber + "]";
	}
}
