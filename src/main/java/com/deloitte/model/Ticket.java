package com.deloitte.model;

public class Ticket {

	private Long pnrNo;
	private String passengerName;
	private String gender; // 'male', 'female', 'other'
	private Integer age;
	private String journeyDate;
	private String seatNo;
	private Long bookingId;
	private String status; // 'confirmed' or 'cancelled'

	// Extra fields for joined queries
	private String flightNumber;

	public Ticket() {
	}

	public Ticket(Long pnrNo, String passengerName, String gender, Integer age, String journeyDate, String seatNo,
			Long bookingId, String status) {
		this.pnrNo = pnrNo;
		this.passengerName = passengerName;
		this.gender = gender;
		this.age = age;
		this.journeyDate = journeyDate;
		this.seatNo = seatNo;
		this.bookingId = bookingId;
		this.status = status;
	}

	public Long getPnrNo() {
		return pnrNo;
	}

	public void setPnrNo(Long pnrNo) {
		this.pnrNo = pnrNo;
	}

	public String getPassengerName() {
		return passengerName;
	}

	public void setPassengerName(String passengerName) {
		this.passengerName = passengerName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getJourneyDate() {
		return journeyDate;
	}

	public void setJourneyDate(String journeyDate) {
		this.journeyDate = journeyDate;
	}

	public String getSeatNo() {
		return seatNo;
	}

	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}

	public Long getBookingId() {
		return bookingId;
	}

	public void setBookingId(Long bookingId) {
		this.bookingId = bookingId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	@Override
	public String toString() {
		return "Ticket [pnrNo=" + pnrNo + ", passengerName=" + passengerName + ", gender=" + gender + ", age=" + age
				+ ", journeyDate=" + journeyDate + ", seatNo=" + seatNo + ", bookingId=" + bookingId + ", status="
				+ status + "]";
	}
}
