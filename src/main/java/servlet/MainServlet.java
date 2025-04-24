package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/main")
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        // 获得已有 session，不要新建
        HttpSession session = request.getSession(false);
        // 未登录则重定向回登录页
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // 已登录则转发到 main.jsp
        request.getRequestDispatcher("/main.jsp")
                .forward(request, response);
    }
}
