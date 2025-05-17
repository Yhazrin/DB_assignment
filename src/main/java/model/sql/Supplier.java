package model.sql;

public class Supplier {
    private int no;
    private String name;
    private String web;
    private String country;


    public Supplier(int no, String name, String web, String country) {
        this.no = no;
        this.name = name;
        this.web = web;
        this.country = country;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWeb() {
        return web;
    }

    public void setWeb(String web) {
        this.web = web;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}

