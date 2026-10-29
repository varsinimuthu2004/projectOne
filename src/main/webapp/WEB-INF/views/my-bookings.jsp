<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .container { max-width: 1000px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .page-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; }
        .table-card { background: #ffffff; border-radius: 0.75rem; overflow: hidden; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .bookings-table { width: 100%; border-collapse: collapse; }
        .bookings-table th { background-color: #f8fafc; color: #64748b; font-weight: 600; font-size: 0.85rem; text-align: left; padding: 1rem 1.25rem; border-bottom: 2px solid #e2e8f0; text-transform: uppercase; }
        .bookings-table td { padding: 1rem 1.25rem; border-bottom: 1px solid #e2e8f0; font-size: 0.95rem; vertical-align: middle; }
        .badge-confirmed { background-color: #d1fae5; color: #065f46; font-size: 0.75rem; font-weight: 700; padding: 0.25rem 0.6rem; border-radius: 0.375rem; text-transform: uppercase; }
        .badge-cancelled { background-color: #fee2e2; color: #991b1b; font-size: 0.75rem; font-weight: 700; padding: 0.25rem 0.6rem; border-radius: 0.375rem; text-transform: uppercase; }
        .btn { display: inline-block; padding: 0.45rem 0.85rem; border-radius: 0.375rem; font-size: 0.85rem; font-weight: 600; text-decoration: none; border: none; cursor: pointer; transition: all 0.2s; }
        .btn-view { background-color: #0284c7; color: #ffffff; }
        .btn-view:hover { background-color: #0369a1; }
        .btn-cancel { background-color: #ef4444; color: #ffffff; }
        .btn-cancel:hover { background-color: #dc2626; }
        .btn-disabled { background-color: #cbd5e1; color: #64748b; cursor: not-allowed; }
        .alert-info { background-color: #dbeafe; color: #1e40af; padding: 0.75rem 1.25rem; border-radius: 0.5rem; margin-bottom: 1.25rem; font-size: 0.875rem; }
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

    <main class="container">
        <h1 class="page-title">📅 My Bookings</h1>

        <c:if test="${not empty msg}">
            <div class="alert-info">${msg}</div>
        </c:if>

        <div class="table-card">
            <c:choose>
                <c:when test="${not empty bookings}">
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Flight Number</th>
                                <th>Journey Date</th>
                                <th>Status</th>
                                <th>Action</th>
                                <th>Cancel</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td><strong>#${b.bookingId}</strong></td>
                                    <td><strong>${b.flightNumber}</strong></td>
                                    <td>${b.journeyDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status eq 'confirmed'}">
                                                <span class="badge-confirmed">BOOKED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-cancelled">CANCELLED</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/booking/view-tickets?bookingId=${b.bookingId}" class="btn btn-view">
                                            👁 View Tickets
                                        </a>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status eq 'confirmed'}">
                                                <form action="${pageContext.request.contextPath}/booking/cancel" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel booking #${b.bookingId}? This will release your seats.');">
                                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                    <button type="submit" class="btn btn-cancel">Cancel</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-disabled" disabled>Cancel</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="padding: 2.5rem; text-align: center; color: #64748b;">
                        You have no bookings yet. <a href="${pageContext.request.contextPath}/home" style="color: #6366f1; font-weight: 600;">Search flights now</a>.
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
