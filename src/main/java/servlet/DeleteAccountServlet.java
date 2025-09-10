package servlet;

import dao.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public DeleteAccountServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 회원 탈퇴 요청은 POST로 받음
        request.setCharacterEncoding("UTF-8");
        
        String userid = request.getParameter("userid");
        MemberDAO dao = new MemberDAO();
        
        boolean result = dao.deleteMember(userid);
        
        if (result) {
            // 탈퇴 성공 시 세션 무효화(로그아웃 처리) 후 알림창 띄우고 메인 페이지 또는 로그인 페이지로 이동
            request.getSession().invalidate();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('회원 탈퇴가 완료되었습니다.'); location.href='main.jsp';</script>");
        } else {
            // 실패 시 알림 후 마이페이지로 다시 이동
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('회원 탈퇴에 실패했습니다.'); location.href='Mypage.jsp';</script>");
        }
    }
}
