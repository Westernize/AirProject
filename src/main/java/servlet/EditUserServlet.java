package servlet;

import dao.MemberDAO;
import servlet.Member;  // 회원 DTO (필요에 따라 경로 수정)
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditUserServlet() {
        super();
    }

    // GET: 수정 폼 보여주기
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 관리자 권한 체크 (필요 시 세션이나 로그인 확인 로직 추가)
        Boolean isAdmin = (Boolean)(request.getSession(false) != null ? request.getSession(false).getAttribute("isAdmin") : null);
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("adminPage.jsp");  // 권한 없으면 관리자 페이지로 이동
            return;
        }

        String userid = request.getParameter("userid");
        if (userid == null || userid.trim().isEmpty()) {
            response.sendRedirect("ManageUsersServlet");  // userid 없으면 리스트 페이지로 이동
            return;
        }

        MemberDAO dao = new MemberDAO();
        Member member = dao.getMember(userid);

        if (member == null) {
            response.sendRedirect("ManageUsersServlet");  // 해당 회원 없으면 리스트로
            return;
        }

        request.setAttribute("member", member);  // 회원정보 request에 담아 JSP로 전달
        RequestDispatcher dispatcher = request.getRequestDispatcher("editUser.jsp");
        dispatcher.forward(request, response);
    }

    // POST: 수정 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 관리자 권한 체크
        Boolean isAdmin = (Boolean)(request.getSession(false) != null ? request.getSession(false).getAttribute("isAdmin") : null);
        if (isAdmin == null || !isAdmin) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('관리자만 수정할 수 있습니다.'); location.href='adminPage.jsp';</script>");
            return;
        }

        String userid = request.getParameter("userid");
        String pwd = request.getParameter("pwd");  // 빈 값일 수도 있음
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // 필수값 체크 (예: 이름, 이메일)
        if (userid == null || userid.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "필수 입력값이 누락되었습니다.");
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
            return;
        }

        MemberDAO dao = new MemberDAO();

        Member member = new Member();
        member.setUserid(userid);
        member.setName(name);
        member.setPhone(phone);
        member.setEmail(email);
        // 비밀번호는 선택적 수정
        if (pwd != null && !pwd.trim().isEmpty()) {
            member.setPwd(pwd);
        }

        boolean result = dao.updateMember(member);  // Member 객체로 수정하는 DAO 메서드 필요

        response.setContentType("text/html;charset=UTF-8");
        if (result) {
            response.getWriter().println("<script>alert('회원 정보가 성공적으로 수정되었습니다.'); location.href='ManageUsersServlet';</script>");
        } else {
            request.setAttribute("errorMessage", "회원 정보 수정에 실패했습니다.");
            request.setAttribute("member", member);  // 다시 폼에 값 유지
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        }
    }
}
