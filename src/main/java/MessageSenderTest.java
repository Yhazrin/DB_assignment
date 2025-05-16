

import model.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class MessageSenderTest {

    public static void main(String[] args) {
        String type = "sql";
        String num = "1";  // 这里可以改成"2", "3", ...测试不同解析

        String backendUrl = "http://localhost:8080/ServerletFinal_war_exploded/data?type=" + type + "&page=" + num;

        System.out.println("== Running MessageSenderTest ==");

        try {
            String json = fetchJsonFromBackend(backendUrl);
            System.out.println("Raw JSON Response: ");

            int page = Integer.parseInt(num);

            switch (page) {
                case 1:
                    List<Component> components = parseJsonToComponents(json);
                    System.out.println("\n== Parsed Components ==");
                    components.forEach(System.out::println);
                    break;
                case 2:
                    List<Country> countries = parseJsonToCountries(json);
                    System.out.println("\n== Parsed Countries ==");
                    countries.forEach(System.out::println);
                    break;
                case 3:
                    List<MobileBrand> brands = parseJsonToMobileBrands(json);
                    System.out.println("\n== Parsed Mobile Brands ==");
                    brands.forEach(System.out::println);
                    break;
                case 4:
                    List<FoldablePhone> foldables = parseJsonToFoldablePhones(json);
                    System.out.println("\n== Parsed Foldable Phones ==");
                    foldables.forEach(System.out::println);
                    break;
                case 5:
                    List<NonFoldablePhone> nonFoldables = parseJsonToNonFoldablePhones(json);
                    System.out.println("\n== Parsed Non-Foldable Phones ==");
                    nonFoldables.forEach(System.out::println);
                    break;
                case 6:
                    List<Supplier> suppliers = parseJsonToSuppliers(json);
                    System.out.println("\n== Parsed Suppliers ==");
                    suppliers.forEach(System.out::println);
                    break;
                default:
                    System.err.println("Unsupported page number: " + page);
                    break;
            }

        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 从后端获取 JSON 数据
    private static String fetchJsonFromBackend(String backendUrl) throws IOException {
        URL url = new URL(backendUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(3000);
        conn.setReadTimeout(3000);

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) {
                response.append(line);
            }
            in.close();
            return response.toString();
        } else {
            throw new IOException("Failed to connect. HTTP response code: " + responseCode);
        }
    }






    private static List<Component> parseJsonToComponents(String json) {
        List<Component> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                int no = obj.optInt("no");
                String name = obj.optString("name");
                String core = obj.optString("core");
                String frequency = obj.optString("frequency");
                String supplier = obj.optString("supplier");

                Component component = new Component(no, name, core, frequency, supplier);
                list.add(component);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<Country> parseJsonToCountries(String json) {
        List<Country> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                String countryName = obj.optString("countryName");
                String continent = obj.optString("continent");

                Country country = new Country(countryName, continent);
                list.add(country);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }




    private static List<FoldablePhone> parseJsonToFoldablePhones(String json) {
        List<FoldablePhone> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                int no = obj.optInt("no");
                String model = obj.optString("model");
                String style = obj.optString("style");

                FoldablePhone phone = new FoldablePhone(no, model, style);
                list.add(phone);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<MobileBrand> parseJsonToMobileBrands(String json) {
        List<MobileBrand> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                String name = obj.optString("name");
                String website = obj.optString("website");
                String country = obj.optString("country");

                MobileBrand brand = new MobileBrand(name, website, country);
                list.add(brand);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }




    private static List<MobilePhone> parseJsonToPhones(String json) {
        List<MobilePhone> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                MobilePhone phone = new MobilePhone();

                phone.setNo(obj.optInt("no"));
                phone.setModel(obj.optString("model"));
                phone.setBrand(obj.optString("brand"));
                phone.setPriceUSD(obj.optString("priceUSD"));
                phone.setSim(obj.optString("sim"));
                phone.setProcessorName(obj.optString("processorName"));
                phone.setCore(obj.optString("core"));
                phone.setFrequency(obj.optString("frequency"));
                phone.setRam(obj.optString("ram"));
                phone.setBatteryCapacity(obj.optString("batteryCapacity"));
                phone.setChargingInfo(obj.optString("chargingInfo"));
                phone.setRearCamera(obj.optString("rearCamera"));
                phone.setFrontCamera(obj.optString("frontCamera"));
                phone.setCard(obj.optString("card"));
                phone.setOs(obj.optString("os"));

                list.add(phone);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<NonFoldablePhone> parseJsonToNonFoldablePhones(String json) {
        List<NonFoldablePhone> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                int no = obj.optInt("no");
                String model = obj.optString("model");
                String screen = obj.optString("screen");

                NonFoldablePhone phone = new NonFoldablePhone(no, model, screen);
                list.add(phone);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<Supplier> parseJsonToSuppliers(String json) {
        List<Supplier> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                int no = obj.optInt("no");
                String name = obj.optString("name");
                String web = obj.optString("web");
                String country = obj.optString("country");

                Supplier supplier = new Supplier(no, name, web, country);
                list.add(supplier);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return list;
    }




    private static List<User> parseJsonToUsers(String json) {
        List<User> userList = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);
                User user = new User();
                user.setId(obj.optString("id"));
                user.setUsername(obj.optString("username"));
                user.setPassword(obj.optString("password"));
                user.setEmail(obj.optString("email"));
                userList.add(user);
            }
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
        }
        return userList;
    }



}
