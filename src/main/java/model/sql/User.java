// 文件：Model/User.java
package model.sql;

import java.util.List;

public class User {
    private String id;          // 用户唯一标识
    private String username;    // 用户名
    private String password;    // 密码（实际应加密存储）
    private String email;       // 邮箱
    private String isAdmin;       // 手机号
    private List<MobilePhone> favorites;

    // 无参构造
    public User() { }

    // 全参构造
    public User(String id, String username, String password, String email) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    // Getter & Setter
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
}
