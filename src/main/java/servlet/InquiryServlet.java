package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/InquiryServlet")
public class InquiryServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("이 페이지는 POST 요청을 통해서만 접근 가능합니다.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String reservationNumber = request.getParameter("reservationNumber");
        String userId = request.getParameter("userId");
        String departureDateStr = request.getParameter("departureDate");

        // 필수 입력값 체크
        if (reservationNumber == null || userId == null || departureDateStr == null ||
            reservationNumber.trim().isEmpty() || userId.trim().isEmpty() || departureDateStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "필수 입력값이 누락되었습니다.");
            request.getRequestDispatcher("inquiryForm.jsp").forward(request, response);
            return;
        }

        int resId;
        try {
            resId = Integer.parseInt(reservationNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "예약 번호는 숫자여야 합니다.");
            request.getRequestDispatcher("inquiryForm.jsp").forward(request, response);
            return;
        }

        java.sql.Date departureDate;
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(departureDateStr);
            departureDate = new java.sql.Date(utilDate.getTime());
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "출발일 형식이 올바르지 않습니다. (yyyy-MM-dd 형식이어야 합니다.)");
            request.getRequestDispatcher("inquiryForm.jsp").forward(request, response);
            return;
        }

        String sql = """
            SELECT RES_ID, USER_ID, TRIP_TYPE, ORIGIN, DESTINATION,
                   TO_CHAR(DEPART_DATE, 'YYYY-MM-DD') AS DEPART_DATE,
                   TO_CHAR(RETURN_DATE, 'YYYY-MM-DD') AS RETURN_DATE,
                   ADULT_COUNT, CHILD_COUNT, INFANT_COUNT
            FROM RESERVATION
            WHERE RES_ID = ? AND USER_ID = ? AND DEPART_DATE = ?
        """;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            request.setAttribute("errorMessage", "JDBC 드라이버를 찾을 수 없습니다.");
            request.getRequestDispatcher("inquiryForm.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, resId);
            pstmt.setString(2, userId);
            pstmt.setDate(3, departureDate);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 조회 성공 시 예약정보를 request에 담기
                    request.setAttribute("reservationNumber", rs.getInt("RES_ID"));
                    request.setAttribute("userId", rs.getString("USER_ID"));
                    request.setAttribute("tripType", rs.getString("TRIP_TYPE"));
                    request.setAttribute("origin", rs.getString("ORIGIN"));
                    request.setAttribute("destination", rs.getString("DESTINATION"));
                    request.setAttribute("departDate", rs.getString("DEPART_DATE"));
                    request.setAttribute("returnDate", rs.getString("RETURN_DATE"));
                    request.setAttribute("adultCount", rs.getInt("ADULT_COUNT"));
                    request.setAttribute("childCount", rs.getInt("CHILD_COUNT"));
                    request.setAttribute("infantCount", rs.getInt("INFANT_COUNT"));
                } else {
                    request.setAttribute("errorMessage", "해당 예약정보를 찾을 수 없습니다.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "데이터베이스 오류가 발생했습니다: " + e.getMessage());
        }

        // 결과를 inquiryForm.jsp로 포워딩
        request.getRequestDispatcher("inquiryForm.jsp").forward(request, response);
    }
}
