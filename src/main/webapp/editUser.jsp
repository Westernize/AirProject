<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>회원 정보 수정</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
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
      max-width: 600px;
      margin: auto;
      padding: 2rem;
      background: #fff;
    }
    .card h2 {
      font-weight: 700;
      margin-bottom: 1.5rem;
      color: #0d6efd;
      text-align: center;
    }
    label {
      font-weight: 600;
      color: #212529;
    }
    .form-control:focus {
      border-color: #0d6efd;
      box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    }
    .btn-primary {
      background-color: #0d6efd;
      border-color: #0d6efd;
      font-weight: 600;
      padding: 0.5rem 1.5rem;
      border-radius: 8px;
      transition: background-color 0.3s;
    }
    .btn-primary:hover {
      background-color: #0b5ed7;
      border-color: #0a58ca;
    }
    .btn-secondary {
      padding: 0.5rem 1.5rem;
      border-radius: 8px;
      font-weight: 600;
    }
    .error-message {
      color: #dc3545;
      font-weight: 600;
      margin-bottom: 1rem;
      text-align: center;
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
        <li class="nav-item mb-2"><a href="AdminDashboard.jsp" class="nav-link">홈</a></li>
        <li class="nav-item mb-2"><a href="ManageUsersServlet" class="nav-link active">회원 관리</a></li>
        <li class="nav-item mb-2"><a href="ManageReservationsServlet" class="nav-link">예약 관리</a></li>
        <li class="nav-item"><a href="LogoutServlet" class="nav-link text-danger">로그아웃</a></li>
      </ul>
    </nav>

    <main class="content">
      <div class="card">
        <h2>회원 정보 수정</h2>

        <c:if test="${not empty errorMessage}">
          <p class="error-message">${errorMessage}</p>
        </c:if>

        <form action="EditUserServlet" method="post" novalidate>
          <input type="hidden" name="userid" value="${member.userid}" />

          <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" class="form-control" value="${member.userid}" readonly />
          </div>

          <div class="mb-3">
            <label for="pwd" class="form-label">비밀번호 (변경 시 입력)</label>
            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="새 비밀번호 입력">
          </div>

          <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" value="${member.name}" required>
          </div>

          <div class="mb-3">
            <label for="phone" class="form-label">전화번호</label>
            <input type="text" class="form-control" id="phone" name="phone" value="${member.phone}">
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="email" name="email" value="${member.email}" required>
          </div>

          <div class="d-flex justify-content-center gap-3">
            <button type="submit" class="btn btn-primary">수정하기</button>
            <button type="button" class="btn btn-secondary" onclick="location.href='ManageUsersServlet'">취소</button>
          </div>
        </form>
      </div>
    </main>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
