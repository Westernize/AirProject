<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원가입 - 항공권 예약</title>
  <link rel="stylesheet" href="test.css" />
  <style>
    .form-container {
      display: flex;
      justify-content: center;
      padding: 40px 0;
    }

    .form-box {
      background-color: #ffffff;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 450px;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }

    form input[type="text"],
    form input[type="password"],
    form input[type="email"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 16px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 15px;
    }

    form input[type="submit"] {
      width: 100%;
      padding: 12px;
      background-color: #007BFF; /* 파란색 */
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 16px;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.5); /* 파란색 그림자 */
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    form input[type="submit"]:hover {
      background-color: #0056b3; /* 진한 파란색 */
      box-shadow: 0 6px 14px rgba(0, 86, 179, 0.7);
    }

    .muted {
      color: #777;
      font-size: 14px;
      text-align: center;
      margin-top: 16px;
    }

    .muted .link {
      color: #2E8B57;
      font-weight: bold;
      text-decoration: none;
      margin-left: 6px;
      transition: color 0.3s ease, text-decoration 0.3s ease;
    }

    .muted .link:hover {
      color: #1b5e3b;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<!-- ✅ HEADER -->
<header>
  <div class="top-bar">
    <div class="auth-links">
      <a href="/AirProject/login.jsp">로그인</a>
      <span class="divider">|</span>
      <a href="/AirProject/signup.jsp">회원가입</a>
    </div>
  </div>

  <ul class="list">
      <li><a href="main.jsp">메인</a></li>
    <li><a href="reservationform.jsp">항공권 예매</a></li>
    <li><a href="inquiryForm.jsp">나의 예약</a></li>
    <li><a href="#">서비스 안내</a></li>
    <li><a href="#">온라인면세점</a></li>
    <li><a href="#">이벤트</a></li>
    <li><a href="#">멤버쉽</a></li>  
  </ul>
</header>

<!-- ✅ 회원가입 FORM -->
<div class="form-container">
  <div class="form-box">
    <h2>회원가입</h2>
    <form action="register" method="post">
      아이디: <input type="text" name="userid" required />
      비밀번호: <input type="password" name="pwd" required />
      이름: <input type="text" name="name" required />
      전화번호: <input type="text" name="phone" />
      이메일: <input type="email" name="email" />
      <input type="submit" value="가입하기" />
      <p class="muted">
        이미 계정이 있나요? <a href="/AirProject/login.jsp" class="link">로그인</a>
      </p>
    </form>
  </div>
</div>

</body>
</html>
