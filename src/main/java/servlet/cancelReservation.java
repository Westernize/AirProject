package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/cancelReservation")
public class cancelReservation extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

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

        String resIdStr = request.getParameter("resId");
        if (resIdStr == null || resIdStr.trim().isEmpty()) {
            response.sendRedirect("MyReservationsServlet");
            return;
        }

        int resId;
        try {
            resId = Integer.parseInt(resIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("MyReservationsServlet");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                // 1) 본인 예약인지 확인
                String checkSql = "SELECT USER_ID FROM RESERVATION WHERE RES_ID = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, resId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (!rs.next() || !userId.equals(rs.getString("USER_ID"))) {
                            // 본인 예약이 아니거나 예약 없음
                            response.setContentType("text/html; charset=UTF-8");
                            response.getWriter().println("<script>alert('잘못된 접근입니다.'); location.href='MyReservationsServlet';</script>");
                            return;
                        }
                    }
                }

                // 2) 삭제 (예약 취소)
                String deleteSql = "DELETE FROM RESERVATION WHERE RES_ID = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                    deleteStmt.setInt(1, resId);
                    int affected = deleteStmt.executeUpdate();

                    if (affected > 0) {
                        response.setContentType("text/html; charset=UTF-8");
                        response.getWriter().println("<script>alert('예약이 취소되었습니다.'); location.href='MyReservationsServlet';</script>");
                    } else {
                        response.setContentType("text/html; charset=UTF-8");
                        response.getWriter().println("<script>alert('예약 취소에 실패했습니다.'); location.href='MyReservationsServlet';</script>");
                    }
                }
            }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET 요청은 취소 처리 하지 않고 마이예약 페이지로 리다이렉트
        response.sendRedirect("MyReservationsServlet");
    }
}
