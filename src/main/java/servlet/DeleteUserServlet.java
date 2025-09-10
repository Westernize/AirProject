package servlet;

import dao.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteUserServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET 요청은 허용하지 않고 405 에러 반환
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported. Please use POST.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 로그인 또는 관리자 확인 세션 체크 (필요하면 추가)
        Boolean isAdmin = (Boolean) (request.getSession(false) != null ? request.getSession(false).getAttribute("isAdmin") : null);
        if (isAdmin == null || !isAdmin) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('관리자만 삭제할 수 있습니다.'); location.href='adminPage.jsp';</script>");
            return;
        }

        String userid = request.getParameter("userid");
        if (userid == null || userid.trim().isEmpty()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('사용자 아이디가 없습니다.'); location.href='adminPage.jsp';</script>");
            return;
        }

        // 관리자 계정은 삭제 불가 처리 (예: admin 계정)
        if ("admin".equalsIgnoreCase(userid)) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('관리자 계정은 삭제할 수 없습니다.'); location.href='ManageUsersServlet';</script>");
            return;
        }

        MemberDAO dao = new MemberDAO();
        boolean result = dao.deleteMember(userid);

        if (result) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('사용자 삭제가 완료되었습니다.'); location.href='ManageUsersServlet';</script>");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('사용자 삭제에 실패했습니다.'); location.href='ManageUsersServlet';</script>");
        }
    }
}
