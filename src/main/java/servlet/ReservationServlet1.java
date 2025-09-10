package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/ReservationServlet1")
public class ReservationServlet1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    public ReservationServlet1() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userid"); // 로그인한 사용자 ID

        // 로그인하지 않은 경우 경고창 띄우고 로그인 페이지로 이동
        if (userId == null || userId.trim().isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.'); location.href='login.jsp';</script>");
            return;
        }

        String tripType = request.getParameter("trip");
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String departDate = request.getParameter("departDate");
        String returnDate = request.getParameter("returnDate");
        int adult = Integer.parseInt(request.getParameter("adult"));
        int child = Integer.parseInt(request.getParameter("child"));
        int infant = Integer.parseInt(request.getParameter("infant"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "INSERT INTO RESERVATION (RES_ID, USER_ID, TRIP_TYPE, ORIGIN, DESTINATION, DEPART_DATE, RETURN_DATE, ADULT_COUNT, CHILD_COUNT, INFANT_COUNT) "
                       + "VALUES (RESERVATION_SEQ.NEXTVAL, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, tripType);
            pstmt.setString(3, origin);
            pstmt.setString(4, destination);
            pstmt.setString(5, departDate);
            pstmt.setString(6, (returnDate == null || returnDate.isEmpty()) ? null : returnDate);
            pstmt.setInt(7, adult);
            pstmt.setInt(8, child);
            pstmt.setInt(9, infant);

            pstmt.executeUpdate();

            response.sendRedirect("reservation_success.jsp"); // 성공 시 이동

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
