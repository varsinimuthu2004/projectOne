package com.deloitte.dto;

public class FlightSummaryDto {

	private String flightNumber;
	private String journeyDate;
	private Integer totalPassengers;
	private Integer totalBookings;
	private Double totalRevenue;
	private Long daysDifference;

	public FlightSummaryDto() {
	}

	public FlightSummaryDto(String flightNumber, String journeyDate, Integer totalPassengers, Integer totalBookings,
			Double totalRevenue, Long daysDifference) {
		this.flightNumber = flightNumber;
		this.journeyDate = journeyDate;
		this.totalPassengers = totalPassengers;
		this.totalBookings = totalBookings;
		this.totalRevenue = totalRevenue;
		this.daysDifference = daysDifference;
	}

	public String getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	public String getJourneyDate() {
		return journeyDate;
	}

	public void setJourneyDate(String journeyDate) {
		this.journeyDate = journeyDate;
	}

	public Integer getTotalPassengers() {
		return totalPassengers;
	}

	public void setTotalPassengers(Integer totalPassengers) {
		this.totalPassengers = totalPassengers;
	}

	public Integer getTotalBookings() {
		return totalBookings;
	}

	public void setTotalBookings(Integer totalBookings) {
		this.totalBookings = totalBookings;
	}

	public Double getTotalRevenue() {
		return totalRevenue;
	}

	public void setTotalRevenue(Double totalRevenue) {
		this.totalRevenue = totalRevenue;
	}

	public Long getDaysDifference() {
		return daysDifference;
	}

	public void setDaysDifference(Long daysDifference) {
		this.daysDifference = daysDifference;
	}

	@Override
	public String toString() {
		return "FlightSummaryDto [flightNumber=" + flightNumber + ", journeyDate=" + journeyDate + ", totalPassengers="
				+ totalPassengers + ", totalBookings=" + totalBookings + ", totalRevenue=" + totalRevenue
				+ ", daysDifference=" + daysDifference + "]";
	}
}
