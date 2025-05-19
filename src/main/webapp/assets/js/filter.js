// filter.js

document.querySelectorAll(".range-filter .apply").forEach(button => {
    button.addEventListener("click", async () => {
        const filterDiv = button.closest(".range-filter");
        const field = filterDiv.dataset.field;

        const min = filterDiv.querySelector(".min").value;
        const max = filterDiv.querySelector(".max").value;

        const params = new URLSearchParams();
        params.append("type", "readSQL");
        params.append("table", "smartphones");

        if (field === "price") {
            if (min) {
                params.append("key", "price_USD>=");
                params.append("value", min);
            }
            if (max) {
                params.append("key", "price_USD<=");
                params.append("value", max);
            }
        } else if (field === "battery") {
            if (min) {
                params.append("key", "Battery_Capacity>=");
                params.append("value", min);
            }
            if (max) {
                params.append("key", "Battery_Capacity<=");
                params.append("value", max);
            }
        }

        const modelValue = document.querySelector("#search-model")?.value;
        if (modelValue) {
            params.append("key", "model");
            params.append("value", modelValue);
        }

        try {
            const resp = await fetch(`http://localhost:8080/ServerletFinal_war_exploded/data?${params.toString()}`);
            const result = await resp.json();

            if (Array.isArray(result)) {
                renderResults(result);
            } else {
                alert("⚠️ 查询失败：" + JSON.stringify(result));
            }
        } catch (err) {
            alert("❌ 网络错误：" + err.message);
        }
    });
});

function renderResults(data) {
    const tbody = document.querySelector("#overview-table tbody");
    if (!tbody) {
        console.error("找不到 #overview-table tbody");
        return;
    }
    tbody.innerHTML = ""; // 先清空旧内容
    data.forEach((item, index) => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td>${index + 1}</td>
            <td>${item.model || ""}</td>
            <td>${item.brand || ""}</td>
            <td>${item.price_USD || ""}</td>
            <td>${item.sim || ""}</td>
            <td>${item.processor || ""}</td>
            <td>${item.ram || ""}</td>
            <td>${item.Battery_Capacity || ""}</td>
            <td>${item.charging || ""}</td>
            <td>${item.rear_camera || ""}</td>
            <td>${item.front_camera || ""}</td>
            <td>${item.card_slot || ""}</td>
            <td>${item.os || ""}</td>
        `;
        tbody.appendChild(tr);
    });
}

