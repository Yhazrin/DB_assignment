package model;

import java.math.BigDecimal;
import java.util.Date;

public class MobilePhone {
    private String name;          // 产品名称
    private String brand;         // 发布厂商
    private Date releaseDate;     // 发布日期
    private String processor;     // 处理器
    private String display;       // 屏幕
    private String camera;        // 摄像头规格
    private String material;      // 机身材质
    private BigDecimal price;     // 价格

    // 默认构造函数
    public MobilePhone() {
    }

    // 带参数的构造函数
    public MobilePhone(String name, String brand, Date releaseDate, String processor,
                       String display, String camera, String material, BigDecimal price) {
        this.name = name;
        this.brand = brand;
        this.releaseDate = releaseDate;
        this.processor = processor;
        this.display = display;
        this.camera = camera;
        this.material = material;
        this.price = price;
    }

    // Getter 和 Setter 方法
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getProcessor() {
        return processor;
    }

    public void setProcessor(String processor) {
        this.processor = processor;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public String getCamera() {
        return camera;
    }

    public void setCamera(String camera) {
        this.camera = camera;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "MobilePhone{" +
                "name='" + name + '\'' +
                ", brand='" + brand + '\'' +
                ", releaseDate=" + releaseDate +
                ", processor='" + processor + '\'' +
                ", display='" + display + '\'' +
                ", camera='" + camera + '\'' +
                ", material='" + material + '\'' +
                ", price=" + price +
                '}';
    }
}