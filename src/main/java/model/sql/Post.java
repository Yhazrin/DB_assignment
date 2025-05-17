// 文件：Model/Post.java
package model.sql;

import model.sql.User;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Post {
    private String id;                  // 帖子唯一标识
    private String title;               // 帖子标题
    private String content;             // 帖子内容
    private User author;                // 发帖用户
    private LocalDateTime createTime;   // 创建时间
    private List<Comment> comments;     // 评论

    public Post() {
        this.createTime = LocalDateTime.now();
    }

    public Post(String id, String title, String content, User author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.author = author;
        this.createTime = LocalDateTime.now();
        this.comments = new ArrayList<>();
    }

    // Getter & Setter
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public User getAuthor() {
        return author;
    }
    public void setAuthor(User author) {
        this.author = author;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }
    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}
