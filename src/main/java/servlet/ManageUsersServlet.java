package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ManageUsersServlet")
public class ManageUsersServlet extends HttpServlet {
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

        List<Member> members = new ArrayList<>();

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = """
                    SELECT USERID, PWD, NAME, PHONE, EMAIL
                    FROM MEMBER
                    ORDER BY USERID
                """;

                try (PreparedStatement pstmt = conn.prepareStatement(sql);
                     ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Member m = new Member();
                        m.setUserid(rs.getString("USERID"));
                        m.setPwd(rs.getString("PWD"));
                        m.setName(rs.getString("NAME"));
                        m.setPhone(rs.getString("PHONE"));
                        m.setEmail(rs.getString("EMAIL"));
                        members.add(m);
                    }
                }
            }

            request.setAttribute("members", members);
            request.getRequestDispatcher("manageUsers.jsp").forward(request, response);

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
