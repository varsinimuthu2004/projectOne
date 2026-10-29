package com.deloitte.service;

import java.util.List;

import com.deloitte.dto.LoginDto;
import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;

public interface UserService {

	int signup(SignUpDto signUpDto);

	User login(LoginDto loginDto);

	User getUserByEmail(String email);

	User getUserById(long userId);

	boolean updatePassword(long userId, String newPassword);

	List<User> getAllUsers();
}
