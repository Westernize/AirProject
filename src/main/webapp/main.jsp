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
  <link rel="stylesheet" href="flight.css">
  <link rel="stylesheet" href="main.css">


  
<style>
  /* 1) 추천 섹션 안의 header는 투명하게 (전역 헤더 스타일 무효화) */
  .recommend-section > header{
    background: transparent !important;
    border: 0 !important;
    box-shadow: none !important;
    padding: 0 !important;
  }
  /* 이 header 안의 빈 top-bar, list도 표시 안 함 */
  .recommend-section > header .top-bar,
  .recommend-section > header .list{
    display: none !important;
  }

  /* 2) 테마 배너(‘테마’ 충만 여행) 크기 축소 */
  .theme-strip{
    /* 글자 크기 작게 */
    font-size: clamp(22px, 2.4vw, 36px);
    line-height: 1.25;

    /* 박스 크기/여백 축소 */
    padding: 12px 18px;
    margin: 18px auto 10px;
    max-width: 900px;                 /* 기존 1200px → 900px */
    width: min(900px, 92vw);

    /* 나머지 스타일은 유지 */
    display: flex;
    align-items: center;
    justify-content: center;
    gap: .4rem;
    border-radius: 12px;               /* 살짝 더 작게 */
    background: linear-gradient(90deg, #ffe9cc, #fff2df);
    border: 2px solid #d7a56a;
    color: #2b2b2b;
    font-weight: 700;
  }
  .theme-strip .em{ color:#8c4a16; font-weight: 800; }
  .theme-strip .emoji{ font-size: .95em; vertical-align: -0.1em; }
</style>

  <!-- ⬆⬆ 추가 끝 -->
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

  <div class="banner-section">
    <img 
      src="https://contents-image.twayair.com/contents/2025/0512/e313f435-bd78-40dd-9d82-cc55585ab121.png" 
      alt="항공권 배너" 
      class="main-banner"
    >

    <div class="flight-hero">
      <div class="flight-card">
        <!-- 버튼 추가 -->
        <div class="tab-buttons">
          <button type="button" id="reservationBtn" class="active" onclick="showReservationForm()">예약</button>
          <button type="button" id="inquiryBtn" onclick="showReservationInquiry()">예약조회</button>
        </div>

        <!-- 예약 폼 -->
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
              <input type="text" name="origin" placeholder="출발지" list="airportList" required />
            </div>
            <div class="field">
              <label>도착지</label>
              <input type="text" name="destination" placeholder="도착지" list="airportList" required />
            </div>
          </div>

          <!-- 가는/오는 날 -->
          <div class="row">
            <div class="field">
              <label>가는 날</label>
              <input type="date" id="departDate" name="departDate" min="<%=today%>" value="<%=today%>" required />
            </div>
            <div class="field">
              <label>오는 날</label>
              <input type="date" id="returnDate" name="returnDate" min="<%=today%>" />
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
              <input type="hidden" name="adult" id="adultInput" value="1" />
            </div>

            <!-- 소아 -->
            <div class="counter">
              <div class="label">소아</div>
              <div class="ctrl">
                <button type="button" class="btn minus" onclick="changeCnt('child',-1)">−</button>
                <span id="childCnt">0</span>
                <button type="button" class="btn plus" onclick="changeCnt('child',1)">＋</button>
              </div>
              <input type="hidden" name="child" id="childInput" value="0" />
            </div>

            <!-- 유아 -->
            <div class="counter">
              <div class="label">유아</div>
              <div class="ctrl">
                <button type="button" class="btn minus" onclick="changeCnt('infant',-1)">−</button>
                <span id="infantCnt">0</span>
                <button type="button" class="btn plus" onclick="changeCnt('infant',1)">＋</button>
              </div>
              <input type="hidden" name="infant" id="infantInput" value="0" />
            </div>
          </div>

          <!-- 조회 버튼 -->
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

        <!-- 예약조회 폼 (초기 숨김) -->
        <form id="inquiryForm" action="/AirProject/InquiryServlet" method="post" style="display:none; margin-top: 20px;">
          <div class="form-fields">
            <div class="form-group">
              <label for="reservationNumber">예약 번호 (숫자만 입력)</label>
              <input type="text" id="reservationNumber" name="reservationNumber" placeholder="숫자만 입력" pattern="\d+" required
                title="예약 번호는 숫자만 입력해야 합니다." />
            </div>

            <div class="form-group">
              <label for="userId">이름</label>
              <input type="text" id="userId" name="userId" placeholder="이름 입력" required />
            </div>

            <div class="form-group">
              <label for="departureDate">출발일</label>
              <input type="date" id="departureDate" name="departureDate" required />
            </div>
            <button type="submit" class="submit-btn">조회</button>
          </div>
        </form>
      </div> <!-- .flight-card 닫기 -->
    </div> <!-- .flight-hero 닫기 -->
  </div> <!-- .banner-section 닫기 -->

  <!-- 고객님을 위한 맞춤 항공권 섹션 -->
  <section class="recommend-section">
  <section class="recommend-section">
    <header>
      <!-- 테마 배너 -->
      <div class="theme-strip">
       <span class="emoji">🛫</span>
      <span class="emoji">하나투어와 </span>&nbsp;
        <span class="em">‘자유’</span>&nbsp;충만 여행
        <span class="emoji">🛬</span>
      </div>

      <div class="top-bar"> </div>
      <ul class="list"></ul>
    </header>

    <h2>고객님을 위한 맞춤 항공권✈️</h2>
    
  </section>

  <div class="recommend-list">
    <!-- 카드 1 -->
    <!-- 카드 1 -->
<div class="card">
  <a href="https://hope.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=AKP1002509127CG&depDay=20250912&allSearchKeyword=%EC%A0%9C%EC%A3%BC%EB%8F%84&allSearchTab=domestic&newWin=true"
     target="_blank" rel="noopener" class="card-cover">
    <img src="https://image.hanatour.com/usr/cms/resize/400_0/2020/12/02/20000/3be48d78-cb37-4363-8ddf-d90472761c3d.jpg" alt="제주(Jeju)">
  </a>
  <div class="card-body">
    <p class="route">김포(GMP)</p>
    <h3>제주(Jeju)</h3>
    <p class="price">KRW 65,000</p>
    <p class="date">2025.09.11 (목)</p>
  </div>
</div>


    <!-- 카드 2 -->
    <div class="card">
  <!-- ✅ 이미지만 링크로 감싸기 -->
  <a href="https://hope.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=JOX71025091800E&depDay=20250918&allSearchKeyword=%EC%98%A4%EC%82%AC%EC%B9%B4&allSearchTab=package&newWin=true"
     target="_blank" rel="noopener" class="card-cover">
    <img src="https://image.hanatour.com/usr/cms/resize/800_0/2018/12/04/10000/62187bae-8f65-4c84-8706-5a682e6c8e97.jpg"
         alt="오사카/간사이(KIX)">
  </a>

  <div class="card-body">
    <p class="route">인천(ICN)</p>
    <h3>오사카/간사이(KIX)</h3>
    <p class="price">KRW 125,000</p>
    <p class="date">2025.09.11 (금)</p>
  </div>
</div>


    <!-- 카드 3 -->
    <div class="card">
    <a href="https://hope.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=JTX71025100900H&depDay=20251009&allSearchKeyword=%EB%8F%84%EC%BF%84&allSearchTab=package&newWin=true"
     target="_blank" rel="noopener" class="card-cover">
      <img src=https://image.hanatour.com/usr/manual/md/2024/06/PL00115002/bnr_co_a.jpg alt="임시">
      </a>
      <div class="card-body">
        <p class="route">인천(ICN)</p>
        <h3>도쿄 나리타(NRT)</h3>
        <p class="price">KRW 150,000</p>
        <p class="date">2025.09.12 (토)</p>
      </div>
    </div>
  </div>
</section>

<!-- 고객님을 위한 맞춤 숙소 섹션 -->
<section class="recommend-section">
  <h2>고객님을 위한 맞춤 숙소🏠</h2>
  <div class="recommend-list">
    <div class="card">
     <a href="https://wtdomc.hanatour.com/DH/dh_detail.asp?wGdsCode=DHH001463"
     target="_blank" rel="noopener" class="card-cover">
      <img src=https://img.webtour.com/WebUpload/CMS/500/2021052319141481526790.jpg alt="숙소 1">
      </a>
      <div class="card-body">
        <h3>탐라스테이 제주 </h3>
        <p class="price">KRW 110,000 / 박</p>
        <p class="date">2025.09.11 - 2025.09.12</p>
      </div>
    </div>

    <div class="card">
     <a href="https://hope.hanatour.com/trp/htl/CHPC0HTL0200M200?hotelCode=K24590&countryCode=JP&allSearchKeyword=%EC%98%A4%EC%82%AC%EC%B9%B4&newWin=true"
     target="_blank" rel="noopener" class="card-cover">   
      <img src=https://image.hanatour.com/usr/cms/resize/400_0/2020/04/08/500000/048abea2-24e1-4b09-aa5a-76e212ceb68c.jpg alt="숙소 2">
      </a>
      <div class="card-body">
        <h3>오사카 히노데 호텔 닛본바시</h3>
        <p class="price">KRW 230,000 / 박</p>
        <p class="date">2025.09.12 - 2025.09.14</p>
      </div>
    </div>

    <div class="card">
     <a href="https://hope.hanatour.com/trp/htl/CHPC0HTL0200M200?hotelCode=G45011&countryCode=JP&allSearchKeyword=%ED%94%84%EB%A6%B0%EC%8A%A4%20%EC%8B%A0%EC%A3%BC&newWin=true"
     target="_blank" rel="noopener" class="card-cover">   
      <img src=https://image.hanatour.com/usr/cms/resize/400_0/2020/03/27/470000/a108c845-6f9b-430d-a2dc-fca34939c75f.jpg alt="숙소 3">
      </a>
      <div class="card-body">
        <h3>프린스 신주큐 호텔</h3>
        <p class="price">KRW 240,000 / 박</p>
        <p class="date">2025.09.14 - 2025.09.17</p>
      </div>
    </div>
  </div>
</section>

  <script>
    // 기존 스크립트 유지
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

    // 예약 / 예약조회 토글 함수
    function showReservationForm(){
      document.getElementById('flightForm').style.display = 'block';
      document.getElementById('inquiryForm').style.display = 'none';
      document.getElementById('reservationBtn').classList.add('active');
      document.getElementById('inquiryBtn').classList.remove('active');
    }
    function showReservationInquiry(){
      document.getElementById('flightForm').style.display = 'none';
      document.getElementById('inquiryForm').style.display = 'block';
      document.getElementById('reservationBtn').classList.remove('active');
      document.getElementById('inquiryBtn').classList.add('active');
    }
  </script>

</body>
</html>
