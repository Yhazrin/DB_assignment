<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String mode = request.getParameter("mode");
  if (mode == null) mode = "add";
  if (mode.equals("update")) mode = "update"; // 加这一句
  if(mode.equals("delete")) mode = "delete";


%>


<!DOCTYPE html>


<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Smartphone Console - MobilePhoneSys</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/console.css">
  <style>
    .console-toolbar-vertical {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 20px;
      margin-top: 50px;
    }

    .console-toolbar-vertical .console-btn {
      width: 150px;
      padding: 10px;
      font-size: 16px;
      background-color: #2c7be5;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .console-toolbar-vertical .console-btn:hover {
      background-color: #1a66d1;
    }

    #formContainer {
      margin-top: 40px;
    }
  </style>
</head>


<body>
<jsp:include page="sub/header.jsp" />
<jsp:include page="sub/scripts.jsp" />

<!-- 页面初始按钮区 -->
<div class="console-toolbar-vertical">
  <button class="console-btn" onclick="loadForm('add')">Add</button>
  <button class="console-btn" onclick="loadForm('delete')">Delete</button>
  <button class="console-btn" onclick="loadForm('update')">Change</button>
</div>

<!-- 表单加载区域 -->
<div id="formContainer"></div>

<script>
  function loadForm(type) {
    fetch('${pageContext.request.contextPath}/assets/page/shared_smartphone_form.jsp?mode=' + type)
            .then(resp => resp.text())
            .then(html => {
              document.getElementById("formContainer").innerHTML = html;
            })
            .catch(err => {
              alert("❌ 加载表单失败：" + err.message);
            });
  }


</script>


</body>
</html>

<% if ("delete".equals(mode)) { %>
<script src="${pageContext.request.contextPath}/assets/js/delete_smartphone.js"></script>
<% } else if ("add".equals(mode)) { %>
<script src="${pageContext.request.contextPath}/assets/js/add_smartphone.js"></script>
<% } else { %>
<script src="${pageContext.request.contextPath}/assets/js/update_smartphone.js"></script>
<% } %>
