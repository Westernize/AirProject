<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>예약 완료</title>
  <link rel="stylesheet" href="success.css"> <!-- 선택: CSS 파일 분리 -->
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f5f9ff;
      text-align: center;
      padding: 80px 20px;
    }
    .success-container {
      background: white;
      padding: 40px;
      max-width: 600px;
      margin: auto;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .success-container h1 {
      color: #0078D7;
      margin-bottom: 20px;
    }
    .success-container p {
      font-size: 18px;
      margin-bottom: 10px;
    }
    .btn {
      margin-top: 30px;
      display: inline-block;
      padding: 10px 20px;
      background: #0078D7;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      font-weight: bold;
      transition: background 0.3s;
    }
    .btn:hover {
      background: #005bb5;
    }
  </style>
</head>
<body>

<div class="success-container">
  <h1>예약이 완료되었습니다 ✈️</h1>
  <p>정상적으로 항공권 예약이 처리되었습니다.</p>
  <p>마이페이지에서 예약 상세 정보를 확인하실 수 있습니다.</p>

  <a href="loginsuccess.jsp" class="btn">메인으로 돌아가기</a>
  <a href="MyReservationsServlet" class="btn" style="background:#28a745;">나의 예약 보기</a>
</div>

</body>
</html>
