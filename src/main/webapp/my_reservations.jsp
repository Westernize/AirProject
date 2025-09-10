<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.Reservation" %>

<%
    // 날짜 포맷
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new java.util.Date());

    // 로그인 체크
    String userid = (String) session.getAttribute("userid");
    String name = (String) session.getAttribute("name");
    if (userid == null || userid.trim().isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>나의 예약 내역</title>

    <!-- 외부 CSS -->
    <link rel="stylesheet" href="test.css" />
    <link rel="stylesheet" href="flight.css" />
    <link rel="stylesheet" href="main.css" />

    <!-- 내부 스타일 (예약 카드 디자인 및 취소 버튼) -->
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap');

    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(to right, #e0f2fe, #eff6ff);
        min-height: 100vh;
        color: #1e293b;
    }

    main {
        padding: 60px 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
    }

    h2 {
        font-size: 2.5rem;
        font-weight: 800;
        color: #0f172a;
        margin-bottom: 40px;
        text-align: center;
        letter-spacing: 1px;
    }

    .reservation-container {
        width: 100%;
        max-width: 1150px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 24px;
        padding: 60px 20px;
    }

    .reservation-card {
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        padding: 24px 28px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .reservation-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 28px rgba(0,0,0,0.1);
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
    }

    .card-header h3 {
        font-size: 1.3rem;
        font-weight: 700;
        color: #2563eb;
    }

    .cancel-btn {
        background-color: #ef4444; /* 빨간색 */
        color: white;
        border: none;
        padding: 6px 14px;
        border-radius: 6px;
        font-size: 0.9rem;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .cancel-btn:hover {
        background-color: #b91c1c; /* 진한 빨간색 */
    }

    .reservation-details {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        row-gap: 12px;
        column-gap: 30px;
        font-size: 0.95rem;
        line-height: 1.6;
    }

    .reservation-details span {
        display: block;
        color: #475569;
    }

    .reservation-details strong {
        display: block;
        font-weight: 600;
        color: #1e293b;
        margin-top: 2px;
    }

    .no-reservations {
        text-align: center;
        background: #fff;
        border-radius: 16px;
        padding: 80px 20px;
        color: #64748b;
        font-size: 1.2rem;
        font-style: italic;
        font-weight: 600;
        box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
    }

    @media (max-width: 768px) {
        h2 {
            font-size: 2rem;
            margin-bottom: 30px;
        }

        .reservation-details {
            grid-template-columns: repeat(2, 1fr);
            column-gap: 20px;
        }

        .card-header h3 {
            font-size: 1.1rem;
        }
    }
    </style>
</head>
<body>

<!-- Header 영역 -->
<header>
    <div class="top-bar">
        <div class="auth-links">
            <% if (userid == null) { %>
                <a href="/AirProject/login.jsp">로그인</a>
                <span class="divider">|</span>
                <a href="/AirProject/signup.jsp">회원가입</a>
            <% } else { %>
                <a href="Mypage.jsp" class="username"><%= name %>님</a>
                <span class="divider">|</span>
                <a href="/AirProject/LogoutServlet">로그아웃</a>
            <% } %>
        </div>
    </div>

    <ul class="list">
    <li><a href="loginsuccess.jsp">메인</a></li>
        <li><a href="flight.jsp">항공권 예매</a></li>
        <li><a href="MyReservationsServlet">나의 예약</a></li>
        <li><a href="#">서비스 안내</a></li>
        <li><a href="#">온라인면세점</a></li>
        <li><a href="#">이벤트</a></li>
        <li><a href="#">멤버쉽</a></li>
    </ul>
</header>

<!-- 본문: 예약 내역 -->
<h2><%= name %>님의 항공권 예약 내역</h2>

<div class="reservation-container">

<% if (reservations == null || reservations.isEmpty()) { %>
    <div class="no-reservations">예약 내역이 없습니다.</div>
<% } else {
     for (Reservation r : reservations) { %>

    <div class="reservation-card">
        <div class="card-header">
            <h3>예약번호: <%= r.getResId() %></h3>
            <form action="cancelReservation" method="post" onsubmit="return confirm('정말 예약을 취소하시겠습니까?');" style="margin:0;">
                <input type="hidden" name="resId" value="<%= r.getResId() %>" />
                <button type="submit" class="cancel-btn">예약 취소</button>
            </form>
        </div>
        <div class="reservation-details">
            <div>
                <span>여행 타입</span>
                <strong><%= r.getTripType() %></strong>
            </div>
            <div>
                <span>출발지</span>
                <strong><%= r.getOrigin() %></strong>
            </div>
            <div>
                <span>도착지</span>
                <strong><%= r.getDestination() %></strong>
            </div>
            <div>
                <span>출발일</span>
                <strong><%= r.getDepartDate() %></strong>
            </div>
            <div>
                <span>복귀일</span>
                <strong><%= (r.getReturnDate() == null || r.getReturnDate().equals("null")) ? "-" : r.getReturnDate() %></strong>
            </div>
            <div>
                <span>탑승 인원</span>
                <strong>
                    성인 <%= r.getAdultCount() %>명,
                    어린이 <%= r.getChildCount() %>명,
                    유아 <%= r.getInfantCount() %>명
                </strong>
            </div>
        </div>
    </div>

<%  }
   }
%>

</div>

</body>
</html>
