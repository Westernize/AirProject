package servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.MemberDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String userid = req.getParameter("userid");
        String pwd    = req.getParameter("pwd");

        MemberDAO dao = new MemberDAO();
        boolean success = dao.login(userid, pwd);

        if(success) {
            String name = dao.getNameByUserId(userid);

            HttpSession session = req.getSession();
            session.setAttribute("userid", userid);
            session.setAttribute("name", name);
            
            if ("admin".equals(userid)) {
                session.setAttribute("isAdmin", true);
            } else {
                session.setAttribute("isAdmin", false);
            }
            
            // 관리자면 관리자 페이지로, 아니면 일반 로그인 성공 페이지로 보내기
            if ("admin".equals(userid)) {
                resp.sendRedirect("AdminDashboard.jsp");
            } else {
                resp.sendRedirect("loginsuccess.jsp");
            }
        } else {
            resp.sendRedirect("fail.jsp");
        }

    }
}
