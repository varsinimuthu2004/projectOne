<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Reservation - Home</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        
        /* Navbar */
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; transition: color 0.2s; }
        .nav-links a:hover { color: #ffffff; }
        .role-badge { background-color: #f59e0b; color: #000; font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 9999px; text-transform: uppercase; }
        
        /* Container */
        .container { max-width: 1100px; margin: 2.5rem auto; padding: 0 1rem; flex: 1; width: 100%; }
        
        /* Grid Layout */
        .grid-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2.5rem; }
        @media (max-width: 768px) { .grid-cards { grid-template-columns: 1fr; } }
        
        .card { background: #ffffff; border-radius: 0.75rem; padding: 2rem; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .card-title { font-size: 1.25rem; font-weight: 700; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; color: #1e293b; }
        
        /* Forms */
        .form-group { margin-bottom: 1.25rem; }
        .form-label { display: block; font-size: 0.875rem; font-weight: 600; margin-bottom: 0.4rem; color: #475569; }
        .form-input { width: 100%; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; border-radius: 0.5rem; font-size: 0.95rem; }
        .form-input:focus { outline: none; border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2); }
        
        /* Buttons */
        .btn { display: inline-block; width: 100%; padding: 0.75rem 1rem; border: none; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; text-align: center; text-decoration: none; cursor: pointer; transition: all 0.2s; }
        .btn-purple { background-color: #6366f1; color: #ffffff; }
        .btn-purple:hover { background-color: #4f46e5; }
        .btn-outline { background-color: #ffffff; color: #6366f1; border: 1.5px solid #6366f1; }
        .btn-outline:hover { background-color: #eef2ff; }
        .btn-blue { background-color: #2563eb; color: #ffffff; }
        .btn-blue:hover { background-color: #1d4ed8; }
        .btn-sm { width: auto; padding: 0.45rem 1rem; font-size: 0.85rem; }
        
        /* Available Flights Table */
        .flights-section { background: #ffffff; border-radius: 0.75rem; padding: 2rem; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .flights-table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        .flights-table th { background-color: #f8fafc; color: #64748b; font-weight: 600; font-size: 0.85rem; text-align: left; padding: 0.85rem 1rem; border-bottom: 2px solid #e2e8f0; text-transform: uppercase; }
        .flights-table td { padding: 1rem; border-bottom: 1px solid #e2e8f0; font-size: 0.95rem; vertical-align: middle; }
        .flight-badge { background-color: #e0f2fe; color: #0284c7; padding: 0.25rem 0.6rem; border-radius: 0.375rem; font-weight: 700; font-size: 0.85rem; }
        .price-text { font-weight: 700; color: #059669; }
        
        /* Footer */
        .footer { background-color: #1e293b; color: #94a3b8; text-align: center; padding: 1.25rem 2rem; font-size: 0.875rem; margin-top: auto; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">
            <span>✈</span> Flight Reservation
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:choose>
                        <c:when test="${sessionScope.user.role eq 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                            <a href="${pageContext.request.contextPath}/admin/add-flight">Add Flight</a>
                            <a href="${pageContext.request.contextPath}/admin/view-flights">View Flights</a>
                            <span class="role-badge">Admin</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
                            <a href="${pageContext.request.contextPath}/booking/my-bookings">My Bookings</a>
                            <span class="role-badge">User</span>
                        </c:otherwise>
                    </c:choose>
                    <span>${sessionScope.user.email}</span>
                    <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">Login</a>
                    <a href="${pageContext.request.contextPath}/user/signup">Sign Up</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- Main Container -->
    <main class="container">
        <div class="grid-cards">
            <!-- Search Flights Card -->
            <div class="card">
                <h2 class="card-title">🔍 Search Flights</h2>
                <form action="${pageContext.request.contextPath}/home" method="get">
                    <div class="form-group">
                        <label class="form-label" for="source">From</label>
                        <input type="text" id="source" name="source" class="form-input" placeholder="Enter departure city" value="${searchedSource}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="destination">To</label>
                        <input type="text" id="destination" name="destination" class="form-input" placeholder="Enter destination city" value="${searchedDestination}" required>
                    </div>
                    <button type="submit" class="btn btn-purple">🔍 Search Flights</button>
                </form>
            </div>

            <!-- User Actions Card -->
            <div class="card">
                <h2 class="card-title">👤 User Actions</h2>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <p style="color: #64748b; margin-bottom: 1.5rem; line-height: 1.6;">
                            Please login to book flights and access your account.
                        </p>
                        <div style="display: flex; flex-direction: column; gap: 0.85rem;">
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-purple">Login</a>
                            <a href="${pageContext.request.contextPath}/user/signup" class="btn btn-outline">Sign Up</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p style="color: #64748b; margin-bottom: 1.5rem; line-height: 1.6;">
                            Logged in as <strong>${sessionScope.user.email}</strong>.
                        </p>
                        <div style="display: flex; flex-direction: column; gap: 0.85rem;">
                            <c:if test="${sessionScope.user.role eq 'user'}">
                                <a href="${pageContext.request.contextPath}/booking/my-bookings" class="btn btn-purple">View My Bookings</a>
                                <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline">Go to User Dashboard</a>
                            </c:if>
                            <c:if test="${sessionScope.user.role eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-purple">Admin Dashboard</a>
                                <a href="${pageContext.request.contextPath}/admin/add-flight" class="btn btn-outline">Add New Flight</a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Available Flights Results Section -->
        <c:if test="${hasSearched}">
            <section class="flights-section">
                <h2 class="card-title">✈ Available Flights (${flights.size()} found)</h2>
                <c:choose>
                    <c:when test="${not empty flights}">
                        <table class="flights-table">
                            <thead>
                                <tr>
                                    <th>Flight</th>
                                    <th>Route</th>
                                    <th>Schedule</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="flight" items="${flights}">
                                    <tr>
                                        <td>
                                            <span class="flight-badge">${flight.flightNumber}</span>
                                        </td>
                                        <td>
                                            <strong>${flight.source}</strong> → <strong>${flight.destination}</strong>
                                        </td>
                                        <td>
                                            <div>Dep: <strong>${flight.departureTime}</strong></div>
                                            <div style="color: #64748b; font-size: 0.85rem;">Arr: <strong>${flight.arrivalTime}</strong></div>
                                        </td>
                                        <td>
                                            <span class="price-text">₹ ${flight.pricePerSeat}</span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/booking/form?flightId=${flight.flightId}" class="btn btn-blue btn-sm">
                                                Book
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p style="color: #64748b; padding: 1.5rem 0; text-align: center;">
                            No flights found between <strong>${searchedSource}</strong> and <strong>${searchedDestination}</strong>.
                        </p>
                    </c:otherwise>
                </c:choose>
            </section>
        </c:if>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
