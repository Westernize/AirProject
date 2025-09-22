# ✈️ 항공권 예약 시스템 (Airline Ticket Reservation System)

## 📌 프로젝트 소개
이 프로젝트는 **Java Servlet & JSP + Oracle Database** 기반으로 구현된 항공권 예약 시스템입니다.  
사용자는 회원가입 및 로그인 후 항공편을 조회하고 예약/취소할 수 있으며, 관리자는 회원과 예약 관리 기능을 수행할 수 있습니다.  

---

## 👨‍👩‍👦 팀 소개
- **팀명**: 5조
- **팀원 및 역할**
  - 🛠️ **이건해**: JSP 페이지 구성, UI 설계  
  - 🗄️ **김찬형**: Oracle DB 설계 및 메인 페이지 구현  
  - 💻 **이희찬**: 예약/회원 관리, 관리자(Admin) 기능 구현  

---

## ⚙️ 개발 환경
- **언어**: Java (JDK 17 기준)  
- **DBMS**: Oracle Database 11g / 19c  
- **IDE**: Eclipse (Dynamic Web Project)  
- **WAS**: Apache Tomcat 9.0  
- **라이브러리**: JDBC (ojdbc8.jar), JSP, Servlet  
- **Front-end**: JSP, CSS  
- **형상 관리**: GitHub  

---

## 📂 프로젝트 구조
```plaintext
📦 airline-reservation-system
 ┣ 📂 src/main/java
 ┃ ┣ 📂 dao
 ┃ ┃ ┗ MemberDAO.java
 ┃ ┣ 📂 servlet
 ┃ ┃ ┣ cancelReservation.java
 ┃ ┃ ┣ DeleteAccountServlet.java
 ┃ ┃ ┣ DeleteReservationServlet.java
 ┃ ┃ ┣ DeleteUserServlet.java
 ┃ ┃ ┣ EditUserServlet.java
 ┃ ┃ ┣ InquiryServlet.java
 ┃ ┃ ┣ LoginServlet.java
 ┃ ┃ ┣ LogoutServlet.java
 ┃ ┃ ┣ ManageReservationsServlet.java
 ┃ ┃ ┣ ManageUsersServlet.java
 ┃ ┃ ┣ Member.java
 ┃ ┃ ┣ MyReservationsServlet.java
 ┃ ┃ ┣ RegisterServlet.java
 ┃ ┃ ┣ ReservationServlet.java
 ┃ ┃ ┣ ReservationServlet1.java
 ┃ ┃ ┗ UpdateProfileServlet.java
 ┃ ┣ 📂 util
 ┃ ┃ ┗ DBUtil.java
 ┣ 📂 webapp
 ┃ ┣ 📂 META-INF
 ┃ ┣ 📂 WEB-INF
 ┃ ┃ ┣ AdminDashboard.jsp
 ┃ ┃ ┣ EditProfile.jsp
 ┃ ┃ ┣ EditUser.jsp
 ┃ ┃ ┣ error.html
 ┃ ┃ ┣ fail.jsp
 ┃ ┃ ┣ flight.jsp / flight_1.css
 ┃ ┃ ┣ inquiryForm.jsp
 ┃ ┃ ┣ login.jsp / loginsuccess.jsp
 ┃ ┃ ┣ main.jsp / main.css
 ┃ ┃ ┣ manageReservations.jsp
 ┃ ┃ ┣ manageUsers.jsp
 ┃ ┃ ┣ my_reservations.jsp
 ┃ ┃ ┣ Mypage.jsp
 ┃ ┃ ┣ reservation_success.jsp
 ┃ ┃ ┣ signup.jsp
 ┃ ┃ ┣ style.css
 ┃ ┃ ┗ success.jsp / test.css
 ┣ 📂 sql
 ┃ ┗ schema.sql
 ┣ 📂 docs
 ┃ ┣ erd.png
 ┃ ┣ schedule.png
 ┃ ┗ screenshots/
 ┣ README.md
 ┗ LICENSE
