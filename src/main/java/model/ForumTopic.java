package model;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

// 论坛主题类
public class ForumTopic {
    private int id;
    private String title;
    private String content;
    private String author;
    private Date createdAt;
    private Date updatedAt;
    private int views;
    private int likes;
    private int categoryId;
    private String categoryName;
    private boolean isPinned;
    private List<ForumPost> replies = new ArrayList<>();
    
    // 构造函数、getter和setter方法
    public ForumTopic() {}
    
    public ForumTopic(int id, String title, String content, String author, Date createdAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.author = author;
        this.createdAt = createdAt;
        this.updatedAt = createdAt;
    }
    
    // Getter和Setter
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
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
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public int getViews() {
        return views;
    }
    
    public void setViews(int views) {
        this.views = views;
    }
    
    public int getLikes() {
        return likes;
    }
    
    public void setLikes(int likes) {
        this.likes = likes;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public boolean isPinned() {
        return isPinned;
    }
    
    public void setPinned(boolean pinned) {
        isPinned = pinned;
    }
    
    public List<ForumPost> getReplies() {
        return replies;
    }
    
    public void setReplies(List<ForumPost> replies) {
        this.replies = replies;
    }
    
    public void addReply(ForumPost reply) {
        this.replies.add(reply);
    }
}