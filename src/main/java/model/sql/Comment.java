// 文件：Model/Comment.java
package model.sql;

import model.sql.User;

import java.time.LocalDateTime;

public class Comment {
    private String id;                  // 评论唯一标识
    private boolean isSub;              // 是否是副评论（是否是评论的评论）
    private Comment parent;             // 是否是回复他人（默认null）
    private String content;             // 评论内容
    private User author;                // 评论作者
    private LocalDateTime createTime;   // 评论创建时间
    private Post post;                  // 所属帖子

    // 无参构造：自动设置创建时间
    public Comment() {
        this.createTime = LocalDateTime.now();
    }

    // 完整构造：包含帖子引用
    public Comment(String id, String content, User author, Post post, Comment parent, boolean isSub) {
        this.id = id;
        this.content = content;
        this.author = author;
        this.post = post;
        this.createTime = LocalDateTime.now();
        this.isSub = isSub;
        this.parent = parent;
    }

    // Getter & Setter
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
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

    public Post getPost() {
        return post;
    }
    public void setPost(Post post) {
        this.post = post;
    }

    public boolean isSub() {
        return isSub;
    }

    public void setSub(boolean isSub) {
        this.isSub = isSub;
    }

    public Comment getParent() {
        return parent;
    }

    public void setParent(Comment parent) {
        this.parent = parent;
    }
}
