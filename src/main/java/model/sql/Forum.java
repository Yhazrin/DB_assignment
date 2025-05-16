package model.sql;

import java.util.ArrayList;
import java.util.List;

public class Forum {
    private String title;               // 版块标题
    private String description;         // 版块简介
    private List<Post> posts;           // 本版块下的帖子列表

    public Forum() {
        this.posts = new ArrayList<>();
    }

    public Forum(String title, String description) {
        this.title = title;
        this.description = description;
        this.posts = new ArrayList<>();
    }

    // 增加一个帖子
    public void addPost(Post post) {
        this.posts.add(post);
    }

    // Getter & Setter
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public List<Post> getPosts() {
        return posts;
    }
    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }
}
