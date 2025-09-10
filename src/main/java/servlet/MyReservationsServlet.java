package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/MyReservationsServlet")
public class MyReservationsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 새 세션을 생성하지 않고 기존 세션만 가져오기
        HttpSession session = request.getSession(false);

        if (session == null) {
            redirectToLogin(response);
            return;
        }

        String userId = (String) session.getAttribute("userid");

        if (userId == null || userId.trim().isEmpty()) {
            redirectToLogin(response);
            return;
        }

        List<Reservation> reservations = new ArrayList<>();

        try {
            // 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // DB 커넥션 얻기
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = """
                    SELECT RES_ID, USER_ID, TRIP_TYPE, ORIGIN, DESTINATION,
                           TO_CHAR(DEPART_DATE, 'YYYY-MM-DD') AS DEPART_DATE,
                           TO_CHAR(RETURN_DATE, 'YYYY-MM-DD') AS RETURN_DATE,
                           ADULT_COUNT, CHILD_COUNT, INFANT_COUNT
                    FROM RESERVATION
                    WHERE USER_ID = ?
                    ORDER BY DEPART_DATE DESC
                """;

                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, userId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            Reservation r = new Reservation();
                            r.setResId(rs.getInt("RES_ID"));
                            r.setUserId(rs.getString("USER_ID"));
                            r.setTripType(rs.getString("TRIP_TYPE"));
                            r.setOrigin(rs.getString("ORIGIN"));
                            r.setDestination(rs.getString("DESTINATION"));
                            r.setDepartDate(rs.getString("DEPART_DATE"));
                            r.setReturnDate(rs.getString("RETURN_DATE"));
                            r.setAdultCount(rs.getInt("ADULT_COUNT"));
                            r.setChildCount(rs.getInt("CHILD_COUNT"));
                            r.setInfantCount(rs.getInt("INFANT_COUNT"));
                            reservations.add(r);
                        }
                    }
                }
            }

            request.setAttribute("reservations", reservations);
            request.getRequestDispatcher("my_reservations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void redirectToLogin(HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<script>alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.'); location.href='login.jsp';</script>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
