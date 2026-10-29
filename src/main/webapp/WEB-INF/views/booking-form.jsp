<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Flight - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .booking-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem; }
        .booking-card { background: #ffffff; border-radius: 0.75rem; padding: 2rem; width: 100%; max-width: 500px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); }
        .card-header-title { font-size: 1.35rem; font-weight: 700; margin-bottom: 1.25rem; color: #1e293b; }
        .flight-banner { background-color: #e0f2fe; color: #0369a1; padding: 0.85rem 1.25rem; border-radius: 0.5rem; font-weight: 700; font-size: 1.05rem; margin-bottom: 1.5rem; display: flex; justify-content: space-between; align-items: center; }
        .form-group { margin-bottom: 1.25rem; }
        .form-label { display: block; font-size: 0.875rem; font-weight: 600; margin-bottom: 0.4rem; color: #475569; }
        .form-input { width: 100%; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; border-radius: 0.5rem; font-size: 0.95rem; }
        .form-input:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2); }
        .subtext { font-size: 0.75rem; color: #64748b; margin-top: 0.35rem; }
        .btn { display: block; width: 100%; padding: 0.75rem 1rem; border: none; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; text-align: center; text-decoration: none; cursor: pointer; transition: all 0.2s; margin-bottom: 0.75rem; }
        .btn-blue { background-color: #2563eb; color: #ffffff; }
        .btn-blue:hover { background-color: #1d4ed8; }
        .btn-secondary { background-color: #64748b; color: #ffffff; }
        .btn-secondary:hover { background-color: #475569; }
        .alert-error { background-color: #fee2e2; color: #b91c1c; padding: 0.75rem 1rem; border-radius: 0.5rem; margin-bottom: 1.25rem; font-size: 0.875rem; }
        .footer { background-color: #1e293b; color: #94a3b8; text-align: center; padding: 1.25rem 2rem; font-size: 0.875rem; margin-top: auto; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">
            <span>✈</span> Flight Reservation
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/booking/my-bookings">My Bookings</a>
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <div class="booking-container">
        <div class="booking-card">
            <h2 class="card-header-title">Book Flight</h2>

            <div class="flight-banner">
                <span>Flight Number: ${flight.flightNumber}</span>
                <span style="font-size: 0.9rem; font-weight: 600;">₹ ${flight.pricePerSeat} / seat</span>
            </div>

            <div style="background: #f8fafc; padding: 0.75rem 1rem; border-radius: 0.5rem; margin-bottom: 1.25rem; font-size: 0.9rem; color: #475569;">
                <div>Route: <strong>${flight.source}</strong> → <strong>${flight.destination}</strong></div>
                <div>Timing: <strong>${flight.departureTime}</strong> - <strong>${flight.arrivalTime}</strong></div>
            </div>

            <c:if test="${not empty errorMsg}">
                <div class="alert-error">${errorMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/booking/form" method="post">
                <input type="hidden" name="flightId" value="${flight.flightId}">

                <div class="form-group">
                    <label class="form-label" for="journeyDate">Journey Date *</label>
                    <input type="date" id="journeyDate" name="journeyDate" class="form-input" min="${minDate}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="numberOfPassengers">Number of Passengers *</label>
                    <input type="number" id="numberOfPassengers" name="numberOfPassengers" class="form-input" min="1" max="10" value="1" required>
                    <div class="subtext">Maximum 10 passengers allowed</div>
                </div>

                <button type="submit" class="btn btn-blue">Book Now</button>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-secondary">Back to Dashboard</a>
            </form>
        </div>
    </div>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
