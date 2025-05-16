package model.sql;

public class MobileBrand {
    private String name;
    private String website;
    private String country;

    public MobileBrand(String name, String website, String country) {
        this.name = name;
        this.website = website;
        this.country = country;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}

