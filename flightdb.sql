-- Flight Reservation System Database Setup Script
-- Database: flightdb

DROP DATABASE IF EXISTS flightdb;
CREATE DATABASE flightdb;
USE flightdb;

-- 1. Users Table
CREATE TABLE tbl_users
(
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL CHECK(LENGTH(password) > 8),
    role VARCHAR(50) NOT NULL CHECK(role IN ('user', 'admin'))
) AUTO_INCREMENT = 1001;

-- 2. Flights Table
CREATE TABLE tbl_flights
(
    flight_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(50) NOT NULL UNIQUE,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time VARCHAR(50) NOT NULL,
    arrival_time VARCHAR(50) NOT NULL,
    capacity INT CHECK(capacity > 0),
    price_per_seat DOUBLE CHECK(price_per_seat > 0)
) AUTO_INCREMENT = 5001;

-- 3. Bookings Table
CREATE TABLE tbl_bookings
(
    booking_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    booking_date DATE NOT NULL,
    journey_date DATE NOT NULL,
    seats INT CHECK(seats > 0),
    total_price DOUBLE CHECK(total_price > 0),
    status VARCHAR(50) CHECK(status IN ('confirmed', 'cancelled')),
    flight_id BIGINT,
    user_id BIGINT
) AUTO_INCREMENT = 90001;

-- 4. Tickets Table
CREATE TABLE tbl_tickets
(
    pnr_no BIGINT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) CHECK(gender IN ('male', 'female', 'other')),
    age INT CHECK(age BETWEEN 0 AND 120),
    journey_date DATE NOT NULL,
    seat_no VARCHAR(20) NOT NULL,
    booking_id BIGINT,
    status VARCHAR(50) CHECK(status IN ('confirmed', 'cancelled'))
) AUTO_INCREMENT = 100001;

-- Foreign Keys and Additional Constraints
ALTER TABLE tbl_bookings
ADD CONSTRAINT fk_booking_flight FOREIGN KEY(flight_id) REFERENCES tbl_flights(flight_id),
ADD CONSTRAINT fk_booking_user FOREIGN KEY(user_id) REFERENCES tbl_users(user_id),
ADD CONSTRAINT chk_journey_date CHECK(journey_date >= booking_date);

ALTER TABLE tbl_tickets
ADD CONSTRAINT fk_ticket_booking FOREIGN KEY(booking_id) REFERENCES tbl_bookings(booking_id);

-- Sample Users (admin: Admin@2026, users: Ravi@2026, Meera@2026, Arjun@2026, Sneha@2026, Kiran@2026)
INSERT INTO tbl_users (email, password, role) VALUES
('admin@flightapp.com', 'Admin@2026', 'admin'),
('ravi.kumar@example.com', 'Ravi@2026', 'user'),
('meera.nair@example.com', 'Meera@2026', 'user'),
('arjun.rao@example.com', 'Arjun@2026', 'user'),
('sneha.iyer@example.com', 'Sneha@2026', 'user'),
('kiran.das@example.com', 'Kiran@2026', 'user');

-- Sample Flights
INSERT INTO tbl_flights
(flight_number, source, destination, departure_time, arrival_time, capacity, price_per_seat) VALUES
('AI101', 'Delhi', 'Mumbai', '06:00', '08:10', 180, 4500),
('6E202', 'Mumbai', 'Bangalore', '09:30', '11:15', 150, 3800),
('SG303', 'Bangalore', 'Chennai', '14:00', '15:00', 120, 2500),
('UK404', 'Delhi', 'Kolkata', '18:45', '21:05', 160, 5200),
('AI505', 'Mumbai', 'Hyderabad', '07:15', '08:45', 140, 6100),
('6E606', 'Chennai', 'Delhi', '20:00', '22:50', 170, 5800);

-- Sample Bookings
INSERT INTO tbl_bookings
(booking_date, journey_date, seats, total_price, status, flight_id, user_id) VALUES
('2026-10-20', '2026-11-15', 2, 9000, 'confirmed', 5001, 1002),
('2026-10-22', '2026-11-20', 1, 3800, 'confirmed', 5002, 1003),
('2026-10-25', '2026-12-01', 1, 2500, 'cancelled', 5003, 1002),
('2026-10-26', '2026-11-25', 3, 15600, 'confirmed', 5004, 1004),
('2026-10-27', '2026-12-10', 2, 12200, 'confirmed', 5005, 1005),
('2026-10-28', '2026-11-18', 1, 4500, 'confirmed', 5001, 1003);

-- Sample Tickets
INSERT INTO tbl_tickets
(passenger_name, gender, age, journey_date, seat_no, booking_id, status) VALUES
('Ravi Kumar', 'male', 34, '2026-11-15', '12A', 90001, 'confirmed'),
('Anita Kumar', 'female', 32, '2026-11-15', '12B', 90001, 'confirmed'),
('Meera Nair', 'female', 28, '2026-11-20', '5C', 90002, 'confirmed'),
('Ravi Kumar', 'male', 34, '2026-12-01', '8D', 90003, 'cancelled'),
('Arjun Rao', 'male', 41, '2026-11-25', '3A', 90004, 'confirmed'),
('Kavya Rao', 'female', 38, '2026-11-25', '3B', 90004, 'confirmed'),
('Rohan Rao', 'male', 12, '2026-11-25', '3C', 90004, 'confirmed'),
('Sneha Iyer', 'female', 29, '2026-12-10', '14F', 90005, 'confirmed'),
('Vikram Iyer', 'male', 31, '2026-12-10', '14E', 90005, 'confirmed'),
('Meera Nair', 'female', 28, '2026-11-18', '9A', 90006, 'confirmed');

-- Verification Queries
SELECT * FROM tbl_users;
SELECT * FROM tbl_flights;
SELECT * FROM tbl_bookings;
SELECT * FROM tbl_tickets;
