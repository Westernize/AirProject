<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, servlet.Reservation"%>

<%
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
if (isAdmin == null || !isAdmin) {
    response.sendRedirect("main.jsp");
    return;
}

List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
if (reservations == null) {
    reservations = new java.util.ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>예약 관리</title>

<!-- Fonts, Bootstrap, Icons, SweetAlert2 -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />

<style>
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
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
    border-radius: 8px;
}

.nav-link.active,
.nav-link:hover {
    background-color: #0d6efd;
    color: #fff !important;
}

.content {
    flex-grow: 1;
    padding: 2rem;
}

h1 {
    font-size: 2.2rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #2c3e50;
    text-align: center;
}

.search-box {
    max-width: 450px;
    margin: 0 auto 2.5rem;
}

.search-box input {
    width: 100%;
    padding: 0.65rem 1.2rem;
    font-size: 1.1rem;
    border-radius: 1rem;
    border: 1.5px solid #ced4da;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.search-box input:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 8px rgba(13,110,253,0.6);
    outline: none;
}

/* Reservation card */
.container-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 1.5rem;
}

.reservation-card {
    background: #fff;
    border-radius: 1.2rem;
    padding: 2rem;
    box-shadow: 0 12px 25px rgba(0,0,0,0.07);
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform 0.35s ease, box-shadow 0.35s ease;
}

.reservation-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 22px 45px rgba(0,0,0,0.15);
}

.res-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1rem;
    font-weight: 600;
    font-size: 1.2rem;
    color: #2c3e50;
}

.res-info {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.6rem 1.5rem;
    font-size: 0.95rem;
    margin-bottom: 1.5rem;
}

.res-info div {
    display: flex;
    flex-direction: column;
}

.res-info label {
    font-weight: 600;
    font-size: 0.8rem;
    color: #6c7a89;
    margin-bottom: 0.2rem;
}

.res-info span {
    color: #2c3e50;
}

.action-buttons {
    position: absolute;
    bottom: 1.8rem;
    right: 1.8rem;
    display: flex;
    gap: 1.2rem;
}

