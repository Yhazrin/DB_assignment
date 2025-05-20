<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String mode = request.getParameter("mode");
  if (mode == null) mode = "add";
  if (mode.equals("update")) mode = "update"; // 加这一句

  String formAction = "http://localhost:8080/ServerletFinal_war_exploded/data?type=modifySQL&table=smartphones&action=" + mode;
  String buttonText = mode.equals("add") ? "Add Smartphone"
          : mode.equals("delete") ? "Delete Smartphone"
          : "Change Smartphone";
%>

<div class="console-container">
  <div class="console-card">
    <h2><%= buttonText %></h2>


    <form class="console-form"
          method="post"
          data-context-path="${pageContext.request.contextPath}"
          action="<%= formAction %>">

      <input type="hidden" name="type" value="modifySQL">
      <input type="hidden" name="table" value="smartphones">

      <!-- Form fields 保持原样 -->
      <!-- ... 可复用之前的表单代码 ... -->

      <div class="form-group">
        <label for="No">No</label>
        <input type="text" name="No" id="No" placeholder="Auto/Manual ID" required>
      </div>
      <div class="form-group">
        <label for="model">Model</label>
        <input type="text" name="model" id="model">
      </div>
      <div class="form-group">
        <label for="brand">Brand</label>
        <input type="text" name="brand" id="brand">
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


      <button type="submit" class="console-btn"><%= buttonText %></button>
    </form>
  </div>
</div>
<% if ("delete".equals(mode)) { %>
<script src="${pageContext.request.contextPath}/assets/js/delete_smartphone.js"></script>
<% } else if ("add".equals(mode)) { %>
<script src="${pageContext.request.contextPath}/assets/js/add_smartphone.js"></script>
<% } else { %>
<script src="${pageContext.request.contextPath}/assets/js/update_smartphone.js"></script>
<% } %>



