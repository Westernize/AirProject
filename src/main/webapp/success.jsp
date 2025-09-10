<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입 완료</title>
<style>
    /* 전체 body 스타일 */
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        height: 100vh;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
        margin: 0;
    }

    /* 성공 메시지 스타일 */
    h2 {
        font-size: 34px;
        color: #FF6347; /* 오렌지 색으로 강조 */
        text-align: center;
        text-shadow: 2px 2px 6px #aaa;
        margin-bottom: 50px;
        animation: fadeIn 1s ease-in-out;
    }

    /* 버튼 스타일 */
    form input[type="submit"] {
        width: 250px;
        padding: 12px;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        background-color: #FF6347;
        color: white;
        transition: background-color 0.3s, transform 0.2s;
    }

    form input[type="submit"]:hover {
        background-color: #e5533d;
        transform: scale(1.05);
    }

    /* 애니메이션 */
    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(-20px);}
        100% { opacity: 1; transform: translateY(0);}
    }

</style>
</head>
<body>
    <h2>🎉 회원가입이 성공적으로 완료되었습니다! 🎉</h2>

    <!-- 메인 화면으로 되돌아가기 버튼 -->
    <form action="/AirProject/loginsuccess.jsp" method="post">
        <input type="submit" value="메인 화면으로 돌아가기">
    </form>
</body>
</html>
