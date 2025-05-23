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
</head>

<body>
<jsp:include page="sub/header.jsp" />
<jsp:include page="sub/scripts.jsp" />

  <div class="main-container">
    <div class="console-buttons">
      <button class="console-btn">Add</button>
      <button class="console-btn">Delete</button>
      <button class="console-btn">Change</button>
    </div>
    <div id="formContainer"></div>
  </div>
</body>
</html>

<script>
  window.CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/assets/js/form.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/add_smartphone.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/update_smartphone.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/delete_smartphone.js"></script>


