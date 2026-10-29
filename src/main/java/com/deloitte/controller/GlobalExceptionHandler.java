package com.deloitte.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(Exception.class)
	public String handleGeneralException(Exception ex, Model model) {
		model.addAttribute("errorMessage",
				ex.getMessage() != null ? ex.getMessage() : "An unexpected server error occurred. Please try again.");
		return "error";
	}
}