.action-btn {
    background: none;
    border: none;
    cursor: pointer;
    color: #2c3e50;
    font-size: 1.5rem;
    padding: 0.4rem;
    border-radius: 50%;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.action-btn:hover {
    background-color: #2c3e50;
    color: #fff;
}

.action-btn.delete {
    color: #e74c3c;
}

.action-btn.delete:hover {
    background-color: #c0392b;
    color: #fff;
}

.no-data {
    grid-column: 1/-1;
    text-align: center;
    font-style: italic;
    color: #7f8c8d;
    font-size: 1.2rem;
    padding: 3rem 1rem;
}

/* Responsive */
@media (max-width: 500px) {
    .res-info {
        grid-template-columns: 1fr;
    }
    .action-buttons {
        bottom: 1rem;
        right: 1rem;
        gap: 0.8rem;
    }
    .action-btn {
        font-size: 1.3rem;
        padding: 0.3rem;
    }
}
</style>

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary px-4">
    <a class="navbar-brand" href="#">관리자 대시보드</a>
</nav>

<div class="d-flex">
    <!-- Sidebar -->
    <nav class="sidebar d-flex flex-column p-3">
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item mb-2"><a href="AdminDashboard.jsp" class="nav-link">홈</a></li>
            <li class="nav-item mb-2"><a href="ManageUsersServlet" class="nav-link">회원 관리</a></li>
            <li class="nav-item mb-2"><a href="ManageReservationsServlet" class="nav-link active">예약 관리</a></li>
            <li class="nav-item"><a href="LogoutServlet" class="nav-link text-danger">로그아웃</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="content w-100" role="main" aria-live="polite">
        <h1>예약 관리</h1>

        <!-- 검색창 -->
        <div class="search-box">
            <input
                type="text"
                id="searchInput"
                placeholder="예약번호, 회원 ID, 출발지 등으로 검색..."
                onkeyup="filterReservations()"
                aria-label="예약 검색 입력창"
                autocomplete="off"
            />
        </div>

        <section class="container-cards" id="reservationContainer">
            <%
                if (reservations.isEmpty()) {
            %>
            <div class="no-data">예약 내역이 없습니다.</div>
            <%
                } else {
                    for (Reservation r : reservations) {
            %>
            <article 
                class="reservation-card" 
                aria-label="예약 번호 <%=r.getResId()%> 상세 정보"
                data-resid="<%= r.getResId() %>" 
                data-userid="<%= r.getUserId().toLowerCase() %>" 
                data-origin="<%= r.getOrigin().toLowerCase() %>" 
                data-destination="<%= r.getDestination().toLowerCase() %>"
            >
                <div class="res-header">
                    <span>예약 번호: <strong><%= r.getResId() %></strong></span>
                    <span>회원 ID: <strong><%= r.getUserId() %></strong></span>
                </div>

                <section class="res-info">
                    <div><label>여행 유형</label><span><%= r.getTripType() %></span></div>
                    <div><label>출발지</label><span><%= r.getOrigin() %></span></div>
                    <div><label>도착지</label><span><%= r.getDestination() %></span></div>
                    <div><label>출발일</label><span><%= r.getDepartDate() %></span></div>
                    <div><label>복귀일</label><span><%= r.getReturnDate() %></span></div>
                    <div><label>성인 수</label><span><%= r.getAdultCount() %></span></div>
                    <div><label>어린이 수</label><span><%= r.getChildCount() %></span></div>
                    <div><label>유아 수</label><span><%= r.getInfantCount() %></span></div>
                </section>

                <div class="action-buttons">
                    <button class="action-btn edit" aria-label="예약 번호 <%= r.getResId() %> 수정"
                        onclick="location.href='EditReservationServlet?resId=<%= r.getResId() %>'">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                    <button class="action-btn delete" aria-label="예약 번호 <%= r.getResId() %> 삭제"
                        onclick="confirmDelete(<%= r.getResId() %>)">
                        <i class="bi bi-trash-fill"></i>
                    </button>
                </div>
            </article>
            <%
                    }
                }
            %>
        </section>
    </main>
</div>
<p>예약 ID 테스트: <%= reservations.isEmpty() ? "없음" : reservations.get(0).getResId() %></p>


<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function confirmDelete(resId) {
    console.log("confirmDelete 호출됨, resId:", resId);
    Swal.fire({
        title: '정말 삭제하시겠습니까?',
        text: '예약 번호: ' + resId + ' 을(를) 삭제하면 복구할 수 없습니다.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e74c3c',
        cancelButtonColor: '#7f8c8d',
        confirmButtonText: '삭제',
        cancelButtonText: '취소',
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'DeleteReservationServlet';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'resId';
            input.value = resId;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    });
}






    function filterReservations() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase().trim();
        const container = document.getElementById('reservationContainer');
        const cards = container.getElementsByClassName('reservation-card');

        let visibleCount = 0;

        for (let card of cards) {
            const resid = card.getAttribute('data-resid').toLowerCase();
            const userid = card.getAttribute('data-userid');
            const origin = card.getAttribute('data-origin');
            const destination = card.getAttribute('data-destination');

            if (
                resid.includes(filter) ||
                userid.includes(filter) ||
                origin.includes(filter) ||
                destination.includes(filter)
            ) {
                card.style.display = 'flex';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        }

        let noDataDiv = container.querySelector('.no-data');
        if (!noDataDiv) {
            noDataDiv = document.createElement('div');
            noDataDiv.className = 'no-data';
            noDataDiv.textContent = '검색 결과가 없습니다.';
            container.appendChild(noDataDiv);
        }
        if (visibleCount === 0) {
            noDataDiv.style.display = 'block';
        } else {
            noDataDiv.style.display = 'none';
        }
    }
</script>

</body>
</html>
