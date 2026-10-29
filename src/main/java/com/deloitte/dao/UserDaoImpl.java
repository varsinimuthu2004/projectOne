package com.deloitte.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.deloitte.dto.SignUpDto;
import com.deloitte.model.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<User> userRowMapper = (rs, rowNum) -> {
		User user = new User();
		user.setUserId(rs.getLong("user_id"));
		user.setEmail(rs.getString("email"));
		user.setPassword(rs.getString("password"));
		user.setRole(rs.getString("role"));
		return user;
	};

	public UserDaoImpl() {
	}

	@Autowired
	public UserDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertUser(SignUpDto signUpDto) {
		String sql = "INSERT INTO tbl_users (email, password, role) VALUES (?, ?, ?)";
		return jdbcTemplate.update(sql, signUpDto.getEmail(), signUpDto.getPassword(), signUpDto.getRole().toLowerCase());
	}

	@Override
	public User getUserByEmailAndPassword(String email, String password) {
		String sql = "SELECT * FROM tbl_users WHERE email = ? AND password = ?";
		try {
			return jdbcTemplate.queryForObject(sql, userRowMapper, email, password);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public User getUserByEmail(String email) {
		String sql = "SELECT * FROM tbl_users WHERE email = ?";
		try {
			return jdbcTemplate.queryForObject(sql, userRowMapper, email);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public User getUserById(long userId) {
		String sql = "SELECT * FROM tbl_users WHERE user_id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, userRowMapper, userId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public int updatePassword(long userId, String newPassword) {
		String sql = "UPDATE tbl_users SET password = ? WHERE user_id = ?";
		return jdbcTemplate.update(sql, newPassword, userId);
	}

	@Override
	public List<User> getAllUsers() {
		String sql = "SELECT * FROM tbl_users";
		return jdbcTemplate.query(sql, userRowMapper);
	}
}
