<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .nav-links a:hover { color: #ffffff; }
        .container { max-width: 900px; margin: 3rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .page-header { margin-bottom: 2rem; }
        .page-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.35rem; }
        .welcome-text { color: #64748b; font-size: 0.95rem; }
        .cards-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        @media (max-width: 640px) { .cards-grid { grid-template-columns: 1fr; } }
        .dashboard-card { background: #ffffff; border-radius: 0.75rem; padding: 2.25rem 2rem; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column; align-items: flex-start; }
        .card-heading { font-size: 1.25rem; font-weight: 700; color: #1e293b; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.5rem; }
        .btn { display: inline-block; padding: 0.65rem 1.5rem; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; text-decoration: none; cursor: pointer; transition: all 0.2s; border: none; }
        .btn-purple { background-color: #6366f1; color: #ffffff; }
        .btn-purple:hover { background-color: #4f46e5; }
        .btn-green { background-color: #10b981; color: #ffffff; }
        .btn-green:hover { background-color: #059669; }
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
            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
            <span>${user.email}</span>
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <div class="page-header">
            <h1 class="page-title">👤 My Dashboard</h1>
            <p class="welcome-text">Welcome, ${user.email}!</p>
        </div>

        <div class="cards-grid">
            <!-- My Bookings Card -->
            <div class="dashboard-card">
                <h3 class="card-heading">📅 My Bookings</h3>
                <p style="color: #64748b; font-size: 0.875rem; margin-bottom: 1.5rem;">
                    View your booked flights, ticket details, or cancel reservations.
                </p>
                <a href="${pageContext.request.contextPath}/booking/my-bookings" class="btn btn-purple">View My Bookings</a>
            </div>

            <!-- Search Flights Card -->
            <div class="dashboard-card">
                <h3 class="card-heading">🔍 Search Flights</h3>
                <p style="color: #64748b; font-size: 0.875rem; margin-bottom: 1.5rem;">
                    Browse and book upcoming flights across popular destinations.
                </p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-green">Find Flights</a>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
