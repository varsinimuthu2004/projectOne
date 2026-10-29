package com.deloitte.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import com.deloitte.dao.UserDao;
import com.deloitte.dto.LoginDto;
import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;

public class UserServiceTest {

	private UserService userService;
	private FakeUserDao fakeUserDao;

	// In-memory fake DAO for clean, isolated, fast unit testing without live DB
	static class FakeUserDao implements UserDao {
		private List<User> db = new ArrayList<>();
		private long nextId = 1001L;

		@Override
		public int insertUser(SignUpDto dto) {
			User u = new User(nextId++, dto.getEmail(), dto.getPassword(), dto.getRole());
			db.add(u);
			return 1;
		}

		@Override
		public User getUserByEmailAndPassword(String email, String password) {
			for (User u : db) {
				if (u.getEmail().equalsIgnoreCase(email) && u.getPassword().equals(password)) {
					return u;
				}
			}
			return null;
		}

		@Override
		public User getUserByEmail(String email) {
			for (User u : db) {
				if (u.getEmail().equalsIgnoreCase(email)) {
					return u;
				}
			}
			return null;
		}

		@Override
		public User getUserById(long userId) {
			for (User u : db) {
				if (u.getUserId() == userId) {
					return u;
				}
			}
			return null;
		}

		@Override
		public int updatePassword(long userId, String newPassword) {
			User u = getUserById(userId);
			if (u != null) {
				u.setPassword(newPassword);
				return 1;
			}
			return 0;
		}

		@Override
		public List<User> getAllUsers() {
			return new ArrayList<>(db);
		}
	}

	@Before
	public void setUp() {
		fakeUserDao = new FakeUserDao();
		userService = new UserServiceImpl(fakeUserDao);

		// Seed a known test user
		SignUpDto existingUser = new SignUpDto("test.user@flightapp.com", "SecurePass@2026", "user");
		fakeUserDao.insertUser(existingUser);
	}

	@Test
	public void testSignupSuccess() {
		SignUpDto newDto = new SignUpDto("new.user@flightapp.com", "Password@1234", "user");
		int result = userService.signup(newDto);
		assertEquals(1, result);

		User saved = userService.getUserByEmail("new.user@flightapp.com");
		assertNotNull(saved);
		assertEquals("user", saved.getRole());
	}

	@Test
	public void testSignupFailsWhenPasswordTooShort() {
		// Password must be > 8 characters per database check constraint
		SignUpDto shortPassDto = new SignUpDto("short@flightapp.com", "12345678", "user");
		int result = userService.signup(shortPassDto);
		assertEquals(-2, result);
	}

	@Test
	public void testSignupFailsWhenEmailAlreadyExists() {
		SignUpDto duplicateDto = new SignUpDto("test.user@flightapp.com", "AnotherPass@2026", "user");
		int result = userService.signup(duplicateDto);
		assertEquals(-1, result);
	}

	@Test
	public void testLoginSuccess() {
		LoginDto loginDto = new LoginDto("test.user@flightapp.com", "SecurePass@2026");
		User loggedIn = userService.login(loginDto);
		assertNotNull(loggedIn);
		assertEquals("test.user@flightapp.com", loggedIn.getEmail());
	}

	@Test
	public void testLoginFailureInvalidPassword() {
		LoginDto loginDto = new LoginDto("test.user@flightapp.com", "WrongPassword");
		User loggedIn = userService.login(loginDto);
		assertNull(loggedIn);
	}

	@Test
	public void testLoginFailureUserNotFound() {
		LoginDto loginDto = new LoginDto("unknown@flightapp.com", "SecurePass@2026");
		User loggedIn = userService.login(loginDto);
		assertNull(loggedIn);
	}
}
