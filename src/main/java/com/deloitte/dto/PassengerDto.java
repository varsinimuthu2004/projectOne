package com.deloitte.dto;

public class PassengerDto {

	private String passengerName;
	private Integer age;
	private String gender; // 'male', 'female', 'other'

	public PassengerDto() {
	}

	public PassengerDto(String passengerName, Integer age, String gender) {
		this.passengerName = passengerName;
		this.age = age;
		this.gender = gender;
	}

	public String getPassengerName() {
		return passengerName;
	}

	public void setPassengerName(String passengerName) {
		this.passengerName = passengerName;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "PassengerDto [passengerName=" + passengerName + ", age=" + age + ", gender=" + gender + "]";
	}
}
