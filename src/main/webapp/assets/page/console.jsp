<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>


<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Smartphone Console - MobilePhoneSys</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/console.css">
</head>


<body>
<jsp:include page="sub/header.jsp" />
<jsp:include page="sub/scripts.jsp" />

<!-- 页面初始按钮区 -->
  <div class="console-buttons">
    <button class="console-btn color-btn" onclick="loadForm('add')">Add</button>
    <button class="console-btn color-btn" onclick="loadForm('delete')">Delete</button>
    <button class="console-btn color-btn" onclick="loadForm('update')">Change</button>
  </div>


  <div id="formContainer"></div>

<script>
  function loadForm(type) {
    fetch('${pageContext.request.contextPath}/assets/page/sub/shared_form.jsp?mode=' + type)
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
