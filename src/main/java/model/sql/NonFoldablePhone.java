package model.sql;

public class NonFoldablePhone {
    private int no;
    private String model;
    private String screen;


    public NonFoldablePhone(int no, String model, String screen) {
        this.no = no;
        this.model = model;
        this.screen = screen;
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

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
    }

    @Override
    public String toString() {
        return "NonFoldablePhone{" +
                "no=" + no +
                ", model='" + model + '\'' +
                ", screen='" + screen + '\'' +
                '}';
    }
}

