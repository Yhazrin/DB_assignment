package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ForumServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "1";
    private static final String DB_PASS = "1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<String[]> posts = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(
                         "SELECT username, content, created_at FROM posts ORDER BY created_at DESC")) {
                while (rs.next()) {
                    posts.add(new String[]{
                            rs.getString("username"),
                            rs.getString("content"),
                            rs.getString("created_at")
                    });
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error retrieving forum posts", e);
        }

        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/forum.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String username = (String) session.getAttribute("username");
        String content = request.getParameter("content");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement ps = conn.prepareStatement(
                         "INSERT INTO posts (username, content) VALUES (?, ?)");) {
                ps.setString(1, username);
                ps.setString(2, content);
                ps.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error posting content", e);
        }

        response.sendRedirect(request.getContextPath() + "/forum");
    }
}
