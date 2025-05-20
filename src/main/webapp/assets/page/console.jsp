<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Smartphone - MobilePhoneSys</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/console.css">
</head>
<body>
<jsp:include page="sub/header.jsp" />
<jsp:include page="sub/scripts.jsp" />

<div class="console-container">
  <div class="console-card">
    <h2>Add New Smartphone</h2>

    <form class="console-form"
          method="post"
          action="${pageContext.request.contextPath}/data?type=modifySQL&table=smartphones">

      <input type="hidden" name="type" value="modifySQL">
      <input type="hidden" name="table" value="smartphones">

      <div class="form-group">
        <label for="No">No</label>
        <input type="text" name="No" id="No" placeholder="Auto/Manual ID">
      </div>
      <div class="form-group">
        <label for="model">Model</label>
        <input type="text" name="model" id="model" required>
      </div>
      <div class="form-group">
        <label for="brand">Brand</label>
        <input type="text" name="brand" id="brand" required>
      </div>
      <div class="form-group">
        <label for="price_USD">Price (USD)</label>
        <input type="number" step="0.01" name="price_USD" id="price_USD" required>
      </div>
      <div class="form-group">
        <label for="sim">SIM</label>
        <input type="text" name="sim" id="sim">
      </div>
      <div class="form-group">
        <label for="processor_name">Processor</label>
        <input type="text" name="processor_name" id="processor_name">
      </div>
      <div class="form-group">
        <label for="ram">RAM</label>
        <input type="text" name="ram" id="ram">
      </div>
      <div class="form-group">
        <label for="Battery_Capacity">Battery (mAh)</label>
        <input type="number" name="Battery_Capacity" id="Battery_Capacity">
      </div>
      <div class="form-group">
        <label for="Charging_Info">Charging Info</label>
        <input type="text" name="Charging_Info" id="Charging_Info">
      </div>
      <div class="form-group">
        <label for="Rear_Camera">Rear Camera</label>
        <input type="text" name="Rear_Camera" id="Rear_Camera">
      </div>
      <div class="form-group">
        <label for="Front_Camera">Front Camera</label>
        <input type="text" name="Front_Camera" id="Front_Camera">
      </div>
      <div class="form-group">
        <label for="card">Card Slot</label>
        <input type="text" name="card" id="card">
      </div>
      <div class="form-group">
        <label for="os">Operating System</label>
        <input type="text" name="os" id="os">
      </div>

      <button type="submit" class="console-btn">Add Smartphone</button>
    </form>
  </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/add_smartphone.js"></script>
</body>
</html>
