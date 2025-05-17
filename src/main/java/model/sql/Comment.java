// 文件：Model/Comment.java
package model.sql;

import model.sql.User;

import java.time.LocalDateTime;

public class Comment {
    private String id;                  // 评论唯一标识
    private boolean isSub;              // 是否是副评论（是否是评论的评论）
    private Comment parent;             // 是否是回复他人（默认null）
    private String content;             // 评论内容
    private String author;                // 评论作者
    private LocalDateTime createTime;   // 评论创建时间
    private String postID;                  // 所属帖子

    // 无参构造：自动设置创建时间
    public Comment() {
        this.createTime = LocalDateTime.now();
    }

    // 完整构造：包含帖子引用
    public Comment(String id, String content, String author, String postID, Comment parent, boolean isSub) {
        this.id = id;
        this.content = content;
        this.author = author;
        this.postID = postID;
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

    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }
    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public String getPostID() {
        return postID;
    }
    public void setPostID(String postID) {
        this.postID = postID;
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

    @Override
    public String toString() {
        return "Comment{id='" + id + "', content='" + content + "', author='" + author +
                "', postId='" + postID + "', isSub=" + isSub + ", parent=" +
                (parent != null ? parent.getId() : "null") + ", createTime=" + createTime + "}";
    }

}
