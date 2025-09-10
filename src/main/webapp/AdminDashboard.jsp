<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%
  Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
  if (isAdmin == null || !isAdmin) {
      response.sendRedirect("main.jsp");
      return;
  }

  MemberDAO dao = new MemberDAO();
  int totalUsers = dao.countUsers();
  int totalReservations = dao.countReservations();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>관리자 대시보드</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .navbar-brand {
      font-weight: 700;
      font-size: 1.8rem;
      letter-spacing: 1.5px;
    }
    .sidebar {
      width: 220px;
      min-height: 100vh;
      background-color: #fff;
      border-right: 1px solid #dee2e6;
    }
    .nav-link {
      font-size: 1.1rem;
      padding: 12px 20px;
      color: #495057;
      transition: background-color 0.3s, color 0.3s;
    }
    .nav-link.active,
    .nav-link:hover {
      background-color: #0d6efd;
      color: #fff !important;
      border-radius: 8px;
    }
    .content {
      flex-grow: 1;
      padding: 2rem;
    }
    .card {
      box-shadow: 0 4px 12px rgb(0 0 0 / 0.1);
      border: none;
      border-radius: 12px;
      transition: transform 0.3s ease;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgb(0 0 0 / 0.15);
    }
    .card-title {
      font-weight: 600;
      color: #212529;
      margin-bottom: 1rem;
    }
    .display-4 {
      font-weight: 700;
      color: #0d6efd;
      font-size: 3.5rem;
      margin: 0;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-dark bg-primary px-4">
    <a class="navbar-brand" href="#">관리자 대시보드</a>
  </nav>
  <div class="d-flex">
    <nav class="sidebar d-flex flex-column p-3">
      <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item mb-2"><a href="AdminDashboard.jsp" class="nav-link active">홈</a></li>
        <li class="nav-item mb-2"><a href="ManageUsersServlet" class="nav-link">회원 관리</a></li>
        <li class="nav-item mb-2"><a href="ManageReservationsServlet" class="nav-link">예약 관리</a></li>
        <li class="nav-item"><a href="LogoutServlet" class="nav-link text-danger">로그아웃</a></li>
      </ul>
    </nav>
    <main class="content">
      <div class="container-fluid">
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card text-center p-4">
              <h5 class="card-title">총 회원 수</h5>
              <p class="display-4"><%= totalUsers %></p>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card text-center p-4">
              <h5 class="card-title">전체 예약 수</h5>
              <p class="display-4"><%= totalReservations %></p>
            </div>
          </div>
        </div>
        
        <div class="row mt-5">
          <div class="col-12">
            <div class="card p-4">
              <h5 class="card-title mb-4">회원 및 예약 통계</h5>
              <canvas id="statsChart" height="100"></canvas>
            </div>
          </div>
        </div>
        
      </div>
    </main>
  </div>

  <script>
    const ctx = document.getElementById('statsChart').getContext('2d');

    const statsChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['총 회원 수', '전체 예약 수'],
        datasets: [{
          label: '건수',
          data: [<%= totalUsers %>, <%= totalReservations %>],
          backgroundColor: [
            'rgba(13, 110, 253, 0.7)',
            'rgba(220, 53, 69, 0.7)'
          ],
          borderColor: [
            'rgba(13, 110, 253, 1)',
            'rgba(220, 53, 69, 1)'
          ],
          borderWidth: 1,
          borderRadius: 6,
          maxBarThickness: 100,
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 1
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          tooltip: {
            enabled: true
          }
        }
      }
    });
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
