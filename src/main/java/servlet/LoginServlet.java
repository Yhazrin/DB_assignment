// src/main/java/servlet/LoginServlet.java
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
public class LoginServlet extends HttpServlet {
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "1";
    private static final String DB_PASS = "1";

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errorMsg = null;

        if (username == null || username.isEmpty()
                || password == null || password.isEmpty()) {
            errorMsg = "Username and password cannot be empty";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                     PreparedStatement ps = conn.prepareStatement(
                             "SELECT password FROM users WHERE username = ?")) {
                    ps.setString(1, username);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            String dbPass = rs.getString("password");
                            if (password.equals(dbPass)) {
                                HttpSession session = request.getSession();
                                session.setAttribute("username", username);
                                response.sendRedirect(request.getContextPath() + "/home.jsp");
                                return;
                            } else {
                                errorMsg = "Invalid username or password";
                            }
                        } else {
                            errorMsg = "User does not exist";
                        }
                    }
                }
            } catch (Exception e) {
                errorMsg = "Login failed, please try again later";
                e.printStackTrace();
            }
        }

        request.setAttribute("errorMessage", errorMsg);
        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }
}
