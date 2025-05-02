package servlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MobilePhone;

import java.io.BufferedReader;
import java.io.File;
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
        log("CompareServlet 初始化, csvPath=" + csvPath);
        loadAllPhones();
    }

    private void loadAllPhones() {
        allPhones.clear();
        // 先尝试从CSV加载
        if (!loadFromCsv(allPhones)) {
            // 再尝试从数据库加载
            loadFromDatabase(allPhones);
        }
        // 最后fallback到默认测试数据
        if (allPhones.isEmpty()) {
            addDefaultTestData(allPhones);
        }
        log("loadAllPhones 完成, 共加载 " + allPhones.size() + " 条数据");
    }

    /**
     * 从 webapp assets/data 目录加载 CSV
     */
    private boolean loadFromCsv(List<MobilePhone> list) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String realPath = getServletContext().getRealPath(csvPath);
        log("尝试从CSV加载, realPath=" + realPath);
        File csvFile = new File(realPath);
        if (!csvFile.exists()) {
            log("CSV文件不存在: " + realPath);
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
            log("读取CSV失败: " + e.getMessage(), e);
            return false;
        }
    }

    /**
     * 从数据库加载
     */
    private void loadFromDatabase(List<MobilePhone> list) {
        log("尝试从数据库加载数据");
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
            log("数据库加载异常: " + e.getMessage(), e);
        }
    }

    /**
     * 添加默认测试数据
     */
    private void addDefaultTestData(List<MobilePhone> list) {
        log("使用默认测试数据");
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            list.add(new MobilePhone("iPhone 13", "Apple", sdf.parse("2021-09-24"), "A15 Bionic", "6.1寸 OLED", "12MP双摄", "玻璃+铝合金", new BigDecimal("799")));
            list.add(new MobilePhone("Galaxy S21", "Samsung", sdf.parse("2021-01-29"), "Exynos 2100", "6.2寸 AMOLED", "64MP三摄", "塑料", new BigDecimal("699")));
            list.add(new MobilePhone("Pixel 6", "Google", sdf.parse("2021-10-28"), "Tensor", "6.4寸 OLED", "50MP主摄", "玻璃", new BigDecimal("599")));
        } catch (Exception e) {
            log("默认数据生成失败: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (allPhones.isEmpty()) loadAllPhones();
        req.setAttribute("allPhones", allPhones);

        List<MobilePhone> selectedPhones = new ArrayList<>();
        String[] ids = req.getParameterValues("id");
        if (ids != null) {
            for (String s : ids) {
                try {
                    int idx = Integer.parseInt(s);
                    if (idx >= 0 && idx < allPhones.size()) selectedPhones.add(allPhones.get(idx));
                } catch (NumberFormatException ignored) {}
            }
            req.setAttribute("selectedPhones", selectedPhones);
        }

        Map<String, Map<String, Object>> specs = new LinkedHashMap<>();
        specs.put("brand", spec("品牌", false, null));
        specs.put("releaseDate", spec("发布日期", true, "newer"));
        specs.put("processor", spec("处理器", false, null));
        specs.put("display", spec("屏幕", true, "larger"));
        specs.put("camera", spec("摄像头", true, "higher"));
        specs.put("material", spec("材质", false, null));
        specs.put("price", spec("价格", true, "lower"));
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
}