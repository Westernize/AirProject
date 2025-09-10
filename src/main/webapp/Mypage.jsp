<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String userid = (String) session.getAttribute("userid");
String name = (String) session.getAttribute("name");

  if (userid == null) {
      // 로그인 안 된 상태면 로그인 페이지로 리다이렉트
      response.sendRedirect("login.jsp");
      return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>마이페이지</title>
  <link rel="stylesheet" href="test.css" />
  <style>
body {
  margin: 0;
  padding: 0; /* ← 여기를 0으로! */
  background-color: #f9f9f9;
  font-family: Arial, sans-serif;
}
    header {
      margin-bottom: 30px;
    }
    .mypage-menu {
      max-width: 600px;
      margin: 0 auto;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .mypage-menu h2 {
      margin-top: 0;
      margin-bottom: 20px;
      text-align: center;
      color: #333;
    }
    .menu-list {
      list-style: none;
      padding: 0;
    }
    .menu-list li {
      margin: 15px 0;
      text-align: center;
    }
    .menu-list a {
      display: inline-block;
      padding: 12px 25px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }
    .menu-list a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
  <header>
    <div class="top-bar">
      <div class="auth-links">
        <a href="MyReservationsServlet" class="username"><%= name %>님</a>
        <span class="divider">|</span>
        <a href="LogoutServlet">로그아웃</a>
      </div>
    </div>

    <ul class="list">
     <li><a href="main.jsp">메인</a></li>
      <li><a href="flight.jsp">항공권 예매</a></li>
      <li>
    <a href="<%= (userid != null) ? "MyReservationsServlet" : "inquiryForm.jsp" %>">나의 예약</a>
  </li>
      <li><a href="#">서비스 안내</a></li>
      <li><a href="#">온라인면세점</a></li>
      <li><a href="#">이벤트</a></li>
      <li><a href="#">멤버쉽</a></li>
    </ul>
  </header>

  <main>
  <section class="mypage-main" style="
      max-width: 900px;
      margin: 50px auto;
      background: #fff;
      padding: 40px 50px;
      border-radius: 15px;
      box-shadow: 0 20px 40px rgba(0,0,0,0.1);
      text-align: center;
      font-family: 'Arial', sans-serif;
  ">
    <h1 style="
        font-size: 2.8rem;
        color: #4b0082;
        margin-bottom: 40px;
        font-weight: 700;
    ">마이페이지에 오신 것을 환영합니다.<br>
    <%= name %>님!</h1>

    <div style="
        display: grid;
        grid-template-columns: repeat(auto-fit,minmax(280px,1fr));
        gap: 30px;
    ">
      <div style="
          background: #f0f0ff;
          border-radius: 15px;
          padding: 30px;
          box-shadow: 0 8px 24px rgba(102,126,234,0.3);
          transition: transform 0.3s ease;
          cursor: pointer;
      " 
      onmouseover="this.style.transform='translateY(-10px)';" 
      onmouseout="this.style.transform='translateY(0)';"
      >
        <div style="font-size: 60px; color: #764ba2; margin-bottom: 20px;">🎫</div>
        <h2 style="color:#4b0082; margin-bottom: 12px;">나의 예약 보기</h2>
        <p style="color: #666; margin-bottom: 20px;">예약한 항공권 내역을 확인하고 관리하세요.</p>
        <a href="MyReservationsServlet" style="
            display: inline-block;
            padding: 12px 28px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        " onmouseover="this.style.backgroundColor='#764ba2';" onmouseout="this.style.backgroundColor='#667eea';">예약 확인하기</a>
      </div>

      <div style="
          background: #f0f0ff;
          border-radius: 15px;
          padding: 30px;
          box-shadow: 0 8px 24px rgba(102,126,234,0.3);
          transition: transform 0.3s ease;
          cursor: pointer;
      "
      onmouseover="this.style.transform='translateY(-10px)';" 
      onmouseout="this.style.transform='translateY(0)';"
      >
        <div style="font-size: 60px; color: #764ba2; margin-bottom: 20px;">⚙️</div>
        <h2 style="color:#4b0082; margin-bottom: 12px;">회원 정보 수정</h2>
        <p style="color: #666; margin-bottom: 20px;">개인 정보를 안전하게 수정할 수 있습니다.</p>
        <a href="EditProfile.jsp" style="
            display: inline-block;
            padding: 12px 28px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        " onmouseover="this.style.backgroundColor='#764ba2';" onmouseout="this.style.backgroundColor='#667eea';">정보 수정하기</a>
      </div>
    </div>
  </section>
</main>
  
</body>
</html>
