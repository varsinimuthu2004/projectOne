package com.deloitte.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deloitte.dto.BookingDraftDto;
import com.deloitte.dto.PassengerDto;
import com.deloitte.model.Booking;
import com.deloitte.model.Flight;
import com.deloitte.model.Ticket;
import com.deloitte.model.User;
import com.deloitte.service.BookingService;
import com.deloitte.service.FlightService;

@Controller
@RequestMapping("/booking")
public class BookingController {

	@Autowired
	private FlightService flightService;

	@Autowired
	private BookingService bookingService;

	@GetMapping("/form")
	public String bookingForm(@RequestParam long flightId, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			session.setAttribute("redirectFlightId", flightId);
			return "redirect:/user/login";
		}

		Flight flight = flightService.getFlightById(flightId);
		if (flight == null) {
			return "redirect:/home";
		}

		model.addAttribute("flight", flight);
		model.addAttribute("minDate", LocalDate.now().toString());
		return "booking-form";
	}

	@PostMapping("/form")
	public String processBookingForm(@RequestParam long flightId, @RequestParam String journeyDate,
			@RequestParam int numberOfPassengers, HttpSession session, Model model) {

		User user = (User) session.getAttribute("user");
		if (user == null) {
			session.setAttribute("redirectFlightId", flightId);
			return "redirect:/user/login";
		}

		Flight flight = flightService.getFlightById(flightId);
		if (flight == null) {
			return "redirect:/home";
		}

		if (numberOfPassengers < 1 || numberOfPassengers > 10) {
			model.addAttribute("errorMsg", "Number of passengers must be between 1 and 10.");
			model.addAttribute("flight", flight);
			model.addAttribute("minDate", LocalDate.now().toString());
			return "booking-form";
		}

		if (journeyDate == null || journeyDate.trim().isEmpty()) {
			model.addAttribute("errorMsg", "Please select a valid journey date.");
			model.addAttribute("flight", flight);
			model.addAttribute("minDate", LocalDate.now().toString());
			return "booking-form";
		}

		// Check availability of seats
		int availableSeats = bookingService.getAvailableSeats(flightId, journeyDate);
		if (availableSeats < numberOfPassengers) {
			model.addAttribute("errorMsg", "Only " + availableSeats + " seats available on " + journeyDate
					+ ". You requested " + numberOfPassengers + " seats. Please select another date or fewer passengers.");
			model.addAttribute("flight", flight);
			model.addAttribute("minDate", LocalDate.now().toString());
			return "booking-form";
		}

		// Create draft in session
		BookingDraftDto draft = new BookingDraftDto();
		draft.setFlightId(flight.getFlightId());
		draft.setFlightNumber(flight.getFlightNumber());
		draft.setSource(flight.getSource());
		draft.setDestination(flight.getDestination());
		draft.setDepartureTime(flight.getDepartureTime());
		draft.setArrivalTime(flight.getArrivalTime());
		draft.setPricePerSeat(flight.getPricePerSeat());
		draft.setJourneyDate(journeyDate);
		draft.setNumberOfPassengers(numberOfPassengers);
		draft.setTotalPrice(numberOfPassengers * flight.getPricePerSeat());

		session.setAttribute("bookingDraft", draft);
		return "redirect:/booking/passenger";
	}

	@GetMapping("/passenger")
	public String addPassengerPage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		BookingDraftDto draft = (BookingDraftDto) session.getAttribute("bookingDraft");
		if (draft == null) {
			return "redirect:/home";
		}

		int passengerNumber = draft.getPassengers().size() + 1;
		int totalPassengers = draft.getNumberOfPassengers();
		int remainingPassengers = totalPassengers - passengerNumber;
		boolean isLastPassenger = (passengerNumber == totalPassengers);

		model.addAttribute("draft", draft);
		model.addAttribute("passengerNumber", passengerNumber);
		model.addAttribute("totalPassengers", totalPassengers);
		model.addAttribute("remainingPassengers", remainingPassengers);
		model.addAttribute("isLastPassenger", isLastPassenger);
		model.addAttribute("passengerDto", new PassengerDto());

		return "add-passenger";
	}

	@PostMapping("/passenger")
	public String processAddPassenger(PassengerDto passengerDto, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		BookingDraftDto draft = (BookingDraftDto) session.getAttribute("bookingDraft");
		if (draft == null) {
			return "redirect:/home";
		}

		if (passengerDto.getPassengerName() == null || passengerDto.getPassengerName().trim().isEmpty()
				|| passengerDto.getAge() == null || passengerDto.getAge() <= 0
				|| passengerDto.getGender() == null || passengerDto.getGender().trim().isEmpty()) {

			int passengerNumber = draft.getPassengers().size() + 1;
			int totalPassengers = draft.getNumberOfPassengers();
			int remainingPassengers = totalPassengers - passengerNumber;
			boolean isLastPassenger = (passengerNumber == totalPassengers);

			model.addAttribute("errorMsg", "All passenger fields are mandatory. Please fill in valid details.");
			model.addAttribute("draft", draft);
			model.addAttribute("passengerNumber", passengerNumber);
			model.addAttribute("totalPassengers", totalPassengers);
			model.addAttribute("remainingPassengers", remainingPassengers);
			model.addAttribute("isLastPassenger", isLastPassenger);
			model.addAttribute("passengerDto", passengerDto);
			return "add-passenger";
		}

		draft.addPassenger(passengerDto);

		if (draft.getPassengers().size() < draft.getNumberOfPassengers()) {
			return "redirect:/booking/passenger";
		} else {
			// All passengers entered -> Complete Booking
			long bookingId = bookingService.bookFlight(draft, user.getUserId());
			session.removeAttribute("bookingDraft");
			return "redirect:/booking/confirmation?bookingId=" + bookingId;
		}
	}

	@GetMapping("/confirmation")
	public String confirmationPage(@RequestParam long bookingId, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		Booking booking = bookingService.getBookingById(bookingId);
		model.addAttribute("booking", booking);
		return "booking-confirmation";
	}

	@GetMapping("/my-bookings")
	public String myBookings(@RequestParam(required = false) String msg, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		List<Booking> bookings = bookingService.getBookingsByUserId(user.getUserId());
		model.addAttribute("bookings", bookings);
		if (msg != null) {
			model.addAttribute("msg", msg);
		}
		return "my-bookings";
	}

	@GetMapping("/view-tickets")
	public String viewTickets(@RequestParam long bookingId, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		Booking booking = bookingService.getBookingById(bookingId);
		List<Ticket> tickets = bookingService.getTicketsForBooking(bookingId);

		model.addAttribute("booking", booking);
		model.addAttribute("tickets", tickets);
		return "view-tickets";
	}

	@PostMapping("/cancel")
	public String cancelBooking(@RequestParam long bookingId, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		bookingService.cancelBooking(bookingId);
		return "redirect:/booking/my-bookings?msg=Booking+%23" + bookingId + "+has+been+cancelled+and+seats+released.";
	}
}
