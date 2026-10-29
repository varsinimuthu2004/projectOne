<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .error-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem; }
        .error-card { background: #ffffff; border-radius: 0.75rem; padding: 2.5rem; width: 100%; max-width: 500px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); text-align: center; }
        .error-icon { font-size: 3rem; margin-bottom: 1rem; color: #ef4444; }
        .error-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; margin-bottom: 0.5rem; }
        .error-msg { background: #fef2f2; border: 1px solid #fee2e2; color: #991b1b; padding: 1rem; border-radius: 0.5rem; font-size: 0.9rem; margin-bottom: 1.5rem; line-height: 1.5; }
        .btn { display: inline-block; padding: 0.75rem 1.5rem; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; text-decoration: none; cursor: pointer; background-color: #6366f1; color: #ffffff; }
        .btn:hover { background-color: #4f46e5; }
        .footer { background-color: #1e293b; color: #94a3b8; text-align: center; padding: 1.25rem 2rem; font-size: 0.875rem; margin-top: auto; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">
            <span>✈</span> Flight Reservation
        </a>
    </nav>

    <div class="error-container">
        <div class="error-card">
            <div class="error-icon">⚠</div>
            <h1 class="error-title">Oops! Something went wrong</h1>
            <div class="error-msg">
                <c:choose>
                    <c:when test="${not empty errorMessage}">
                        ${errorMessage}
                    </c:when>
                    <c:otherwise>
                        An unexpected application error occurred.
                    </c:otherwise>
                </c:choose>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn">Return to Home Page</a>
        </div>
    </div>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
