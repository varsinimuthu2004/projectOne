<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Passenger - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .passenger-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem; }
        .passenger-card { background: #ffffff; border-radius: 0.75rem; padding: 2.25rem; width: 100%; max-width: 480px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); }
        .card-title { font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 0.25rem; }
        .card-subtitle { font-size: 0.85rem; color: #64748b; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1.25rem; }
        .form-label { display: block; font-size: 0.875rem; font-weight: 600; margin-bottom: 0.4rem; color: #475569; }
        .form-input, .form-select { width: 100%; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; border-radius: 0.5rem; font-size: 0.95rem; background-color: #ffffff; }
        .form-input:focus, .form-select:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2); }
        .btn { width: 100%; padding: 0.85rem 1rem; border: none; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-blue { background-color: #2563eb; color: #ffffff; }
        .btn-blue:hover { background-color: #1d4ed8; }
        .progress-container { margin-top: 1.75rem; }
        .progress-bar-bg { width: 100%; height: 8px; background-color: #e2e8f0; border-radius: 9999px; overflow: hidden; }
        .progress-bar-fill { height: 100%; background-color: #2563eb; border-radius: 9999px; transition: width 0.3s; }
        .progress-text { font-size: 0.8rem; color: #64748b; margin-top: 0.5rem; }
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
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <div class="passenger-container">
        <div class="passenger-card">
            <h2 class="card-title">Add Passenger ${passengerNumber}</h2>
            <div class="card-subtitle">Remaining passengers: ${remainingPassengers}</div>

            <c:if test="${not empty errorMsg}">
                <div class="alert-error">${errorMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/booking/passenger" method="post">
                <div class="form-group">
                    <label class="form-label" for="passengerName">Passenger Name *</label>
                    <input type="text" id="passengerName" name="passengerName" class="form-input" placeholder="Enter full name" value="${passengerDto.passengerName}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="age">Age *</label>
                    <input type="number" id="age" name="age" class="form-input" min="1" max="120" placeholder="Enter age" value="${passengerDto.age}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="gender">Gender *</label>
                    <select id="gender" name="gender" class="form-select" required>
                        <option value="">Select Gender</option>
                        <option value="male" ${passengerDto.gender eq 'male' ? 'selected' : ''}>Male</option>
                        <option value="female" ${passengerDto.gender eq 'female' ? 'selected' : ''}>Female</option>
                        <option value="other" ${passengerDto.gender eq 'other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>

                <c:choose>
                    <c:when test="${isLastPassenger}">
                        <button type="submit" class="btn btn-blue">Complete Booking</button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" class="btn btn-blue">Add Passenger & Continue</button>
                    </c:otherwise>
                </c:choose>
            </form>

            <!-- Progress Bar -->
            <div class="progress-container">
                <div class="progress-bar-bg">
                    <div class="progress-bar-fill" style="width: ${(passengerNumber * 100) / totalPassengers}%;"></div>
                </div>
                <div class="progress-text">Passenger ${passengerNumber} of ${totalPassengers}</div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
