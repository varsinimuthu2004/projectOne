<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Flight Reservation</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; }
        body { background-color: #f4f6f8; color: #1e293b; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background-color: #1e293b; color: #ffffff; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; color: #ffffff; text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
        .nav-links { display: flex; align-items: center; gap: 1.5rem; }
        .nav-links a { color: #cbd5e1; text-decoration: none; font-size: 0.95rem; font-weight: 500; }
        .nav-links a:hover { color: #ffffff; }
        .role-badge { background-color: #f59e0b; color: #000; font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 9999px; text-transform: uppercase; }
        .container { max-width: 1000px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .page-header { margin-bottom: 2rem; }
        .page-title { font-size: 1.5rem; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.35rem; }
        .welcome-text { color: #64748b; font-size: 0.95rem; }
        .section-title { font-size: 1.15rem; font-weight: 700; color: #334155; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.5rem; }
        .cards-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        @media (max-width: 640px) { .cards-grid { grid-template-columns: 1fr; } }
        .action-card { background: #ffffff; border-radius: 0.75rem; padding: 2.5rem 2rem; text-align: center; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .card-icon { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1rem; }
        .icon-blue { background-color: #eff6ff; color: #2563eb; }
        .icon-green { background-color: #ecfdf5; color: #10b981; }
        .card-heading { font-size: 1.2rem; font-weight: 700; color: #1e293b; margin-bottom: 0.5rem; }
        .card-desc { font-size: 0.875rem; color: #64748b; margin-bottom: 1.5rem; line-height: 1.5; }
        .btn { display: inline-block; padding: 0.65rem 1.5rem; border-radius: 0.5rem; font-size: 0.9rem; font-weight: 600; text-decoration: none; cursor: pointer; transition: all 0.2s; border: none; }
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
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/add-flight">Add Flight</a>
            <a href="${pageContext.request.contextPath}/admin/view-flights">View Flights</a>
            <span>${adminUser.email}</span>
            <span class="role-badge">Admin</span>
            <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <div class="page-header">
            <h1 class="page-title">🛡 Admin Dashboard</h1>
            <p class="welcome-text">Welcome, ${adminUser.email}!</p>
        </div>

        <h2 class="section-title">✈ Flight Management</h2>

        <div class="cards-grid">
            <!-- Add Flight Card -->
            <div class="action-card">
                <div class="card-icon icon-blue">➕</div>
                <h3 class="card-heading">Add New Flight</h3>
                <p class="card-desc">Create new flight routes and schedules for your airline.</p>
                <a href="${pageContext.request.contextPath}/admin/add-flight" class="btn btn-purple">Add Flight</a>
            </div>

            <!-- View Flights Card -->
            <div class="action-card">
                <div class="card-icon icon-green">📋</div>
                <h3 class="card-heading">View Flights</h3>
                <p class="card-desc">View and manage all existing flight schedules and journeys.</p>
                <a href="${pageContext.request.contextPath}/admin/view-flights" class="btn btn-green">View Flights</a>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024 Flight Reservation. All rights reserved.</p>
    </footer>

</body>
</html>
