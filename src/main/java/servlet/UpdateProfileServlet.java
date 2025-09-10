package servlet;

import dao.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String userid = request.getParameter("userid");
        String pwd = request.getParameter("pwd"); // 비워둘 수도 있음
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // 필수 값 체크 (예: 이름과 이메일은 반드시 입력)
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            // 에러 메시지 세팅
            request.setAttribute("errorMessage", "필수 입력값입니다.");
            // 폼 페이지로 포워딩 (redirect 대신)
            RequestDispatcher dispatcher = request.getRequestDispatcher("EditProfile.jsp");
            dispatcher.forward(request, response);
            return;
        }

        MemberDAO dao = new MemberDAO();
        boolean result = dao.updateMember(userid, pwd, name, phone, email);

        if (result) {
            response.sendRedirect("Mypage.jsp"); // 성공 시 마이페이지로
        } else {
            request.setAttribute("errorMessage", "정보 수정에 실패했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("EditProfile.jsp");
            dispatcher.forward(request, response);
        }
    }
}
