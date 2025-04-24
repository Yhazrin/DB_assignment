package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errorMsg = null;

        if (username == null || password == null) {
            errorMsg = "Username and password cannot be empty";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                     PreparedStatement ps = conn.prepareStatement("SELECT password FROM users WHERE username = ?")) {
                    ps.setString(1, username);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String dbPass = rs.getString("password");
                        if (password.equals(dbPass)) {
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);
                            response.sendRedirect("main.jsp");
                            return;
                        } else {
                            errorMsg = "Invalid username or password";
                        }
                    } else {
                        errorMsg = "User does not exist";
                    }
                }
            } catch (Exception e) {
                errorMsg = "Login failed, please try again later";
                e.printStackTrace();
            }
        }
        request.setAttribute("errorMessage", errorMsg);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
