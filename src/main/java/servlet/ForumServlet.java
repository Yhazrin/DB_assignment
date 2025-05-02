package servlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 论坛功能Servlet，处理所有论坛相关请求
 */
public class ForumServlet extends HttpServlet {
    // 数据库连接信息
    private static final String DB_URL = "jdbc:mysql://localhost:3306/infosys?useUnicode=true&characterEncoding=UTF-8";
    private static final String DB_USER = "1";
    private static final String DB_PASS = "1";
    
    // 分页设置
    private static final int TOPICS_PER_PAGE = 10;
    private static final int POSTS_PER_PAGE = 20;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
        // 初始化数据库表
        initDatabase();
        
        // 初始化示例数据（如果需要）
        initSampleData();
    }
    
    /**
     * 创建必要的数据库表
     */
    private void initDatabase() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = getConnection()) {
                try (Statement stmt = conn.createStatement()) {
                    // 创建论坛分类表
                    stmt.execute(
                        "CREATE TABLE IF NOT EXISTS forum_categories (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "name VARCHAR(100) NOT NULL, " +
                        "description TEXT, " +
                        "topic_count INT DEFAULT 0, " +
                        "order_num INT DEFAULT 0" +
                        ")"
                    );
                    
                    // 创建论坛主题表
                    stmt.execute(
                        "CREATE TABLE IF NOT EXISTS forum_topics (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "title VARCHAR(255) NOT NULL, " +
                        "content TEXT NOT NULL, " +
                        "author VARCHAR(100) NOT NULL, " +
                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                        "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                        "views INT DEFAULT 0, " +
                        "likes INT DEFAULT 0, " +
                        "category_id INT, " +
                        "is_pinned BOOLEAN DEFAULT FALSE, " +
                        "FOREIGN KEY (category_id) REFERENCES forum_categories(id)" +
                        ")"
                    );
                    
                    // 创建论坛回复表
                    stmt.execute(
                        "CREATE TABLE IF NOT EXISTS forum_posts (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "topic_id INT NOT NULL, " +
                        "content TEXT NOT NULL, " +
                        "author VARCHAR(100) NOT NULL, " +
                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                        "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                        "likes INT DEFAULT 0, " +
                        "parent_id INT DEFAULT 0, " +
                        "FOREIGN KEY (topic_id) REFERENCES forum_topics(id) ON DELETE CASCADE" +
                        ")"
                    );
                    
                    // 创建用户积分表
                    stmt.execute(
                        "CREATE TABLE IF NOT EXISTS user_points (" +
                        "username VARCHAR(100) PRIMARY KEY, " +
                        "points INT DEFAULT 0, " +
                        "level INT DEFAULT 1, " +
                        "post_count INT DEFAULT 0, " +
                        "last_post_time TIMESTAMP NULL" +
                        ")"
                    );
                }
                
                // 检查是否已有论坛分类，如果没有则添加默认分类
                try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM forum_categories")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        try (PreparedStatement insertPs = conn.prepareStatement(
                                "INSERT INTO forum_categories (name, description, order_num) VALUES (?, ?, ?)")) {
                            
                            // 添加默认分类
                            insertPs.setString(1, "手机讨论");
                            insertPs.setString(2, "讨论各种手机型号、性能和特点");
                            insertPs.setInt(3, 1);
                            insertPs.executeUpdate();
                            
                            insertPs.setString(1, "购买建议");
                            insertPs.setString(2, "获取和分享购买建议和经验");
                            insertPs.setInt(3, 2);
                            insertPs.executeUpdate();
                            
                            insertPs.setString(1, "技术支持");
                            insertPs.setString(2, "解决手机使用中遇到的问题");
                            insertPs.setInt(3, 3);
                            insertPs.executeUpdate();
                        }
                    }
                }
            }
        } catch (Exception e) {
            log("初始化数据库失败: " + e.getMessage(), e);
        }
    }
    
    /**
     * 初始化示例数据
     */
    private void initSampleData() {
        try {
            // 检查是否已有主题，如果没有则添加示例主题
            Connection conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM forum_topics")) {
                ResultSet rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) == 0) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    
                    // 添加示例主题
                    try (PreparedStatement insertTopic = conn.prepareStatement(
                            "INSERT INTO forum_topics (title, content, author, category_id, created_at) VALUES (?, ?, ?, ?, ?)")) {
                        
                        // 主题1
                        insertTopic.setString(1, "iPhone 15 Pro Max 评测");
                        insertTopic.setString(2, "分享我使用iPhone 15 Pro Max一个月的体验，这款手机的性能和相机表现都非常出色...");
                        insertTopic.setString(3, "admin");
                        insertTopic.setInt(4, 1);
                        insertTopic.setTimestamp(5, new Timestamp(sdf.parse("2023-10-15 09:30:00").getTime()));
                        insertTopic.executeUpdate();
                        
                        // 主题2
                        insertTopic.setString(1, "有什么值得推荐的中端安卓手机？");
                        insertTopic.setString(2, "预算在3000元左右，想买一款性价比高的中端安卓手机，有什么推荐？");
                        insertTopic.setString(3, "user1");
                        insertTopic.setInt(4, 2);
                        insertTopic.setTimestamp(5, new Timestamp(sdf.parse("2023-10-18 14:20:00").getTime()));
                        insertTopic.executeUpdate();
                        
                        // 主题3
                        insertTopic.setString(1, "手机无法连接WiFi的解决方法");
                        insertTopic.setString(2, "最近手机突然无法连接WiFi，尝试了重启但没有解决，有没有其他解决方法？");
                        insertTopic.setString(3, "user2");
                        insertTopic.setInt(4, 3);
                        insertTopic.setTimestamp(5, new Timestamp(sdf.parse("2023-10-20 16:45:00").getTime()));
                        insertTopic.executeUpdate();
                    }
                    
                    // 添加示例回复
                    try (PreparedStatement insertPost = conn.prepareStatement(
                            "INSERT INTO forum_posts (topic_id, content, author, created_at) VALUES (?, ?, ?, ?)")) {
                        
                        // 回复主题1
                        insertPost.setInt(1, 1);
                        insertPost.setString(2, "谢谢分享，请问电池续航表现如何？");
                        insertPost.setString(3, "user3");
                        insertPost.setTimestamp(4, new Timestamp(sdf.parse("2023-10-16 10:15:00").getTime()));
                        insertPost.executeUpdate();
                        
                        // 回复主题2
                        insertPost.setInt(1, 2);
                        insertPost.setString(2, "推荐小米13，性价比很高");
                        insertPost.setString(3, "user4");
                        insertPost.setTimestamp(4, new Timestamp(sdf.parse("2023-10-19 08:30:00").getTime()));
                        insertPost.executeUpdate();
                        
                        insertPost.setInt(1, 2);
                        insertPost.setString(2, "可以考虑一下三星A系列，拍照挺不错的");
                        insertPost.setString(3, "user5");
                        insertPost.setTimestamp(4, new Timestamp(sdf.parse("2023-10-19 09:45:00").getTime()));
                        insertPost.executeUpdate();
                        
                        // 回复主题3
                        insertPost.setInt(1, 3);
                        insertPost.setString(2, "试试重置网络设置");
                        insertPost.setString(3, "admin");
                        insertPost.setTimestamp(4, new Timestamp(sdf.parse("2023-10-20 17:30:00").getTime()));
                        insertPost.executeUpdate();
                    }
                    
                    // 更新主题计数
                    try (PreparedStatement updateCategory = conn.prepareStatement(
                            "UPDATE forum_categories SET topic_count = (SELECT COUNT(*) FROM forum_topics WHERE category_id = forum_categories.id)")) {
                        updateCategory.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            log("初始化示例数据失败: " + e.getMessage(), e);
        }
    }

    /**
     * 处理GET请求：显示论坛页面、主题详情等
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查登录状态
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 根据action参数决定显示什么页面
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "list":
                    // 显示主题列表
                    showTopicList(request, response);
                    break;
                case "view":
                    // 显示主题详情
                    showTopicDetail(request, response);
                    break;
                case "new":
                    // 显示发表新主题页面
                    showNewTopicForm(request, response);
                    break;
                case "categories":
                    // 显示分类列表
                    showCategories(request, response);
                    break;
                default:
                    // 默认显示主题列表
                    showTopicList(request, response);
            }
        } catch (Exception e) {
            log("处理论坛GET请求出错: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "处理您的请求时发生错误，请稍后再试。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * 显示主题列表
     */
    private void showTopicList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // 获取分类ID和页码
        int categoryId = 0;
        try {
            String categoryParam = request.getParameter("categoryId");
            if (categoryParam != null && !categoryParam.isEmpty()) {
                categoryId = Integer.parseInt(categoryParam);
            }
        } catch (NumberFormatException e) {
            // 使用默认值
        }
        
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            // 使用默认值
        }
        
        // 计算偏移量
        int offset = (page - 1) * TOPICS_PER_PAGE;
        
        // 获取数据
        List<Map<String, Object>> topics = new ArrayList<>();
        int totalTopics = 0;
        Map<String, Object> currentCategory = null;
        
        try (Connection conn = getConnection()) {
            // 如果指定了分类，获取分类信息
            if (categoryId > 0) {
                try (PreparedStatement ps = conn.prepareStatement("SELECT id, name, description FROM forum_categories WHERE id = ?")) {
                    ps.setInt(1, categoryId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        currentCategory = new HashMap<>();
                        currentCategory.put("id", rs.getInt("id"));
                        currentCategory.put("name", rs.getString("name"));
                        currentCategory.put("description", rs.getString("description"));
                    }
                }
            }
            
            // 查询主题列表
            String sql = "SELECT id, title, author, created_at, views, likes FROM forum_topics";
            String countSql = "SELECT COUNT(*) FROM forum_topics";
            if (categoryId > 0) {
                sql += " WHERE category_id = ?";
                countSql += " WHERE category_id = ?";
            }
            sql += " ORDER BY is_pinned DESC, created_at DESC LIMIT ? OFFSET ?";
            
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                int paramIndex = 1;
                if (categoryId > 0) {
                    ps.setInt(paramIndex++, categoryId);
                }
                ps.setInt(paramIndex++, TOPICS_PER_PAGE);
                ps.setInt(paramIndex++, offset);
                
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> topic = new HashMap<>();
                    topic.put("id", rs.getInt("id"));
                    topic.put("title", rs.getString("title"));
                    topic.put("author", rs.getString("author"));
                    topic.put("created_at", rs.getTimestamp("created_at"));
                    topic.put("views", rs.getInt("views"));
                    topic.put("likes", rs.getInt("likes"));
                    topics.add(topic);
                }
            }
            
            // 查询总主题数
            try (PreparedStatement countPs = conn.prepareStatement(countSql)) {
                if (categoryId > 0) {
                    countPs.setInt(1, categoryId);
                }
                ResultSet rs = countPs.executeQuery();
                if (rs.next()) {
                    totalTopics = rs.getInt(1);
                }
            }
        }
        
        // 传递数据到JSP页面
        request.setAttribute("topics", topics);
        request.setAttribute("totalTopics", totalTopics);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil((double) totalTopics / TOPICS_PER_PAGE));
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("currentCategory", currentCategory);
        
        // 转发到JSP页面显示
        request.getRequestDispatcher("/forum.jsp").forward(request, response);
    }
    
    /**
     * 显示主题详情
     */
    private void showTopicDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // 获取主题ID
        int topicId = 0;
        try {
            topicId = Integer.parseInt(request.getParameter("topicId"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "无效的主题ID。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        // 获取页码
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            // 使用默认值
        }
        
        // 计算偏移量
        int offset = (page - 1) * POSTS_PER_PAGE;
        
        // 获取主题信息和回复列表
        Map<String, Object> topic = null;
        List<Map<String, Object>> posts = new ArrayList<>();
        int totalPosts = 0;
        
        try (Connection conn = getConnection()) {
            // 获取主题信息
            String sql = "SELECT id, title, content, author, created_at, views, likes FROM forum_topics WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, topicId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    topic = new HashMap<>();
                    topic.put("id", rs.getInt("id"));
                    topic.put("title", rs.getString("title"));
                    topic.put("content", rs.getString("content"));
                    topic.put("author", rs.getString("author"));
                    topic.put("created_at", rs.getTimestamp("created_at"));
                    topic.put("views", rs.getInt("views"));
                    topic.put("likes", rs.getInt("likes"));
                } else {
                    request.setAttribute("errorMessage", "找不到指定的主题。");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
            }
            
            // 更新浏览次数
            try (PreparedStatement ps = conn.prepareStatement("UPDATE forum_topics SET views = views + 1 WHERE id = ?")) {
                ps.setInt(1, topicId);
                ps.executeUpdate();
            }
            
            // 获取回复列表
            String postsSql = "SELECT id, content, author, created_at, likes FROM forum_posts WHERE topic_id = ?";
            String countSql = "SELECT COUNT(*) FROM forum_posts WHERE topic_id = ?";
            
            postsSql += " ORDER BY created_at ASC LIMIT ? OFFSET ?";
            
            try (PreparedStatement ps = conn.prepareStatement(postsSql)) {
                ps.setInt(1, topicId);
                ps.setInt(2, POSTS_PER_PAGE);
                ps.setInt(3, offset);
                
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> post = new HashMap<>();
                    post.put("id", rs.getInt("id"));
                    post.put("content", rs.getString("content"));
                    post.put("author", rs.getString("author"));
                    post.put("created_at", rs.getTimestamp("created_at"));
                    post.put("likes", rs.getInt("likes"));
                    posts.add(post);
                }
            }
            
            // 获取总回复数
            try (PreparedStatement countPs = conn.prepareStatement(countSql)) {
                countPs.setInt(1, topicId);
                ResultSet rs = countPs.executeQuery();
                if (rs.next()) {
                    totalPosts = rs.getInt(1);
                }
            }
        }
        
        // 传递数据到JSP页面
        request.setAttribute("topic", topic);
        request.setAttribute("posts", posts);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE));
        
        // 转发到JSP页面显示
        request.getRequestDispatcher("/topic.jsp").forward(request, response);
    }
    
    /**
     * 显示发表新主题的表单
     */
    private void showNewTopicForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // 获取分类列表
        List<Map<String, Object>> categories = new ArrayList<>();
        
        try (Connection conn = getConnection()) {
            String sql = "SELECT id, name FROM forum_categories ORDER BY order_num ASC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> category = new HashMap<>();
                    category.put("id", rs.getInt("id"));
                    category.put("name", rs.getString("name"));
                    categories.add(category);
                }
            }
        }
        
        // 传递数据到JSP页面
        request.setAttribute("categories", categories);
        
        // 转发到JSP页面显示
        request.getRequestDispatcher("/newTopic.jsp").forward(request, response);
    }
    
    /**
     * 显示分类列表
     */
    private void showCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // 获取分类列表
        List<Map<String, Object>> categories = new ArrayList<>();
        
        try (Connection conn = getConnection()) {
            String sql = "SELECT id, name, description, topic_count FROM forum_categories ORDER BY order_num ASC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> category = new HashMap<>();
                    category.put("id", rs.getInt("id"));
                    category.put("name", rs.getString("name"));
                    category.put("description", rs.getString("description"));
                    category.put("topic_count", rs.getInt("topic_count"));
                    categories.add(category);
                }
            }
        }
        
        // 传递数据到JSP页面
        request.setAttribute("categories", categories);
        
        // 转发到JSP页面显示
        request.getRequestDispatcher("/categories.jsp").forward(request, response);
    }

    /**
     * 处理POST请求：发表主题、回复等
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查登录状态
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 获取当前用户名
        String username = (String) session.getAttribute("username");

        // 根据action参数决定执行什么操作
        String action = request.getParameter("action");
        if (action == null) action = "reply";
        
        try {
            switch (action) {
                case "newTopic":
                    // 发表新主题
                    postNewTopic(request, response, username);
                    break;
                case "reply":
                    // 回复主题
                    postReply(request, response, username);
                    break;
                default:
                    // 默认回复主题
                    postReply(request, response, username);
            }
        } catch (Exception e) {
            log("处理论坛POST请求出错: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "处理您的请求时发生错误，请稍后再试。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    /**
     * 发表新主题
     */
    private void postNewTopic(HttpServletRequest request, HttpServletResponse response, String username)
            throws ServletException, IOException, SQLException {
        // 获取参数
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        // 验证参数
        if (title == null || title.isEmpty() || content == null || content.isEmpty()) {
            request.setAttribute("errorMessage", "标题和内容不能为空。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = getConnection()) {
            // 插入新主题
            String sql = "INSERT INTO forum_topics (category_id, title, content, author) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, categoryId);
                ps.setString(2, title);
                ps.setString(3, content);
                ps.setString(4, username);
                ps.executeUpdate();
                
                // 获取新主题的ID
                ResultSet generatedKeys = ps.getGeneratedKeys();
                int topicId = 0;
                if (generatedKeys.next()) {
                    topicId = generatedKeys.getInt(1);
                }
                
                // 更新分类主题计数
                try (PreparedStatement updateCategory = conn.prepareStatement(
                        "UPDATE forum_categories SET topic_count = topic_count + 1 WHERE id = ?")) {
                    updateCategory.setInt(1, categoryId);
                    updateCategory.executeUpdate();
                }
                
                // 重定向到主题详情页面
                response.sendRedirect(request.getContextPath() + "/forum?action=view&topicId=" + topicId);
            }
        }
    }
    
    /**
     * 回复主题
     */
    private void postReply(HttpServletRequest request, HttpServletResponse response, String username)
            throws ServletException, IOException, SQLException {
        // 获取参数
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        String content = request.getParameter("content");
        
        // 验证参数
        if (content == null || content.isEmpty()) {
            request.setAttribute("errorMessage", "回复内容不能为空。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = getConnection()) {
            // 插入新回复
            String sql = "INSERT INTO forum_posts (topic_id, content, author) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, topicId);
                ps.setString(2, content);
                ps.setString(3, username);
                ps.executeUpdate();
                
                // 重定向到主题详情页面
                response.sendRedirect(request.getContextPath() + "/forum?action=view&topicId=" + topicId);
            }
        }
    }
    
    /**
     * 获取数据库连接
     */
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("找不到数据库驱动", e);
        }
    }
}