package model;

// 论坛分类类
public class ForumCategory {
    private int id;
    private String name;
    private String description;
    private int topicCount;
    private int order;
    
    // 构造函数、getter和setter方法
    public ForumCategory() {}
    
    public ForumCategory(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.topicCount = 0;
        this.order = 0;
    }
    
    // Getter和Setter
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getTopicCount() {
        return topicCount;
    }
    
    public void setTopicCount(int topicCount) {
        this.topicCount = topicCount;
    }
    
    public int getOrder() {
        return order;
    }
    
    public void setOrder(int order) {
        this.order = order;
    }
}