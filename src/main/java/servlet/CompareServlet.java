package servlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MobilePhone;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CompareServlet extends HttpServlet {
    private String csvPath;
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/yourdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";
    private List<MobilePhone> allPhones = new ArrayList<>();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        csvPath = config.getInitParameter("csvPath");
        log("CompareServlet initialized, csvPath=" + csvPath);
        loadAllPhones();
    }

    private void loadAllPhones() {
        allPhones.clear();
        if (!loadFromCsv(allPhones)) {
            loadFromDatabase(allPhones);
        }
        if (allPhones.isEmpty()) {
            addDefaultTestData(allPhones);
        }
        log("loadAllPhones completed, loaded " + allPhones.size() + " records");
    }

    private boolean loadFromCsv(List<MobilePhone> list) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String realPath = getServletContext().getRealPath(csvPath);
        log("Attempting to load from CSV, realPath=" + realPath);
        File csvFile = new File(realPath);
        if (!csvFile.exists()) {
            log("CSV file does not exist: " + realPath);
            return false;
        }
        try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
            String line;
            boolean first = true;
            while ((line = br.readLine()) != null) {
                if (first) { first = false; continue; }
                String[] v = line.split(",", -1);
                if (v.length < 8) continue;
                MobilePhone p = new MobilePhone();
                p.setName(v[0].trim());
                p.setBrand(v[1].trim());
                try {
                    p.setReleaseDate(sdf.parse(v[2].trim()));
                } catch (Exception e) {
                    p.setReleaseDate(new Date());
                }
                p.setProcessor(v[3].trim());
                p.setDisplay(v[4].replace("\"", "").trim());
                p.setCamera(v[5].trim());
                p.setMaterial(v[6].trim());
                try {
                    String price = v[7].replace("$", "").replace(",", "").trim();
                    p.setPrice(new BigDecimal(price));
                } catch (Exception e) {
                    p.setPrice(new BigDecimal("0"));
                }
                list.add(p);
            }
            return !list.isEmpty();
        } catch (IOException e) {
            log("Failed to read CSV: " + e.getMessage(), e);
            return false;
        }
    }

    private void loadFromDatabase(List<MobilePhone> list) {
        log("Attempting to load data from database");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(
                         "SELECT name, brand, releaseDate, processor, display, camera, material, price FROM phones")) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                    MobilePhone p = new MobilePhone();
                    p.setName(rs.getString("name"));
                    p.setBrand(rs.getString("brand"));
                    Date rd = rs.getDate("releaseDate");
                    p.setReleaseDate(rd != null ? rd : new Date());
                    p.setProcessor(rs.getString("processor"));
                    p.setDisplay(rs.getString("display"));
                    p.setCamera(rs.getString("camera"));
                    p.setMaterial(rs.getString("material"));
                    p.setPrice(rs.getBigDecimal("price"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            log("Database loading exception: " + e.getMessage(), e);
        }
    }

    private void addDefaultTestData(List<MobilePhone> list) {
        log("Using default test data");
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            list.add(new MobilePhone("iPhone 13", "Apple", sdf.parse("2021-09-24"),
                    "A15 Bionic", "6.1\" OLED", "12MP dual camera", "Glass + Aluminum", new BigDecimal("799")));
            list.add(new MobilePhone("Galaxy S21", "Samsung", sdf.parse("2021-01-29"),
                    "Exynos 2100", "6.2\" AMOLED", "64MP triple camera", "Plastic", new BigDecimal("699")));
            list.add(new MobilePhone("Pixel 6", "Google", sdf.parse("2021-10-28"),
                    "Tensor G1", "6.4\" AMOLED", "50MP dual camera", "Glass", new BigDecimal("599")));
        } catch (Exception e) {
            log("Default data generation failed: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (allPhones.isEmpty()) loadAllPhones();

        // JSON 接口支持
        if ("true".equals(req.getParameter("json"))) {
            resp.setContentType("application/json; charset=UTF-8");
            // 手动构建 JSON
            PrintWriter out = resp.getWriter();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (int i = 0; i < allPhones.size(); i++) {
                MobilePhone p = allPhones.get(i);
                sb.append("{");
                sb.append("\"name\":\"").append(escapeJson(p.getName())).append("\",");
                sb.append("\"brand\":\"").append(escapeJson(p.getBrand())).append("\",");
                sb.append("\"releaseDate\":\"").append(sdf.format(p.getReleaseDate())).append("\",");
                sb.append("\"processor\":\"").append(escapeJson(p.getProcessor())).append("\",");
                sb.append("\"display\":\"").append(escapeJson(p.getDisplay())).append("\",");
                sb.append("\"camera\":\"").append(escapeJson(p.getCamera())).append("\",");
                sb.append("\"material\":\"").append(escapeJson(p.getMaterial())).append("\",");
                sb.append("\"price\":").append(p.getPrice());
                sb.append("}");
                if (i < allPhones.size() - 1) sb.append(",");
            }
            sb.append("]");
            out.write(sb.toString());
            return;
        }

        // 原有 JSP 渲染逻辑
        req.setAttribute("allPhones", allPhones);
        String[] ids = req.getParameterValues("id");
        List<MobilePhone> selectedPhones = new ArrayList<>();
        if (ids != null) {
            for (String s : ids) {
                try {
                    int idx = Integer.parseInt(s);
                    if (idx >= 0 && idx < allPhones.size()) {
                        selectedPhones.add(allPhones.get(idx));
                    }
                } catch (NumberFormatException ignored) {}
            }
            req.setAttribute("selectedPhones", selectedPhones);
        }

        Map<String, Map<String, Object>> specs = new LinkedHashMap<>();
        specs.put("brand", spec("brand", false, null));
        specs.put("releaseDate", spec("release date", true, "newer"));
        specs.put("processor", spec("processor", false, null));
        specs.put("display", spec("display", true, "larger"));
        specs.put("camera", spec("camera", true, "higher"));
        specs.put("material", spec("material", false, null));
        specs.put("price", spec("price", true, "lower"));
        req.setAttribute("specs", specs);

        req.getRequestDispatcher("/compare.jsp").forward(req, resp);
    }

    private Map<String, Object> spec(String name, boolean comparable, String better) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("name", name);
        m.put("comparable", comparable);
        m.put("betterValue", better);
        return m;
    }

    /**
     * 简单的 JSON 字符串转义
     */
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }
}
