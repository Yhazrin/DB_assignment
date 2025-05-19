<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Smartphone - MobilePhoneSys</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/overview.css">
  <style>
    .form-container {
      max-width: 900px;
      margin: 2rem auto;
      background: #fff;
      padding: 2rem;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      border-radius: 12px;
    }

    .form-container h2 {
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.2rem;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      font-weight: bold;
      margin-bottom: 0.4rem;
    }

    .form-group input {
      padding: 0.6rem;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    .submit-btn {
      grid-column: span 2;
      padding: 0.8rem;
      background-color: #1e90ff;
      border: none;
      color: white;
      font-size: 1rem;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .submit-btn:hover {
      background-color: #005fa3;
    }
  </style>
</head>
<body>
<jsp:include page="sub/header.jsp" />
<main class="main-container">
  <div class="form-container">
    <h2>Add New Smartphone</h2>
    <form method="post"
          action="${pageContext.request.contextPath}"
          data-context-path="${pageContext.request.contextPath}">

      <input type="hidden" name="type" value="modifySQL">
      <input type="hidden" name="table" value="smartphones">

      <div class="form-grid">
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
        <button type="submit" class="submit-btn">Add Smartphone</button>
      </div>
    </form>
  </div>
</main>
<script src="${pageContext.request.contextPath}/assets/js/add_smartphone.js"></script>

</body>
</html>
