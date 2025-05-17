package model.sql;

public class Component {
    private int no;
    private String name;
    private String core;
    private String frequency;
    private String supplier;




    public Component(int no, String name, String core, String frequency, String supplier) {
        this.no = no;
        this.name = name;
        this.core = core;
        this.frequency = frequency;
        this.supplier = supplier;
    }

    // Getters and Setters
    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCore() { return core; }
    public void setCore(String core) { this.core = core; }

    public String getFrequency() { return frequency; }
    public void setFrequency(String frequency) { this.frequency = frequency; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    @Override
    public String toString() {
        return "Component{" +
                "no=" + no +
                ", name='" + name + '\'' +
                ", core='" + core + '\'' +
                ", frequency='" + frequency + '\'' +
                ", supplier='" + supplier + '\'' +
                '}';
    }
}
