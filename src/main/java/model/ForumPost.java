package model;

import java.util.Date;

// 论坛回复类
public class ForumPost {
    private int id;
    private int topicId;
    private String content;
    private String author;
    private Date createdAt;
    private Date updatedAt;
    private int likes;
    private int parentId; // 用于回复的层级，0表示直接回复主题
    
    // 构造函数、getter和setter方法
    public ForumPost() {}
    
    public ForumPost(int id, int topicId, String content, String author, Date createdAt) {
        this.id = id;
        this.topicId = topicId;
        this.content = content;
        this.author = author;
        this.createdAt = createdAt;
        this.updatedAt = createdAt;
        this.parentId = 0;
    }
    
    // Getter和Setter
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getTopicId() {
        return topicId;
    }
    
    public void setTopicId(int topicId) {
        this.topicId = topicId;
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
    
    public int getLikes() {
        return likes;
    }
    
    public void setLikes(int likes) {
        this.likes = likes;
    }
    
    public int getParentId() {
        return parentId;
    }
    
    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
}