<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>항공권 예약 - 로그인</title>
  <link rel="stylesheet" href="test.css" />
  <style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* 기본 설정 */
html, body {
  height: 100%;
  width: 100%;
  min-width: 1024px; /* 최소 폭 지정 */
  overflow-x: auto;  /* 넘칠 경우 가로 스크롤 허용 */
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 16px;
  background: #f0f4f8;
  color: #333;
}

header {
  border-bottom: 1px solid #1e40af;
  background: linear-gradient(90deg, #00c6ff, #0072ff);
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 20px;
}

/* 로그인 / 회원가입 상단 바 */
.top-bar {
  width: 100%;
  max-width: 1200px;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 10px 0;
  font-size: 14px;
  font-weight: 600;
}

/* 링크 스타일 */
.auth-links {
  display: flex;
  gap: 12px;
}

.auth-links a {
  color: white;
  text-decoration: none;
  white-space: nowrap;
  padding: 6px 16px;
  transition: color 0.3s ease;
  border-radius: 6px;
}

.auth-links a:hover {
  color: black;
  cursor: pointer;
  background-color: rgba(255 255 255 / 0.8);
}

.auth-links .divider {
  color: white;
  user-select: none;
  align-self: center;
  font-weight: 700;
}

/* 메뉴 리스트 */
.list {
  list-style: none;
  display: flex;
  gap: 20px;
  padding-bottom: 20px;
  margin: 0 auto 10px auto;
  max-width: 1200px;
  justify-content: center;
  width: 100%;
}

.list li a {
  font-size: 18px;
  text-decoration: none;
  padding-right: 30px;
  color: white;
  font-weight: 600;
  white-space: nowrap;
  position: relative;
  transition: color 0.3s ease;
}

.list li a::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -33px;
  width: 0;
  height: 5px;
  background: linear-gradient(90deg, #00f260, #0575e6);
  transition: width 0.3s ease;
  border-radius: 3px;
}

.list li a:hover {
  color: black;
}

.list li a:hover::after {
  width: 100%;
}

/* 반응형 */

/* 1300px 이하에서는 로그인/회원가입 메뉴 가운데 정렬 */
@media (max-width:1300px) {
  .top-bar {
    justify-content: center;
  }
}

/* 750px 이하에서는 로그인/회원가입 메뉴 숨김 처리 */
@media (max-width: 750px) {
  .top-bar {
    display: none;
  }
}


/* */
.flight-search {
  font-family: 'Segoe UI', sans-serif;
  background: #fff;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  max-width: 1200px;
  margin: 30px auto;
}

.trip-options {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

.trip-options button {
  padding: 8px 16px;
  border-radius: 20px;
  border: 1px solid #ccc;
  background: #fff;
  color: #333;
  cursor: pointer;
  transition: all 0.2s ease;
}

.trip-options button.active {
  background: #d32f2f;
  color: white;
  border-color: #d32f2f;
}

.trip-options button:hover {
  background: #f0f0f0;
}

.group-option {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: #333;
}

.discount-code {
  display: flex;
  align-items: center;
  margin-left: auto;
  gap: 8px;
  background: #f1f1f1;
  padding: 6px 10px;
  border-radius: 6px;
}

.discount-code input {
  border: none;
  background: transparent;
  outline: none;
  font-size: 14px;
}

.discount-code .tooltip {
  font-weight: bold;
  cursor: pointer;
  color: #555;
  background: #ddd;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
}

/* 검색 필드 */
.search-fields {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  align-items: center;
}

.search-fields input,
.search-fields .date-picker,
.search-fields .passenger-select {
  flex: 1;
  min-width: 120px;
  padding: 10px 4px;
  border: none;
  background: transparent;
  font-size: 16px;
  color: #333;
}

.underline {
  border-bottom: 1px solid #ccc;
}

.search-fields .date-picker span {
  color: #555;
}

.search-fields .passenger-select span {
  color: #222;
}

.search-btn {
  padding: 12px 20px;
  background: #d32f2f;
  color: white;
  border: none;
  font-weight: bold;
  border-radius: 6px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.search-btn:hover {
  background: #b71c1c;
}
.main-banner {
  width: 100%;
  height: 700px;
  object-fit: cover; /* 이미지 비율 유지하며 꽉 채우기 */
  display: block;
}




    h1 {
      text-align: center;
      color: #2E8B57;
      font-size: 42px;
      margin: 30px 0;
    }

.form-container {
    max-width: 450px;
    margin: 80px auto 60px auto; /* 위아래 간격, 좌우 중앙 정렬 */
    padding: 40px 30px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15); /* 크게 부드러운 그림자 */
    display: flex;
    flex-direction: column;
    gap: 20px;
}



    .form-box {
      background-color: #ffffff;
      padding: 20px 30px;
      border-radius: 12px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      width: 400px;
    }

    h2 {
      text-align: center;
      color: #333;
    }

    form input[type="text"],
    form input[type="password"] {
      width: 100%;
      padding: 10px;
      margin: 8px 0 16px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

form input[type="submit"] {
  width: 100%;
  padding: 10px;
  background: linear-gradient(90deg, #00aaff, #0066ff); /* 이미지 느낌 비슷한 그라데이션 */
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 700;
  transition: background 0.3s ease;
}

form input[type="submit"]:hover {
  background: linear-gradient(90deg, #0099ee, #0055dd);
}

    /* 로그인 전용 모드: 배너 숨김 */
    .login-mode .banner-section {
      display: none;
    }
    
    /* 회원가입 안내 문구 스타일 */
.muted {
  color: #777;
  font-size: 14px;
  text-align: center;
  margin-top: 12px;
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
      <a href="#" id="loginTrigger">로그인</a>
      <span class="divider">|</span>
      <a href="/AirProject/signup.jsp">회원가입</a>
    </div>
  </div>

  <ul class="list">
      <li><a href="main.jsp">메인</a></li>
    <li><a href="flight.jsp">항공권 예매</a></li>
    <li><a href="inquiryForm.jsp">나의 예약</a></li>
    <li><a href="#">서비스 안내</a></li>
    <li><a href="#">온라인면세점</a></li>
    <li><a href="#">이벤트</a></li>
    <li><a href="#">멤버쉽</a></li>  
  </ul>
</header>


<!-- ✅ 로그인 FORM -->
<div class="form-container">
  <div class="form-box">
    <h2>로그인</h2>
    <form action="login" method="post">
      아이디: <input type="text" name="userid" required>
      비밀번호: <input type="password" name="pwd" required>
      <input type="submit" value="로그인">
      <p class="muted mt-16">
      아직 계정이 없나요? <a id="openSignup" class="link" href="signup.jsp">회원가입</a>
    </p>
    </form>
  </div>
</div>

<script>
  const loginBtn = document.getElementById('loginTrigger');
  const body = document.body;

  loginBtn.addEventListener('click', function(e) {
    e.preventDefault();
    body.classList.add('login-mode');
    window.scrollTo(0, 0);
  });
</script>

</body>
</html>
