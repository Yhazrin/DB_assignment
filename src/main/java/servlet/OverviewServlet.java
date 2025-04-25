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
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OverviewServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/infosys";
    private static final String DB_USER = "1";
    private static final String DB_PASS = "1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String[]> records = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {
                while (rs.next()) {
                    records.add(new String[]{rs.getString("id"), rs.getString("username")});
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("records", records);
        request.getRequestDispatcher("overview.jsp").forward(request, response);
    }
}
