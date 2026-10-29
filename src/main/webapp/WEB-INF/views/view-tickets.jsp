<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tickets - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .container { max-width: 950px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.75rem; }
        .page-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; }
        .page-subtitle { font-size: 0.875rem; color: #64748b; margin-top: 0.25rem; }
        .tickets-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(380px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        @media (max-width: 480px) { .tickets-grid { grid-template-columns: 1fr; } }
        .ticket-card { background: #ffffff; border-radius: 0.75rem; overflow: hidden; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); border: 1px solid #e2e8f0; }
        .ticket-header { background-color: #0284c7; color: #ffffff; padding: 0.85rem 1.25rem; display: flex; justify-content: space-between; align-items: center; font-weight: 700; }
        .ticket-pnr { background-color: rgba(255, 255, 255, 0.2); padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.85rem; }
        .ticket-body { padding: 1.25rem; }
        .section-label { font-size: 0.85rem; font-weight: 700; color: #0284c7; margin-bottom: 0.6rem; display: flex; align-items: center; gap: 0.35rem; }
        .info-row { display: flex; justify-content: space-between; font-size: 0.875rem; margin-bottom: 0.5rem; }
        .info-col { flex: 1; }
        .label { color: #64748b; font-size: 0.775rem; margin-bottom: 0.15rem; }
        .value { font-weight: 600; color: #1e293b; }
        .seat-badge { background-color: #0284c7; color: #ffffff; padding: 0.2rem 0.55rem; border-radius: 0.25rem; font-weight: 700; display: inline-block; }
        .divider { height: 1px; background-color: #f1f5f9; margin: 0.85rem 0; }
        .status-badge { background-color: #1e293b; color: #ffffff; padding: 0.2rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; }
        .btn-print { background-color: #2563eb; color: #ffffff; padding: 0.65rem 1.25rem; border-radius: 0.375rem; border: none; font-size: 0.9rem; font-weight: 600; cursor: pointer; text-decoration: none; }
        .footer { background-color: #1e293b; color: #94a3b8; text-align: center; padding: 1.25rem 2rem; font-size: 0.875rem; margin-top: auto; }
        @media print {
            .navbar, .footer, .btn-print, .btn-back { display: none; }
            body { background: #ffffff; }
            .container { margin: 0; padding: 0; max-width: 100%; }
            .ticket-card { box-shadow: none; border: 2px solid #000; break-inside: avoid; }
        }
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
        <div class="page-header">
            <div>
                <h1 class="page-title">🎫 My Tickets</h1>
                <p class="page-subtitle">View and download your flight tickets (Booking #${booking.bookingId})</p>
            </div>
            <div style="display: flex; gap: 0.75rem;">
                <a href="${pageContext.request.contextPath}/booking/my-bookings" class="btn-print" style="background-color: #64748b;">← Back</a>
                <button onclick="window.print()" class="btn-print">🖨 Print Tickets</button>
            </div>
        </div>

        <div class="tickets-grid">
            <c:forEach var="t" items="${tickets}">
                <div class="ticket-card">
                    <div class="ticket-header">
                        <span>✈ Flight Ticket</span>
                        <span class="ticket-pnr">PNR: ${t.pnrNo}</span>
                    </div>

                    <div class="ticket-body">
                        <!-- Passenger Information -->
                        <div class="section-label">👤 Passenger Information</div>
                        <div class="info-row">
                            <div class="info-col">
                                <div class="label">Name</div>
                                <div class="value">${t.passengerName}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-col">
                                <div class="label">Gender</div>
                                <div class="value" style="text-transform: capitalize;">${t.gender}</div>
                            </div>
                            <div class="info-col">
                                <div class="label">Age</div>
                                <div class="value">${t.age} years</div>
                            </div>
                        </div>

                        <div class="divider"></div>

                        <!-- Travel Information -->
                        <div class="section-label">✈ Travel Information</div>
                        <div class="info-row">
                            <div class="info-col">
                                <div class="label">Flight Number</div>
                                <div class="value">${t.flightNumber != null ? t.flightNumber : booking.flightNumber}</div>
                            </div>
                            <div class="info-col">
                                <div class="label">Journey Date</div>
                                <div class="value">${t.journeyDate}</div>
                            </div>
                            <div class="info-col">
                                <div class="label">Seat Number</div>
                                <span class="seat-badge">${t.seatNo}</span>
                            </div>
                        </div>

                        <div class="divider"></div>

                        <!-- Booking Details -->
                        <div class="section-label">📄 Booking Details</div>
                        <div class="info-row">
                            <div class="info-col">
                                <div class="label">Booking ID</div>
                                <div class="value">#${t.bookingId}</div>
                            </div>
                            <div class="info-col">
                                <div class="label">Status</div>
                                <span class="status-badge" style="background-color: ${t.status eq 'confirmed' ? '#10b981' : '#ef4444'};">
                                    ${t.status eq 'confirmed' ? 'BOOKED' : 'CANCELLED'}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
