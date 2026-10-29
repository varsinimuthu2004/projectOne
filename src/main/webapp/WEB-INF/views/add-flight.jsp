<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Flight - Admin</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .role-badge { background-color: #f59e0b; color: #000; font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 9999px; text-transform: uppercase; }
        .container { max-width: 760px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .card { background: #ffffff; border-radius: 0.75rem; padding: 2.25rem; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06); }
        .card-title { font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem; margin-bottom: 1.5rem; }
        @media (max-width: 600px) { .form-grid { grid-template-columns: 1fr; } }
        .form-group { margin-bottom: 0.5rem; }
        .form-group.full-width { grid-column: span 2; }
        @media (max-width: 600px) { .form-group.full-width { grid-column: span 1; } }
        .form-label { display: block; font-size: 0.875rem; font-weight: 600; margin-bottom: 0.4rem; color: #475569; }
        .form-input { width: 100%; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; border-radius: 0.5rem; font-size: 0.95rem; }
        .form-input:focus { outline: none; border-color: #10b981; box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.2); }
        .btn-green { display: block; width: 100%; padding: 0.85rem 1rem; border-radius: 0.5rem; font-size: 1rem; font-weight: 600; text-align: center; cursor: pointer; border: none; background-color: #10b981; color: #ffffff; transition: background 0.2s; }
        .btn-green:hover { background-color: #059669; }
        .alert-error { background-color: #fee2e2; color: #b91c1c; padding: 0.75rem 1rem; border-radius: 0.5rem; margin-bottom: 1.25rem; font-size: 0.875rem; }
        .alert-success { background-color: #d1fae5; color: #047857; padding: 0.75rem 1rem; border-radius: 0.5rem; margin-bottom: 1.25rem; font-size: 0.875rem; }
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
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/add-flight">Add Flight</a>
            <a href="${pageContext.request.contextPath}/admin/view-flights">View Flights</a>
            <span class="role-badge">Admin</span>
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <div class="card">
            <h2 class="card-title">✈ Add Flight</h2>

            <c:if test="${not empty errorMsg}">
                <div class="alert-error">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert-success">${successMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/add-flight" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="flightNumber">Flight Number</label>
                        <input type="text" id="flightNumber" name="flightNumber" class="form-input" placeholder="Enter flight number (e.g. AI101)" value="${flight.flightNumber}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="capacity">Capacity</label>
                        <input type="number" id="capacity" name="capacity" class="form-input" min="1" value="${flight.capacity != null ? flight.capacity : 20}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="source">Source</label>
                        <input type="text" id="source" name="source" class="form-input" placeholder="Enter source city" value="${flight.source}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="destination">Destination</label>
                        <input type="text" id="destination" name="destination" class="form-input" placeholder="Enter destination city" value="${flight.destination}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="departureTime">Departure Time</label>
                        <input type="text" id="departureTime" name="departureTime" class="form-input" placeholder="e.g. 06:00 or 14:30" value="${flight.departureTime}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="arrivalTime">Arrival Time</label>
                        <input type="text" id="arrivalTime" name="arrivalTime" class="form-input" placeholder="e.g. 08:15 or 16:45" value="${flight.arrivalTime}" required>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="pricePerSeat">Price per Seat (₹)</label>
                        <input type="number" step="0.01" id="pricePerSeat" name="pricePerSeat" class="form-input" placeholder="₹ 0.0" value="${flight.pricePerSeat}" required>
                    </div>
                </div>

                <button type="submit" class="btn-green">➕ Add Flight</button>
            </form>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
