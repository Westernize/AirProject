package servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.MemberDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String userid = req.getParameter("userid");
        String pwd    = req.getParameter("pwd");
        String name   = req.getParameter("name");
        String phone  = req.getParameter("phone");
        String email  = req.getParameter("email");
        
        MemberDAO dao = new MemberDAO();
        dao.insertMember(userid, pwd, name, phone, email);

        resp.sendRedirect("success.jsp"); // 가입 완료 후 이동할 페이지
    }
}
