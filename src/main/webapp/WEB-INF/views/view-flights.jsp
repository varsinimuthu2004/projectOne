<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Journey Status - Admin</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .role-badge { background-color: #f59e0b; color: #000; font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 9999px; text-transform: uppercase; }
        .container { max-width: 1100px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .header-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
        .page-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 0.5rem; }
        .btn-back { background-color: #475569; color: #ffffff; padding: 0.55rem 1.15rem; border-radius: 0.375rem; text-decoration: none; font-size: 0.875rem; font-weight: 600; }
        .date-banner { background-color: #e0f2fe; color: #0369a1; padding: 0.85rem 1.25rem; border-radius: 0.5rem; font-weight: 600; font-size: 0.95rem; margin-bottom: 1.75rem; }
        .tabs-header { display: flex; gap: 1rem; border-bottom: 2px solid #e2e8f0; margin-bottom: 1.5rem; }
        .tab-btn { background: none; border: none; padding: 0.75rem 1.25rem; font-size: 0.95rem; font-weight: 600; color: #64748b; cursor: pointer; border-bottom: 3px solid transparent; margin-bottom: -2px; display: flex; align-items: center; gap: 0.5rem; }
        .tab-btn.active { color: #2563eb; border-bottom-color: #2563eb; }
        .count-badge { background-color: #2563eb; color: #ffffff; font-size: 0.75rem; padding: 0.15rem 0.5rem; border-radius: 9999px; font-weight: 700; }
        .count-badge.green { background-color: #10b981; }
        .table-card { background: #ffffff; border-radius: 0.75rem; overflow: hidden; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .status-table { width: 100%; border-collapse: collapse; }
        .status-table th { background-color: #f8fafc; color: #64748b; font-weight: 600; font-size: 0.85rem; text-align: left; padding: 1rem 1.25rem; border-bottom: 2px solid #e2e8f0; text-transform: uppercase; }
        .status-table td { padding: 1rem 1.25rem; border-bottom: 1px solid #e2e8f0; font-size: 0.95rem; vertical-align: middle; }
        .flight-code { background-color: #0284c7; color: #ffffff; padding: 0.25rem 0.6rem; border-radius: 0.25rem; font-weight: 700; font-size: 0.85rem; }
        .passenger-pill { background-color: #3b82f6; color: #ffffff; padding: 0.2rem 0.5rem; border-radius: 9999px; font-weight: 600; font-size: 0.8rem; }
        .booking-pill { background-color: #64748b; color: #ffffff; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-weight: 600; font-size: 0.8rem; }
        .revenue-text { font-weight: 700; color: #059669; }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
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
            <span class="role-badge">Admin</span>
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <div class="header-bar">
            <h1 class="page-title">✈ Flight Journey Status</h1>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">← Back to Dashboard</a>
        </div>

        <div class="date-banner">
            📅 Current Date: <strong>${currentDate}</strong>
        </div>

        <!-- Tabs -->
        <div class="tabs-header">
            <button class="tab-btn active" onclick="switchTab('upcoming', this)">
                Upcoming Journeys <span class="count-badge">${upcomingJourneys.size()}</span>
            </button>
            <button class="tab-btn" onclick="switchTab('completed', this)">
                Completed Journeys <span class="count-badge green">${completedJourneys.size()}</span>
            </button>
        </div>

        <!-- Upcoming Journeys Tab -->
        <div id="upcoming" class="tab-content active">
            <div class="table-card">
                <c:choose>
                    <c:when test="${not empty upcomingJourneys}">
                        <table class="status-table">
                            <thead>
                                <tr>
                                    <th>Flight Number</th>
                                    <th>Journey Date</th>
                                    <th>Total Passengers</th>
                                    <th>Total Bookings</th>
                                    <th>Total Revenue</th>
                                    <th>Days Until Journey</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${upcomingJourneys}">
                                    <tr>
                                        <td><span class="flight-code">${item.flightNumber}</span></td>
                                        <td><strong>${item.journeyDate}</strong></td>
                                        <td><span class="passenger-pill">👥 ${item.totalPassengers}</span></td>
                                        <td><span class="booking-pill">${item.totalBookings}</span></td>
                                        <td><span class="revenue-text">₹ ${item.totalRevenue}</span></td>
                                        <td>${item.daysDifference} days</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p style="padding: 2.5rem; text-align: center; color: #64748b;">No upcoming flight journeys with bookings found.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Completed Journeys Tab -->
        <div id="completed" class="tab-content">
            <div class="table-card">
                <c:choose>
                    <c:when test="${not empty completedJourneys}">
                        <table class="status-table">
                            <thead>
                                <tr>
                                    <th>Flight Number</th>
                                    <th>Journey Date</th>
                                    <th>Total Passengers</th>
                                    <th>Total Bookings</th>
                                    <th>Total Revenue</th>
                                    <th>Days Since Journey</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${completedJourneys}">
                                    <tr>
                                        <td><span class="flight-code">${item.flightNumber}</span></td>
                                        <td><strong>${item.journeyDate}</strong></td>
                                        <td><span class="passenger-pill">👥 ${item.totalPassengers}</span></td>
                                        <td><span class="booking-pill">${item.totalBookings}</span></td>
                                        <td><span class="revenue-text">₹ ${item.totalRevenue}</span></td>
                                        <td>${item.daysDifference} days ago</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p style="padding: 2.5rem; text-align: center; color: #64748b;">No completed flight journeys found.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        function switchTab(tabId, btn) {
            document.querySelectorAll('.tab-content').forEach(function(el) {
                el.classList.remove('active');
            });
            document.querySelectorAll('.tab-btn').forEach(function(el) {
                el.classList.remove('active');
            });
            document.getElementById(tabId).classList.add('active');
            btn.classList.add('active');
        }
    </script>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
