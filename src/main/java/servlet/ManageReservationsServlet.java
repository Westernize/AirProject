package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ManageReservationsServlet")
public class ManageReservationsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "scott";
    private static final String DB_PASS = "tiger";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 관리자 여부 세션 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
            response.sendRedirect("main.jsp");
            return;
        }

        List<Reservation> reservations = new ArrayList<>();

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = """
                    SELECT RES_ID, USER_ID, TRIP_TYPE, ORIGIN, DESTINATION,
                           TO_CHAR(DEPART_DATE, 'YYYY-MM-DD') AS DEPART_DATE,
                           TO_CHAR(RETURN_DATE, 'YYYY-MM-DD') AS RETURN_DATE,
                           ADULT_COUNT, CHILD_COUNT, INFANT_COUNT
                    FROM RESERVATION
                    ORDER BY DEPART_DATE DESC
                """;

                try (PreparedStatement pstmt = conn.prepareStatement(sql);
                     ResultSet rs = pstmt.executeQuery()) {
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

            request.setAttribute("reservations", reservations);
            request.getRequestDispatcher("manageReservations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
