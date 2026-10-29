package com.deloitte.dto;

public class FlightSearchDto {

	private String source;
	private String destination;

	public FlightSearchDto() {
	}

	public FlightSearchDto(String source, String destination) {
		this.source = source;
		this.destination = destination;
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
		return "FlightSearchDto [source=" + source + ", destination=" + destination + "]";
	}
}
