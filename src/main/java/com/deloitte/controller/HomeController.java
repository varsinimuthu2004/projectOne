package com.deloitte.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deloitte.model.Flight;
import com.deloitte.model.User;
import com.deloitte.service.FlightService;

@Controller
public class HomeController {

	@Autowired
	private FlightService flightService;

	@GetMapping({ "", "/", "/home" })
	public String home(@RequestParam(required = false) String source,
			@RequestParam(required = false) String destination, Model model, HttpSession session) {

		User user = (User) session.getAttribute("user");
		model.addAttribute("currentUser", user);

		if (source != null && destination != null && !source.trim().isEmpty() && !destination.trim().isEmpty()) {
			List<Flight> flights = flightService.searchFlights(source, destination);
			model.addAttribute("flights", flights);
			model.addAttribute("hasSearched", true);
			model.addAttribute("searchedSource", source.trim());
			model.addAttribute("searchedDestination", destination.trim());
		} else {
			model.addAttribute("hasSearched", false);
		}

		return "home";
	}
}
