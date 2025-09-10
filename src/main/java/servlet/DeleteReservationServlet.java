package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteReservationServlet")
public class DeleteReservationServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Object isAdminObj = (session != null) ? session.getAttribute("isAdmin") : null;

        boolean isAdmin = false;
        if (isAdminObj != null) {
            if (isAdminObj instanceof Boolean) {
                isAdmin = (Boolean) isAdminObj;
            } else if (isAdminObj instanceof String) {
                isAdmin = Boolean.parseBoolean((String) isAdminObj);
            }
        }

        if (!isAdmin) {
            redirectToMainWithAlert(response, "관리자만 접근 가능합니다.");
            return;
        }

        String resIdStr = request.getParameter("resId");
        if (resIdStr == null || resIdStr.trim().isEmpty()) {
            redirectToManageReservations(response, "잘못된 요청입니다.");
            return;
        }

        int reservationId;
        try {
            reservationId = Integer.parseInt(resIdStr);
        } catch (NumberFormatException e) {
            redirectToManageReservations(response, "예약 ID가 올바르지 않습니다.");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String deleteSql = "DELETE FROM RESERVATION WHERE RES_ID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
                    stmt.setInt(1, reservationId);
                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        redirectToManageReservations(response, "예약이 삭제되었습니다.");
                    } else {
                        redirectToManageReservations(response, "예약을 찾을 수 없습니다.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void redirectToManageReservations(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<script>alert('" + message + "'); location.href='ManageReservationsServlet';</script>");
    }

    private void redirectToMainWithAlert(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<script>alert('" + message + "'); location.href='main.jsp';</script>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
