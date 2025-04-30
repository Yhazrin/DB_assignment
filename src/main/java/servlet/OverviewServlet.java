package servlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MobilePhone; // 从model包导入

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.File;


public class OverviewServlet extends HttpServlet {
    private String csvPath;
    // 数据库连接常量
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/yourdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        // 从 init-param 中读取 CSV 路径
        csvPath = config.getInitParameter("csvPath");
        
        log("CSV Path configured as: " + csvPath);
        String webappRoot = getServletContext().getRealPath("/");
        log("Webapp root directory: " + webappRoot);
        
        File assetsDir = new File(getServletContext().getRealPath("/assets"));
        if (assetsDir.exists()) {
            log("Assets directory exists");
            File dataDir = new File(getServletContext().getRealPath("/assets/data"));
            if (dataDir.exists()) {
                log("Data directory exists");
                File csvFile = new File(getServletContext().getRealPath(csvPath));
                log("CSV file exists: " + csvFile.exists());
            } else {
                log("Data directory does not exist");
            }
        } else {
            log("Assets directory does not exist");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<MobilePhone> dataList = new ArrayList<>();

        // 首先尝试从CSV加载数据
        boolean csvLoaded = loadDataFromCsv(dataList);
        
        // 如果CSV加载失败，则尝试从数据库加载
        if (!csvLoaded || dataList.isEmpty()) {
            loadDataFromDatabase(dataList);
        }

        request.setAttribute("dataList", dataList);
        request.getRequestDispatcher("/overview.jsp").forward(request, response);
    }

    private boolean loadDataFromCsv(List<MobilePhone> dataList) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        // 使用从init方法中获取的csvPath变量，而不是重新定义
        String realCsvPath = getServletContext().getRealPath(csvPath);
        
        // 添加调试信息
        log("Attempting to load CSV from: " + realCsvPath);
        
        try (BufferedReader br = new BufferedReader(new FileReader(realCsvPath))) {
            // 其余代码不变
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; }
                String[] v = line.split(",", -1);
                if (v.length < 8) continue;
                MobilePhone p = new MobilePhone();
                p.setName(v[0]);
                p.setBrand(v[1]);
                p.setReleaseDate(sdf.parse(v[2]));
                p.setProcessor(v[3]);
                p.setDisplay(v[4].replace("\"",""));
                p.setCamera(v[5]);
                p.setMaterial(v[6]);
                p.setPrice(new BigDecimal(v[7].replace("$","")));
                dataList.add(p);
            }
            return true;
        } catch (Exception e) {
            log("CSV loading failed: " + e.getMessage(), e);
            e.printStackTrace(); // 打印完整堆栈跟踪
            return false;
        }
    }


    private void loadDataFromDatabase(List<MobilePhone> dataList) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(
                         "SELECT name, brand, releaseDate, processor, display, camera, material, price FROM phones")) {

                while (rs.next()) {
                    try {
                        MobilePhone phone = new MobilePhone();
                        phone.setName(rs.getString("name"));
                        phone.setBrand(rs.getString("brand"));
                        phone.setReleaseDate(rs.getDate("releaseDate"));
                        phone.setProcessor(rs.getString("processor"));
                        phone.setDisplay(rs.getString("display"));
                        phone.setCamera(rs.getString("camera"));
                        phone.setMaterial(rs.getString("material"));
                        phone.setPrice(rs.getBigDecimal("price"));
                        
                        dataList.add(phone);
                    } catch (Exception ex) {
                        log("Error parsing database record", ex);
                    }
                }
            }
        } catch (Exception ex) {
            log("Database query failed: " + ex.getMessage(), ex);
        }
    }
}