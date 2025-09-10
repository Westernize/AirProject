<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, servlet.Member" %>

<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("main.jsp");
        return;
    }

    List<Member> members = (List<Member>) request.getAttribute("members");
    if (members == null) {
        members = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>회원 관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Fonts & Styles -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
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
        }
        .nav-link.active,
        .nav-link:hover {
            background-color: #0d6efd;
            color: #fff !important;
            border-radius: 8px;
        }
        .content {
            flex-grow: 1;
            padding: 2rem 3rem;
            min-height: 100vh;
            background: #fff;
        }
        h1 {
            font-size: 2.4rem;
            font-weight: 600;
            margin-bottom: 2.5rem;
            color: #2c3e50;
            text-align: center;
        }
        .search-box {
            max-width: 500px;
            margin: 0 auto 2.5rem auto;
        }
        .search-box input {
            width: 100%;
            padding: 0.6rem 1rem;
            font-size: 1.1rem;
            border-radius: 50px;
            border: 1.5px solid #ced4da;
            transition: border-color 0.3s;
        }
        .search-box input:focus {
            border-color: #0d6efd;
            outline: none;
            box-shadow: 0 0 8px rgba(13, 110, 253, 0.3);
        }
        .container-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem 2.5rem;
        }
        .member-card {
            background: #fefefe;
            border-radius: 16px;
            padding: 1.6rem 1.8rem;
            box-shadow: 0 6px 16px rgba(0,0,0,0.07);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .member-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 14px 32px rgba(0,0,0,0.12);
        }
        .member-header {
            font-weight: 700;
            font-size: 1.2rem;
            color: #1c2733;
            margin-bottom: 0.6rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            word-break: break-word;
        }
        .member-header span:first-child {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #0d6efd;
        }
        .member-info {
            font-size: 0.95rem;
            color: #4a4a4a;
            margin-bottom: 1.2rem;
            line-height: 1.35;
            min-height: 58px;
        }
        .member-info div {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 0.4rem;
            color: #555;
        }
        .member-info i {
            color: #0d6efd;
            font-size: 1.15rem;
        }
        .action-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
        .action-btn {
            background-color: transparent;
            border: none;
            cursor: pointer;
            font-size: 1.3rem;
            color: #495057;
            padding: 6px;
            border-radius: 50%;
            transition: background-color 0.25s ease, color 0.25s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .action-btn:hover {
            background-color: #0d6efd;
            color: white;
        }
        .action-btn.delete:hover {
            background-color: #dc3545;
        }
        .no-data {
            grid-column: 1 / -1;
            text-align: center;
            font-style: italic;
            color: #7f8c8d;
            font-size: 1.3rem;
            margin-top: 3rem;
        }
        @media (max-width: 480px) {
            .content {
                padding: 1.5rem 1.2rem;
            }
            .search-box {
                max-width: 100%;
            }
            .member-card {
                padding: 1.2rem 1.4rem;
            }
            .member-header {
                font-size: 1.1rem;
            }
            .action-btn {
                font-size: 1.1rem;
                padding: 4px;
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
                <li class="nav-item mb-2"><a href="ManageUsersServlet" class="nav-link active">회원 관리</a></li>
                <li class="nav-item mb-2"><a href="ManageReservationsServlet" class="nav-link">예약 관리</a></li>
                <li class="nav-item"><a href="LogoutServlet" class="nav-link text-danger">로그아웃</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="content w-100" role="main" aria-live="polite">
            <h1>회원 관리</h1>

            <!-- 검색창 -->
            <div class="search-box">
                <input type="search" class="form-control" id="searchInput" placeholder="이름으로 검색..." onkeyup="filterMembers()" aria-label="회원 이름 검색" />
            </div>

            <!-- 회원 카드 목록 -->
            <div class="container-cards" id="memberContainer" role="list">
                <%
                    if (members.isEmpty()) {
                %>
                    <div class="no-data" role="alert">회원 정보가 없습니다.</div>
                <%
                    } else {
                        for (Member m : members) {
                %>
                <article class="member-card" role="listitem" tabindex="0" data-name="<%= m.getName().toLowerCase() %>">
                    <div class="member-header">
                        <span><i class="bi bi-person-circle"></i> <%= m.getName() %></span>
                        <span>ID: <%= m.getUserid() %></span>
                    </div>
                    <div class="member-info">
                        <div><i class="bi bi-envelope-fill"></i> <%= m.getEmail() %></div>
                        <div><i class="bi bi-telephone-fill"></i> <%= m.getPhone() %></div>
                    </div>
                    <div class="action-buttons" aria-label="회원 <%= m.getName() %> 액션 버튼">
                        <button class="action-btn edit" title="수정" aria-label="회원 <%= m.getName() %> 수정"
                            onclick="location.href='EditUserServlet?userid=<%= m.getUserid() %>'">
                            <i class="bi bi-pencil-square"></i>
                        </button>
				<button class="action-btn delete"
        data-userid="<%= m.getUserid() %>"
        data-username="<%= m.getName() %>"
        onclick="confirmDelete(this.dataset.userid, this.dataset.username)">
    <i class="bi bi-trash-fill"></i>
</button>
                    </div>
                </article>
                <%
                        }
                    }
                %>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
    function confirmDelete(userid, username) {
        console.log("confirmDelete 호출됨, userid:", userid, ", username:", username);

        Swal.fire({
            title: '정말 삭제하시겠습니까?',
            text: '회원: ' + username + ' (ID: ' + userid + ') 를 삭제하면 복구할 수 없습니다.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#e74c3c',
            cancelButtonColor: '#7f8c8d',
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // 동적 폼 생성해서 POST 요청 보내기
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'DeleteUserServlet'; // DeleteUserServlet 경로로 변경

                const inputUserId = document.createElement('input');
                inputUserId.type = 'hidden';
                inputUserId.name = 'userid';
                inputUserId.value = userid;
                form.appendChild(inputUserId);

                document.body.appendChild(form);
                form.submit();
            }
        });
    }

        function filterMembers() {
            const input = document.getElementById('searchInput').value.toLowerCase().trim();
            const cards = document.querySelectorAll('.member-card');
            let hasVisible = false;

            cards.forEach(card => {
                const name = card.getAttribute('data-name');
                if (name.includes(input)) {
                    card.style.display = 'flex';
                    hasVisible = true;
                } else {
                    card.style.display = 'none';
                }
            });

            // no-data 메시지 관리
            let noDataEl = document.querySelector('.no-data');
            if (noDataEl) noDataEl.remove();

            if (!hasVisible) {
                const container = document.getElementById('memberContainer');
                const noData = document.createElement('div');
                noData.className = 'no-data';
                noData.setAttribute('role', 'alert');
                noData.innerText = '검색 결과가 없습니다.';
                container.appendChild(noData);
            }
        }
    </script>
</body>
</html>
