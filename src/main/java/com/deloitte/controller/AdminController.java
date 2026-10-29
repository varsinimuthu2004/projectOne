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

import com.deloitte.dto.FlightSummaryDto;
import com.deloitte.model.Flight;
import com.deloitte.model.User;
import com.deloitte.service.BookingService;
import com.deloitte.service.FlightService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private FlightService flightService;

	@Autowired
	private BookingService bookingService;

	private boolean isAdmin(HttpSession session) {
		User user = (User) session.getAttribute("user");
		return user != null && "admin".equalsIgnoreCase(user.getRole());
	}

	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		if (!isAdmin(session)) {
			return "redirect:/user/login";
		}
		model.addAttribute("adminUser", (User) session.getAttribute("user"));
		return "admin-dashboard";
	}

	@GetMapping("/add-flight")
	public String addFlightPage(HttpSession session, Model model) {
		if (!isAdmin(session)) {
			return "redirect:/user/login";
		}
		Flight flight = new Flight();
		flight.setCapacity(20); // Default capacity is 20 per requirement
		model.addAttribute("flight", flight);
		return "add-flight";
	}

	@PostMapping("/add-flight")
	public String processAddFlight(Flight flight, HttpSession session, Model model) {
		if (!isAdmin(session)) {
			return "redirect:/user/login";
		}

		if (flight.getFlightNumber() == null || flight.getSource() == null || flight.getDestination() == null
				|| flight.getDepartureTime() == null || flight.getArrivalTime() == null
				|| flight.getPricePerSeat() == null) {
			model.addAttribute("errorMsg", "All fields are required. Please fill every field.");
			model.addAttribute("flight", flight);
			return "add-flight";
		}

		int result = flightService.addFlight(flight);

		if (result == 1) {
			model.addAttribute("successMsg", "Flight " + flight.getFlightNumber() + " added successfully!");
			Flight newFlight = new Flight();
			newFlight.setCapacity(20);
			model.addAttribute("flight", newFlight);
		} else if (result == -1) {
			model.addAttribute("errorMsg", "Flight number '" + flight.getFlightNumber() + "' already exists. It must be unique.");
			model.addAttribute("flight", flight);
		} else {
			model.addAttribute("errorMsg", "Failed to add flight. Please verify all inputs.");
			model.addAttribute("flight", flight);
		}

		return "add-flight";
	}

	@GetMapping("/view-flights")
	public String viewFlights(HttpSession session, Model model) {
		if (!isAdmin(session)) {
			return "redirect:/user/login";
		}

		List<FlightSummaryDto> upcoming = bookingService.getUpcomingFlightSummaries();
		List<FlightSummaryDto> completed = bookingService.getCompletedFlightSummaries();

		model.addAttribute("upcomingJourneys", upcoming);
		model.addAttribute("completedJourneys", completed);
		model.addAttribute("currentDate", LocalDate.now().toString());

		return "view-flights";
	}
}
