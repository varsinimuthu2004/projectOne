package com.deloitte.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deloitte.dto.LoginDto;
import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;
import com.deloitte.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping("/signup")
	public String signupPage(Model model) {
		model.addAttribute("signUpDto", new SignUpDto());
		return "signup";
	}

	@PostMapping("/signup")
	public String processSignup(SignUpDto signUpDto, Model model) {
		int result = userService.signup(signUpDto);

		if (result == 1) {
			model.addAttribute("successMsg", "Sign Up successful! Please login with your credentials.");
			model.addAttribute("loginDto", new LoginDto(signUpDto.getEmail(), ""));
			return "login";
		} else if (result == -1) {
			model.addAttribute("errorMsg", "Email is already registered. Please use another email or login.");
			model.addAttribute("signUpDto", signUpDto);
			return "signup";
		} else if (result == -2) {
			model.addAttribute("errorMsg", "Password must be greater than 8 characters.");
			model.addAttribute("signUpDto", signUpDto);
			return "signup";
		} else {
			model.addAttribute("errorMsg", "Registration failed. Please verify your details.");
			model.addAttribute("signUpDto", signUpDto);
			return "signup";
		}
	}

	@GetMapping("/login")
	public String loginPage(@RequestParam(required = false) String redirect, Model model) {
		model.addAttribute("loginDto", new LoginDto());
		return "login";
	}

	@PostMapping("/login")
	public String processLogin(LoginDto loginDto, HttpSession session, Model model) {
		User user = userService.login(loginDto);

		if (user != null) {
			session.setAttribute("user", user);

			// Check if there was a redirected flight booking attempt
			Long redirectFlightId = (Long) session.getAttribute("redirectFlightId");
			if (redirectFlightId != null) {
				session.removeAttribute("redirectFlightId");
				return "redirect:/booking/form?flightId=" + redirectFlightId;
			}

			if ("admin".equalsIgnoreCase(user.getRole())) {
				return "redirect:/admin/dashboard";
			} else {
				return "redirect:/user/dashboard";
			}
		} else {
			model.addAttribute("errorMsg", "Invalid email or password. Please try again.");
			model.addAttribute("loginDto", loginDto);
			return "login";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/login";
	}

	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}
		model.addAttribute("user", user);
		return "user-dashboard";
	}

	@GetMapping("/profile")
	public String profile(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}
		model.addAttribute("user", user);
		return "profile";
	}

	@PostMapping("/profile")
	public String updateProfile(@RequestParam String newPassword, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/user/login";
		}

		if (newPassword == null || newPassword.trim().length() <= 8) {
			model.addAttribute("errorMsg", "Password must be greater than 8 characters.");
			model.addAttribute("user", user);
			return "profile";
		}

		boolean ok = userService.updatePassword(user.getUserId(), newPassword);
		if (ok) {
			user.setPassword(newPassword.trim());
			session.setAttribute("user", user);
			model.addAttribute("successMsg", "Password updated successfully!");
		} else {
			model.addAttribute("errorMsg", "Failed to update password.");
		}
		model.addAttribute("user", user);
		return "profile";
	}
}
