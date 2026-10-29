<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Reservation - Login</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .nav-links a:hover { color: #ffffff; }
        .auth-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem; }
        .auth-card { background: #ffffff; border-radius: 0.75rem; padding: 2.5rem; width: 100%; max-width: 420px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); }
        .auth-title { font-size: 1.5rem; font-weight: 700; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; color: #1e293b; }
        .form-group { margin-bottom: 1.25rem; }
        .form-label { display: block; font-size: 0.875rem; font-weight: 600; margin-bottom: 0.4rem; color: #475569; }
        .form-input { width: 100%; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; border-radius: 0.5rem; font-size: 0.95rem; }
        .form-input:focus { outline: none; border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2); }
        .btn { width: 100%; padding: 0.75rem 1rem; border: none; border-radius: 0.5rem; font-size: 0.95rem; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-purple { background-color: #6366f1; color: #ffffff; }
        .btn-purple:hover { background-color: #4f46e5; }
        .auth-footer { text-align: center; margin-top: 1.5rem; font-size: 0.875rem; color: #64748b; }
        .auth-footer a { color: #6366f1; text-decoration: none; font-weight: 600; }
        .auth-footer a:hover { text-decoration: underline; }
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
            <a href="${pageContext.request.contextPath}/user/login">Login</a>
            <a href="${pageContext.request.contextPath}/user/signup">Sign Up</a>
        </div>
    </nav>

    <div class="auth-container">
        <div class="auth-card">
            <h2 class="auth-title">🚪 Login</h2>

            <c:if test="${not empty errorMsg}">
                <div class="alert-error">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert-success">${successMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-input" placeholder="Enter your email" value="${loginDto.email}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-input" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn btn-purple">Login</button>
            </form>

            <div class="auth-footer">
                Don't have an account? <a href="${pageContext.request.contextPath}/user/signup">Sign up here</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
