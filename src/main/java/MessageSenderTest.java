

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

    public static void main(String[] args) throws IOException {
        String type = "sql";
        String num = "1";  // 这里可以改成"2", "3", ...测试不同解析

        String backendUrl = "http://localhost:8080/ServerletFinal_war_exploded/data?type=" + type + "&page=" + num;
        String backendUrl1 = "http://localhost:8080/ServerletFinal_war_exploded/data?type=forum&subType=get";
        System.out.println("== Running MessageSenderTest ==");

        try {
            String json = fetchJsonFromBackend(backendUrl1);
            System.out.println("Raw JSON from backend: " + json);
            List<Forum> forums = parseJsonToForums(json);
            System.out.println("\n== Parsed Components ==");
            forums.forEach(System.out::println);
        }catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }

/**
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
        }*/
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


    private static List<Comment> parseJsonToComments(String json) {
        List<Comment> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);

                String id = obj.optString("id");
                String content = obj.optString("content");
                boolean isSub = obj.optBoolean("isSub");

                // 解析作者 User 对象（假设 JSON 有一个嵌套对象 author）
                JSONObject authorObj = obj.optJSONObject("author");
                User author = null;
                if (authorObj != null) {
                    String userId = authorObj.optString("id");
                    String username = authorObj.optString("username");
                    String password = authorObj.optString("password");
                    String email = authorObj.optString("email");
                    author = new User(userId, username, password, email);
                }

                // 解析帖子 Post 对象（只用 ID 简化处理）
                JSONObject postObj = obj.optJSONObject("post");
                Post post = null;
                if (postObj != null) {
                    String postId = postObj.optString("id");
                    String title = postObj.optString("title");
                    String contentPost = postObj.optString("content");
                    // 注意这里如果要更详细，需要解析 Post 的作者等，先简单构造
                    post = new Post(postId, title, contentPost, null);
                }

                // 解析父评论（parent），只取 id 来构造一个简单 Comment 对象
                Comment parent = null;
                JSONObject parentObj = obj.optJSONObject("parent");
                if (parentObj != null) {
                    String parentId = parentObj.optString("id");
                    parent = new Comment();
                    parent.setId(parentId);
                }

                Comment comment = new Comment(id, content, author, post, parent, isSub);
                list.add(comment);
            }
        } catch (Exception e) {
            System.err.println("Error parsing Comment JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<Forum> parseJsonToForums(String json) {
        List<Forum> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);

                String title = obj.optString("title");
                String description = obj.optString("description");

                Forum forum = new Forum(title, description);

                // 解析posts数组
                JSONArray postsArr = obj.optJSONArray("posts");
                if (postsArr != null) {
                    List<Post> posts = new ArrayList<>();
                    for (int j = 0; j < postsArr.length(); j++) {
                        JSONObject postObj = postsArr.getJSONObject(j);

                        String postId = postObj.optString("id");
                        String postTitle = postObj.optString("title");
                        String postContent = postObj.optString("content");

                        // 这里暂时用null做作者，复杂可继续解析User
                        Post post = new Post(postId, postTitle, postContent, null);

                        posts.add(post);
                    }
                    forum.setPosts(posts);
                }
                list.add(forum);
            }
        } catch (Exception e) {
            System.err.println("Error parsing Forum JSON: " + e.getMessage());
        }
        return list;
    }



    private static List<Post> parseJsonToPosts(String json) {
        List<Post> list = new ArrayList<>();
        try {
            JSONArray arr = new JSONArray(json);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject obj = arr.getJSONObject(i);

                String id = obj.optString("id");
                String title = obj.optString("title");
                String content = obj.optString("content");

                // 解析author对象
                JSONObject authorObj = obj.optJSONObject("author");
                User author = null;
                if (authorObj != null) {
                    String userId = authorObj.optString("id");
                    String username = authorObj.optString("username");
                    String password = authorObj.optString("password");
                    String email = authorObj.optString("email");
                    author = new User(userId, username, password, email);
                }

                Post post = new Post(id, title, content, author);

                // 解析评论列表
                JSONArray commentsArr = obj.optJSONArray("comments");
                if (commentsArr != null) {
                    List<Comment> comments = new ArrayList<>();
                    for (int j = 0; j < commentsArr.length(); j++) {
                        JSONObject commentObj = commentsArr.getJSONObject(j);
                        String commentId = commentObj.optString("id");
                        String commentContent = commentObj.optString("content");
                        boolean isSub = commentObj.optBoolean("isSub", false);

                        // 评论作者解析
                        JSONObject commentAuthorObj = commentObj.optJSONObject("author");
                        User commentAuthor = null;
                        if (commentAuthorObj != null) {
                            commentAuthor = new User(
                                    commentAuthorObj.optString("id"),
                                    commentAuthorObj.optString("username"),
                                    commentAuthorObj.optString("password"),
                                    commentAuthorObj.optString("email")
                            );
                        }

                        // 父评论不解析对象，暂设null（可递归实现）
                        Comment parent = null;

                        Comment comment = new Comment(commentId, commentContent, commentAuthor, post, parent, isSub);
                        comments.add(comment);
                    }
                    post.setComments(comments);
                }

                list.add(post);
            }
        } catch (Exception e) {
            System.err.println("Error parsing Posts JSON: " + e.getMessage());
        }
        return list;
    }





}
