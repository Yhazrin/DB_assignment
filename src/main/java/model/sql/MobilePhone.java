package model.sql;

public class MobilePhone {
    private int no;
    private String model;
    private String brand;
    private String priceUSD;
    private String sim;
    private String processorName;
    private String core;
    private String frequency;
    private String ram;
    private String batteryCapacity;
    private String chargingInfo;
    private String rearCamera;
    private String frontCamera;
    private String card;
    private String os;

    // Default constructor
    public MobilePhone() {
    }

    // Full constructor
    public MobilePhone(int no, String model, String brand, String priceUSD, String sim,
                       String processorName, String core, String frequency, String ram,
                       String batteryCapacity, String chargingInfo, String rearCamera,
                       String frontCamera, String card, String os) {
        this.no = no;
        this.model = model;
        this.brand = brand;
        this.priceUSD = priceUSD;
        this.sim = sim;
        this.processorName = processorName;
        this.core = core;
        this.frequency = frequency;
        this.ram = ram;
        this.batteryCapacity = batteryCapacity;
        this.chargingInfo = chargingInfo;
        this.rearCamera = rearCamera;
        this.frontCamera = frontCamera;
        this.card = card;
        this.os = os;
    }

    // Getters and Setters
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getPriceUSD() {
        return priceUSD;
    }

    public void setPriceUSD(String priceUSD) {
        this.priceUSD = priceUSD;
    }

    public String getSim() {
        return sim;
    }

    public void setSim(String sim) {
        this.sim = sim;
    }

    public String getProcessorName() {
        return processorName;
    }

    public void setProcessorName(String processorName) {
        this.processorName = processorName;
    }

    public String getCore() {
        return core;
    }

    public void setCore(String core) {
        this.core = core;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getBatteryCapacity() {
        return batteryCapacity;
    }

    public void setBatteryCapacity(String batteryCapacity) {
        this.batteryCapacity = batteryCapacity;
    }

    public String getChargingInfo() {
        return chargingInfo;
    }

    public void setChargingInfo(String chargingInfo) {
        this.chargingInfo = chargingInfo;
    }

    public String getRearCamera() {
        return rearCamera;
    }

    public void setRearCamera(String rearCamera) {
        this.rearCamera = rearCamera;
    }

    public String getFrontCamera() {
        return frontCamera;
    }

    public void setFrontCamera(String frontCamera) {
        this.frontCamera = frontCamera;
    }

    public String getCard() {
        return card;
    }

    public void setCard(String card) {
        this.card = card;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    @Override
    public String toString() {
        return "MobilePhone{" +
                "no=" + no +
                ", model='" + model + '\'' +
                ", brand='" + brand + '\'' +
                ", priceUSD='" + priceUSD + '\'' +
                ", sim='" + sim + '\'' +
                ", processorName='" + processorName + '\'' +
                ", core='" + core + '\'' +
                ", frequency='" + frequency + '\'' +
                ", ram='" + ram + '\'' +
                ", batteryCapacity='" + batteryCapacity + '\'' +
                ", chargingInfo='" + chargingInfo + '\'' +
                ", rearCamera='" + rearCamera + '\'' +
                ", frontCamera='" + frontCamera + '\'' +
                ", card='" + card + '\'' +
                ", os='" + os + '\'' +
                '}';
    }

}
