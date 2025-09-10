<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String userid = (String) session.getAttribute("userid");
  if (userid == null) {
      response.sendRedirect("login.jsp");
      return;
  }

  // 예: DB에서 사용자 정보를 조회했다고 가정 (실제 구현 시 DB 연결 필요)
  String name = "";  
  String phone = ""; 
  String email = ""; 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원정보 수정 - 항공권 예약</title>
  <link rel="stylesheet" href="test.css" />
  <style>
    .form-container {
      display: flex;
      justify-content: center;
      padding: 60px 20px;
    }

    .form-box {
      background: #ffffff;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
      width: 100%;
      max-width: 520px;
    }

    .form-box h2 {
      text-align: center;
      font-size: 26px;
      font-weight: bold;
      color: #4b0082;
      margin-bottom: 30px;
    }

    .input-group {
      margin-bottom: 20px;
    }

    .input-group label {
      font-weight: 600;
      color: #333;
      margin-bottom: 6px;
      display: block;
    }

    .input-group input {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 15px;
      background-color: #f8f9ff;
      box-sizing: border-box;
      transition: border 0.2s;
    }

    .input-group input:focus {
      border-color: #7c4dff;
      outline: none;
    }

    .btn-group {
      display: flex;
      justify-content: space-between;
      gap: 10px;
      margin-top: 30px;
    }

    .btn {
      flex: 1;
      padding: 12px;
      font-size: 15px;
      font-weight: bold;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-update {
      background-color: #4b6eff;
      color: #fff;
      box-shadow: 0 4px 12px rgba(75, 110, 255, 0.3);
    }

    .btn-update:hover {
      background-color: #3a5ad0;
    }

    .btn-delete {
      background-color: #ff4d4f;
      color: white;
      box-shadow: 0 4px 12px rgba(255, 77, 79, 0.3);
    }

    .btn-delete:hover {
      background-color: #cc0000;
    }
  </style>
</head>
<body>

<!-- ✅ HEADER -->
<header>
  <div class="top-bar">
    <div class="auth-links">
      <a href="Mypage.jsp"><%= userid %>님</a>
      <span class="divider">|</span>
      <a href="LogoutServlet">로그아웃</a>
    </div>
  </div>

  <ul class="list">
    <li><a href="main.jsp">메인</a></li>
    <li><a href="reservationform.jsp">항공권 예매</a></li>
    <li><a href="MyReservationsServlet">나의 예약</a></li>
    <li><a href="#">서비스 안내</a></li>
    <li><a href="#">온라인면세점</a></li>
    <li><a href="#">이벤트</a></li>
    <li><a href="#">멤버쉽</a></li>  
  </ul>
</header>

	<!-- ✅ 회원정보 수정 폼 -->
	<div class="form-container">
	  <div class="form-box">
	    <h2>회원정보 수정</h2>
	    <form action="UpdateProfileServlet" method="post" onsubmit="return confirm('정말 수정하시겠습니까?')">
	  <div class="input-group">
	    <label>아이디 (수정 불가)</label>
	    <input type="text" name="userid" value="<%= userid %>" readonly />
	  </div>
	
	  <div class="input-group">
	    <label>비밀번호 (변경 시 입력)</label>
	    <input type="password" name="pwd" placeholder="비밀번호를 변경하려면 입력하세요" />
	  </div>
	
	  <div class="input-group">
  <label>이름</label>
  <input type="text" name="name" value="<%= name %>" required placeholder="이름을 입력하세요" />
</div>

<div class="input-group">
  <label>전화번호</label>
  <input type="text" name="phone" value="<%= phone %>" required placeholder="전화번호를 입력하세요" />
</div>

<div class="input-group">
  <label>이메일</label>
  <input type="email" name="email" value="<%= email %>" required placeholder="이메일을 입력하세요" />
</div>

	
	  <div class="btn-group">
	    <button type="submit" class="btn btn-update">정보 수정 완료</button>
	  </div>
	</form>

<form action="DeleteAccountServlet" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?')" style="margin-top: 20px;">
  <input type="hidden" name="userid" value="<%= userid %>" />
  <button type="submit" class="btn btn-delete" style="width: 100%;">회원 탈퇴</button>
</form>
    
  </div>
</div>

</body>
</html>
