package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        String errorMsg = null;

        // 1. Validate input
        if (username == null || password == null || confirm == null ||
                username.isEmpty() || password.isEmpty() || confirm.isEmpty()) {
            errorMsg = "Please fill in all fields.";
        } else if (!password.equals(confirm)) {
            errorMsg = "Passwords do not match.";
        }

        // If validation failed, forward back to register.jsp with error
        if (errorMsg != null) {
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 2. Check database and insert user
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement checkStmt = conn.prepareStatement(
                         "SELECT id FROM users WHERE username = ?");
                 PreparedStatement insertStmt = conn.prepareStatement(
                         "INSERT INTO users (username, password) VALUES (?, ?)");) {

                // Check if username exists
                checkStmt.setString(1, username);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        errorMsg = "Username already exists.";
                        request.setAttribute("errorMessage", errorMsg);
                        request.getRequestDispatcher("/register.jsp").forward(request, response);
                        return;
                    }
                }

                // Insert new user
                insertStmt.setString(1, username);
                insertStmt.setString(2, password); // Note: consider hashing
                insertStmt.executeUpdate();

            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Registration failed, please try again later.";
            request.setAttribute("errorMessage", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 3. Redirect to login.jsp with success flag (PRG pattern)
        response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
    }
}
