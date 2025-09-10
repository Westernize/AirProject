<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
  String today = sdf.format(new java.util.Date());

  // 로그인 여부 확인
  String userid = (String) session.getAttribute("userid");
  String name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>항공권 예약</title>
  <link rel="stylesheet" href="test.css">
  <link rel="stylesheet" href="flight_1.css">
</head>
<body>
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
        <li><a href="main.jsp">메인</a></li>
      <li><a href="flight.jsp">항공권 예매</a></li>
      <li><a href="inquiryForm.jsp">나의 예약</a></li>
      <li><a href="#">서비스 안내</a></li>
      <li><a href="#">온라인면세점</a></li>
      <li><a href="#">이벤트</a></li>
      <li><a href="#">멤버쉽</a></li>
    </ul>
  </header>

    <!-- 항공권 검색 폼 시작 -->
    <div class="flight-hero">
      <div class="flight-card">
        <h2>항공권 검색</h2>

        <form id="flightForm" action="/AirProject/ReservationServlet1" method="get">
          <!-- 여정 -->
          <div class="trip-type">
            <label><input type="radio" name="trip" value="ONE_WAY" onclick="toggleReturn(false)" checked> 편도</label>
            <label><input type="radio" name="trip" value="ROUND" onclick="toggleReturn(true)"> 왕복</label>
          </div>

          <!-- 출발/도착 -->
          <div class="row">
            <div class="field">
              <label>출발지</label>
              <input type="text" name="origin" placeholder="출발지" list="airportList" required>
            </div>
            <div class="field">
              <label>도착지</label>
              <input type="text" name="destination" placeholder="도착지" list="airportList" required>
            </div>
          </div>

          <!-- 가는/오는 날 -->
          <div class="row">
            <div class="field">
              <label>가는 날</label>
              <input type="date" id="departDate" name="departDate" min="<%=today%>" value="<%=today%>" required>
            </div>
            <div class="field">
              <label>오는 날</label>
              <input type="date" id="returnDate" name="returnDate" min="<%=today%>">
            </div>
          </div>

          <!-- 인원수 -->
          <div class="row counters">
            <!-- 성인 -->
            <div class="counter">
              <div class="label">성인</div>
              <div class="ctrl">
                <button type="button" class="btn minus" onclick="changeCnt('adult',-1)">−</button>
                <span id="adultCnt">1</span>
                <button type="button" class="btn plus" onclick="changeCnt('adult',1)">＋</button>
              </div>
              <input type="hidden" name="adult" id="adultInput" value="1">
            </div>

            <!-- 소아 -->
            <div class="counter">
              <div class="label">소아</div>
              <div class="ctrl">
                <button type="button" class="btn minus" onclick="changeCnt('child',-1)">−</button>
                <span id="childCnt">0</span>
                <button type="button" class="btn plus" onclick="changeCnt('child',1)">＋</button>
              </div>
              <input type="hidden" name="child" id="childInput" value="0">
            </div>

            <!-- 유아 -->
            <div class="counter">
              <div class="label">유아</div>
              <div class="ctrl">
                <button type="button" class="btn minus" onclick="changeCnt('infant',-1)">−</button>
                <span id="infantCnt">0</span>
                <button type="button" class="btn plus" onclick="changeCnt('infant',1)">＋</button>
              </div>
              <input type="hidden" name="infant" id="infantInput" value="0">
            </div>
          </div>

          <div class="actions">
            <button type="submit" class="submit-btn">항공편 조회</button>
          </div>

          <!-- datalist -->
          <datalist id="airportList">
            <option value="ICN" label="인천(ICN)"></option>
            <option value="GMP" label="김포(GMP)"></option>
            <option value="CJU" label="제주(CJU)"></option>
            <option value="NRT" label="도쿄 나리타(NRT)"></option>
            <option value="KIX" label="오사카 간사이(KIX)"></option>
            <option value="PUS" label="김해(PUS)"></option>
          </datalist>
        </form>
      </div>
    </div>
    <!-- 항공권 검색 폼 끝 -->
  </div>

  <!-- 스크립트 -->
  <script>
    function toggleReturn(isRound){
      const r = document.getElementById('returnDate');
      const d = document.getElementById('departDate');
      if (!r || !d) return;

      r.disabled = !isRound;
      if (!isRound){
        r.value = '';
      } else {
        r.min = d.value || r.min;
        if (r.value && r.value < r.min) r.value = r.min;
      }
    }

    function changeCnt(type, delta){
      const span  = document.getElementById(type + 'Cnt');
      const input = document.getElementById(type + 'Input');
      if (!span || !input) return;

      let v = parseInt(input.value || '0', 10) + delta;
      const min = (type === 'adult') ? 1 : 0;
      const max = 9;
      if (v < min) v = min;
      if (v > max) v = max;

      input.value = v;
      span.textContent = v;
    }

    function setupDateGuards(){
      const depart = document.getElementById('departDate');
      const ret = document.getElementById('returnDate');
      if (!depart || !ret) return;

      const syncReturnMin = () => {
        ret.min = depart.value || ret.min;
        if (ret.value && ret.value < ret.min) ret.value = ret.min;
      };
      depart.addEventListener('change', syncReturnMin);
      depart.addEventListener('input',  () => {
        if (depart.value < depart.min) depart.value = depart.min;
        syncReturnMin();
      });

      ret.addEventListener('input', () => {
        if (ret.value && ret.min && ret.value < ret.min) ret.value = ret.min;
      });

      document.querySelectorAll('input[name="trip"]').forEach(radio => {
        radio.addEventListener('change', () => {
          const isRound = (radio.value === 'ROUND');
          toggleReturn(isRound);
        });
      });
    }

    document.addEventListener('DOMContentLoaded', () => {
      setupDateGuards();
      const initIsRound = document.querySelector('input[name="trip"][value="ROUND"]')?.checked;
      toggleReturn(!!initIsRound);
    });
  </script>
  </body>
  </html>