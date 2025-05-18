document.addEventListener("DOMContentLoaded", function () {
    const tbody = document.querySelector("#overview-table tbody");
    const buttons = document.querySelectorAll(".color-btn");

    function loadData(page) {
        tbody.innerHTML = "<tr><td colspan='15'>LOADING...</td></tr>";
        const endpoint = `http://localhost:8080/ServerletFinal_war_exploded/data?type=sql&page=${page}`;

        fetch(endpoint)
            .then(function(response) {
                if (!response.ok) throw new Error("请求失败：" + response.status);
                return response.json();
            })
            .then(function(data) {
                if (!Array.isArray(data)) throw new Error("数据格式错误");
                tbody.innerHTML = "";
                data.forEach(function(phone) {
                    const tr = document.createElement("tr");
                    tr.innerHTML =
                        "<td>" + (phone.No || "") + "</td>" +
                        "<td>" + (phone.model || "-") + "</td>" +
                        "<td>" + (phone.brand || "-") + "</td>" +
                        "<td>" + (phone.price_USD || "-") + "</td>" +           // ✅ 注意此处
                        "<td>" + (phone.sim || "-") + "</td>" +
                        "<td>" + (phone.processor_name || "-") + "</td>" +      // ✅ 注意此处// ✅ 注意大小写
                        "<td>" + (phone.ram || "-") + "</td>" +
                        "<td>" + (phone.Battery_Capacity || "-") + "</td>" +    // ✅ 注意下划线
                        "<td>" + (phone.Charging_Info || "-") + "</td>" +
                        "<td>" + (phone.Rear_Camera || "-") + "</td>" +
                        "<td>" + (phone.Front_Camera || "-") + "</td>" +
                        "<td>" + (phone.card || "-") + "</td>" +
                        "<td>" + (phone.os || "-") + "</td>";


                    tbody.appendChild(tr);
                });
            })
            .catch(function(error) {
                console.error("加载失败：", error);
                tbody.innerHTML = "<tr><td colspan='15' style='color:red;'>加载失败：" + error.message + "</td></tr>";
            });
    }

    buttons.forEach(button => {
        button.addEventListener("click", () => {
            buttons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");
            const page = button.getAttribute("data-page");
            loadData(page);
        });
    });

    loadData(7); // 默认加载
});