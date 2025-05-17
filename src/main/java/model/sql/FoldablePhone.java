package model.sql;

public class FoldablePhone {
    private int no;
    private String model;
    private String style;

    public FoldablePhone(int no, String model, String style) {
        this.no = no;
        this.model = model;
        this.style = style;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }
}
