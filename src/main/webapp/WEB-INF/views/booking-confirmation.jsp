<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed! - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .confirm-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem; }
        .confirm-card { background: #ffffff; border-radius: 0.75rem; overflow: hidden; width: 100%; max-width: 540px; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08); text-align: center; }
        .confirm-header { background-color: #10b981; color: #ffffff; padding: 1rem; font-size: 1.15rem; font-weight: 700; display: flex; align-items: center; justify-content: center; gap: 0.5rem; }
        .confirm-body { padding: 2rem; }
        .plane-icon { font-size: 2.5rem; color: #10b981; margin-bottom: 0.75rem; }
        .congrats-title { font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 1.25rem; }
        .booking-id-banner { background-color: #e0f2fe; color: #0284c7; padding: 0.85rem; border-radius: 0.5rem; font-size: 1.15rem; font-weight: 700; margin-bottom: 1.75rem; border-left: 4px solid #0284c7; }
        .features-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1rem; margin-bottom: 1.75rem; }
        .feature-box { background: #f8fafc; padding: 0.85rem 0.5rem; border-radius: 0.5rem; border: 1px solid #e2e8f0; font-size: 0.8rem; }
        .feature-icon { font-size: 1.25rem; margin-bottom: 0.25rem; }
        .feature-title { font-weight: 700; color: #1e293b; margin-bottom: 0.2rem; }
        .feature-sub { color: #64748b; font-size: 0.725rem; }
        .next-steps-card { background-color: #f8fafc; border: 1px solid #e2e8f0; border-radius: 0.5rem; padding: 1rem 1.25rem; text-align: left; margin-bottom: 1.75rem; font-size: 0.85rem; }
        .next-steps-title { font-weight: 700; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.4rem; color: #334155; }
        .next-steps-list { list-style: none; color: #64748b; line-height: 1.6; }
        .next-steps-list li::before { content: "✓ "; color: #10b981; font-weight: 700; margin-right: 0.35rem; }
        .btn-group { display: flex; gap: 1rem; }
        .btn { flex: 1; padding: 0.75rem 1rem; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; text-decoration: none; text-align: center; cursor: pointer; transition: all 0.2s; border: none; }
        .btn-green { background-color: #10b981; color: #ffffff; }
        .btn-green:hover { background-color: #059669; }
        .btn-outline-blue { background-color: #ffffff; color: #2563eb; border: 1.5px solid #2563eb; }
        .btn-outline-blue:hover { background-color: #eff6ff; }
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

    <div class="confirm-container">
        <div class="confirm-card">
            <div class="confirm-header">
                <span>✓</span> Booking Confirmed!
            </div>

            <div class="confirm-body">
                <div class="plane-icon">✈</div>
                <h2 class="congrats-title">Congratulations! Your flight is booked!</h2>

                <div class="booking-id-banner">
                    ✉ Booking ID: ${booking.bookingId}
                </div>

                <div class="features-grid">
                    <div class="feature-box">
                        <div class="feature-icon">🛡</div>
                        <div class="feature-title">Secured</div>
                        <div class="feature-sub">Your booking is protected</div>
                    </div>
                    <div class="feature-box">
                        <div class="feature-icon">✉</div>
                        <div class="feature-title">Email Sent</div>
                        <div class="feature-sub">Confirmation details sent</div>
                    </div>
                    <div class="feature-box">
                        <div class="feature-icon">☑</div>
                        <div class="feature-title">Ready</div>
                        <div class="feature-sub">Check-in 24hrs before</div>
                    </div>
                </div>

                <div class="next-steps-card">
                    <div class="next-steps-title">
                        <span>ℹ</span> Next Steps:
                    </div>
                    <ul class="next-steps-list">
                        <li>Save your booking ID for future reference</li>
                        <li>Check your email for detailed itinerary</li>
                        <li>Arrive at airport 2 hours before departure</li>
                        <li>Complete online check-in 24 hours before flight</li>
                    </ul>
                </div>

                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-green">⌂ Go to Dashboard</a>
                    <a href="${pageContext.request.contextPath}/booking/view-tickets?bookingId=${booking.bookingId}" class="btn btn-outline-blue">🖨 Print Confirmation</a>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
