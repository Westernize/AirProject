<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
  String today = sdf.format(new java.util.Date());

  Object loginUser = session.getAttribute("user");
  boolean isLoggedIn = loginUser != null;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>항공권 예약 및 조회</title>
  <link rel="stylesheet" href="test.css" />
  <link rel="stylesheet" href="flight.css" />
  
  <style>
    .reservation-content {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 40px auto;
      max-width: 1200px;
      padding: 40px 40px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      background: #f9fbfd;
    }

    .reservation-content h1 {
      text-align: center;
      font-weight: 700;
      color: #007acc;
      margin-bottom: 30px;
    }

    .error {
      background-color: #ffe6e6;
      border: 1px solid #ff4d4d;
      padding: 15px 20px;
      border-radius: 8px;
      color: #d8000c;
      font-weight: 700;
      margin-bottom: 25px;
      box-shadow: 0 0 5px rgba(216,0,12,0.3);
    }

    /* 입력 폼 영역 */
    .form-container {
      max-width: 400px;
      margin: 0 auto 50px auto;
    }

    form {
      background: white;
      padding: 25px 30px;
      border-radius: 12px;
      box-shadow: 0 6px 14px rgba(0,122,204,0.15);
    }

    form input[type="text"],
    form input[type="date"] {
      width: 100%;
      padding: 12px 15px;
      margin: 8px 0 20px 0;
      border: 1.8px solid #c6d8f9;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
      outline-offset: 2px;
    }

    form input[type="text"]:focus,
    form input[type="date"]:focus {
      border-color: #007acc;
      box-shadow: 0 0 8px rgba(0, 122, 204, 0.4);
    }

    form input[type="submit"] {
      background: linear-gradient(90deg, #00c4ff, #008cff);
      border: none;
      color: white;
      font-weight: 700;
      font-size: 1.1rem;
      padding: 14px 0;
      border-radius: 10px;
      cursor: pointer;
      width: 100%;
      transition: background 0.3s ease;
    }

    form input[type="submit"]:hover {
      background: linear-gradient(90deg, #008cff, #005fbb);
    }

    /* 예약 정보 카드 스타일 (넓게 유지) */
    .card {
      background: #ffffff;
      border-radius: 16px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
      padding: 30px 40px;
      margin: 0 auto; /* 가운데 정렬 */
      max-width: 1150px;
    }

    .card h2 {
      font-size: 1.6rem;
      font-weight: 700;
      color: #2563eb;
      margin-bottom: 25px;
      border-bottom: 2px solid #60a5fa;
      padding-bottom: 10px;
    }

    .info-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px 40px;
      font-size: 0.95rem;
      line-height: 1.6;
    }

    .info-grid div {
      display: flex;
      flex-direction: column;
    }

    .info-grid span {
      color: #64748b;
      font-size: 0.9rem;
    }

    .info-grid strong {
      margin-top: 4px;
      color: #1e293b;
      font-weight: 600;
      font-size: 1.05rem;
    }

    @media (max-width: 768px) {
      .info-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    @media (max-width: 480px) {
      .form-container {
        max-width: 100%;
        padding: 0 15px;
      }
      .info-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

  <header>
    <div class="top-bar">
      <div class="auth-links">
        <c:choose>
          <c:when test="${isLoggedIn}">
            <span>환영합니다, ${loginUser}님</span>
            <span class="divider">|</span>
            <a href="/AirProject/logout.jsp">로그아웃</a>
          </c:when>
          <c:otherwise>
            <a href="/AirProject/login.jsp">로그인</a>
            <span class="divider">|</span>
            <a href="/AirProject/signup.jsp">회원가입</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <ul class="list">
        <li><a href="main.jsp">메인</a></li>
      <li><a href="flight.jsp">항공권 예매</a></li>
      <li><a href="MyReservationsServlet">나의 예약</a></li>
      <li><a href="#">서비스 안내</a></li>
      <li><a href="#">온라인면세점</a></li>
      <li><a href="#">이벤트</a></li>
      <li><a href="#">멤버쉽</a></li>
    </ul>
  </header>

  <div class="reservation-content">
    <h1>예약 조회</h1>

    <c:if test="${not empty errorMessage}">
      <div class="error">${errorMessage}</div>
    </c:if>

    <div class="form-container">
      <form action="InquiryServlet" method="post">
        예약 번호: <input type="text" name="reservationNumber" value="${param.reservationNumber != null ? param.reservationNumber : ''}" required><br><br>
        사용자 ID: <input type="text" name="userId" value="${param.userId != null ? param.userId : ''}" required><br><br>
        출발일 (yyyy-MM-dd): <input type="date" name="departureDate" value="${param.departureDate != null ? param.departureDate : ''}" required><br><br>
        <input type="submit" value="조회">
      </form>
    </div>

    <c:if test="${not empty reservationNumber}">
      <div class="card">
        <h2>예약 정보</h2>
        <div class="info-grid">
          <div><span>예약 번호</span><strong>${reservationNumber}</strong></div>
          <div><span>사용자 ID</span><strong>${userId}</strong></div>
          <div><span>여행 타입</span><strong>${tripType}</strong></div>
          <div><span>출발지</span><strong>${origin}</strong></div>
          <div><span>도착지</span><strong>${destination}</strong></div>
          <div><span>출발일</span><strong>${departDate}</strong></div>
          <div><span>복귀일</span>
            <strong>
              <c:choose>
                <c:when test="${empty returnDate || returnDate eq 'null'}">-</c:when>
                <c:otherwise>${returnDate}</c:otherwise>
              </c:choose>
            </strong>
          </div>
          <div><span>탑승 인원</span>
            <strong>성인 ${adultCount}명, 어린이 ${childCount}명, 유아 ${infantCount}명</strong>
          </div>
        </div>
      </div>
    </c:if>

  </div>

</body>
</html>
