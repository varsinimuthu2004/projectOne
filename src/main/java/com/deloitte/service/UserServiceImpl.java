package com.deloitte.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deloitte.dao.UserDao;
import com.deloitte.dto.LoginDto;
import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	public UserServiceImpl() {
	}

	@Autowired
	public UserServiceImpl(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public int signup(SignUpDto signUpDto) {
		if (signUpDto == null || signUpDto.getEmail() == null || signUpDto.getPassword() == null
				|| signUpDto.getRole() == null) {
			return 0;
		}

		String email = signUpDto.getEmail().trim();
		String password = signUpDto.getPassword().trim();
		String role = signUpDto.getRole().trim().toLowerCase();

		if (email.isEmpty() || !email.contains("@")) {
			return 0;
		}

		if (password.length() <= 8) {
			return -2; // Password too short (must be > 8 characters)
		}

		if (!role.equals("user") && !role.equals("admin")) {
			return 0;
		}

		// Check if email already exists
		User existing = userDao.getUserByEmail(email);
		if (existing != null) {
			return -1; // Duplicate email
		}

		signUpDto.setEmail(email);
		signUpDto.setPassword(password);
		signUpDto.setRole(role);

		return userDao.insertUser(signUpDto);
	}

	@Override
	public User login(LoginDto loginDto) {
		if (loginDto == null || loginDto.getEmail() == null || loginDto.getPassword() == null) {
			return null;
		}
		String email = loginDto.getEmail().trim();
		String password = loginDto.getPassword().trim();

		if (email.isEmpty() || password.isEmpty()) {
			return null;
		}

		return userDao.getUserByEmailAndPassword(email, password);
	}

	@Override
	public User getUserByEmail(String email) {
		if (email == null) {
			return null;
		}
		return userDao.getUserByEmail(email.trim());
	}

	@Override
	public User getUserById(long userId) {
		return userDao.getUserById(userId);
	}

	@Override
	public boolean updatePassword(long userId, String newPassword) {
		if (newPassword == null || newPassword.trim().length() <= 8) {
			return false;
		}
		return userDao.updatePassword(userId, newPassword.trim()) == 1;
	}

	@Override
	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}
}
