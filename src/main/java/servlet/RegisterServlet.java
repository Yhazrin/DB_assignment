package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RegisterServlet extends HttpServlet {
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");
        String errorMsg = null;

        // 1. Validate input
        if (username == null || username.isEmpty() ||
                email    == null || email.isEmpty()    ||
                password == null || password.isEmpty() ||
                confirm  == null || confirm.isEmpty()) {
            errorMsg = "Please fill in all fields.";
        } else if (!password.equals(confirm)) {
            errorMsg = "Passwords do not match.";
        }

        if (errorMsg != null) {
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 2. Check existence and insert
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement checkStmt = conn.prepareStatement(
                         "SELECT id FROM users WHERE username = ?");
                 PreparedStatement insertStmt = conn.prepareStatement(
                         "INSERT INTO users (username, email, password) VALUES (?, ?, ?)") ) {

                checkStmt.setString(1, username);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        errorMsg = "Username already exists.";
                        request.setAttribute("errorMessage", errorMsg);
                        request.getRequestDispatcher("/register.jsp").forward(request, response);
                        return;
                    }
                }

                insertStmt.setString(1, username);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password); // consider hashing
                insertStmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Registration failed, please try again later.";
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 3. Redirect to login with flag
        response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
    }
}
