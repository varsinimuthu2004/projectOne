package com.deloitte.dao;

import java.util.List;

import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;

public interface UserDao {

	int insertUser(SignUpDto signUpDto);

	User getUserByEmailAndPassword(String email, String password);

	User getUserByEmail(String email);

	User getUserById(long userId);

	int updatePassword(long userId, String newPassword);

	List<User> getAllUsers();
}
