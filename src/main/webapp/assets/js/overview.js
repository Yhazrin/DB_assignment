document.addEventListener("DOMContentLoaded", function () {
    const tbody = document.querySelector("#overview-table tbody");
    const thead = document.querySelector("#overview-table thead");
    const buttons = document.querySelectorAll(".color-btn");

    // 定义不同表对应的表头字段和列名（按顺序）
    const tableHeaders = {
        "mobile_brands": [
            { key: "Name", label: "Name" },
            { key: "Website", label: "Website" },
            { key: "Country", label: "Country" }
        ],
        "smartphones": [
            { key: "No", label: "No" },
            { key: "model", label: "Model" },
            { key: "brand", label: "Brand" },
            { key: "price_USD", label: "Price (USD)" },
            { key: "sim", label: "SIM" },
            { key: "processor_name", label: "Processor" },
            { key: "ram", label: "RAM" },
            { key: "Battery_Capacity", label: "Battery" },
            { key: "Charging_Info", label: "Charging" },
            { key: "Rear_Camera", label: "Rear Camera" },
            { key: "Front_Camera", label: "Front Camera" },
            { key: "card", label: "Card Slot" },
            { key: "os", label: "OS" }
        ],
        "component": [
            { key: "No", label: "No" },
            { key: "name", label: "Name" },
            { key: "core", label: "Core" },
            { key: "frequency", label: "Frequency" },
            { key: "supplier", label: "Supplier" }
        ],
        "supplier": [
            { key: "No", label: "No" },
            { key: "name", label: "Name" },
            { key: "web", label: "Website" },
            { key: "country", label: "Country" }
        ],
        "smartphone_sales_all_countries_1": [
            { key: "Country", label: "Country" },
            { key: "Brand", label: "Brand" },
            { key: "Column_2015", label: "2015(millions)" },
            { key: "Column_2016", label: "2016" },
            { key: "Column_2017", label: "2017" },
            { key: "Column_2018", label: "2018" },
            { key: "Column_2019", label: "2019" },
            { key: "Column_2020", label: "2020" },
            { key: "Column_2021", label: "2021" },
            { key: "Column_2022", label: "2022" },
            { key: "Column_2023", label: "2023" },
            { key: "Column_2024", label: "2024" }
        ]



        // 你可以继续为 processors, sales, suppliers 等表添加定义
        // "processors": [...],
        // "sales": [...],
        // "suppliers": [...]
    };

    function renderTableHeader(tableName) {
        const headers = tableHeaders[tableName];
        if (!headers) return;

        // 清空原有表头
        thead.innerHTML = "";
        const tr = document.createElement("tr");

        headers.forEach(h => {
            const th = document.createElement("th");
            th.textContent = h.label;
            tr.appendChild(th);
        });

        thead.appendChild(tr);
    }

    function loadData(tableName) {
        tbody.innerHTML = "<tr><td colspan='15'>LOADING...</td></tr>";

        // 先渲染表头
        renderTableHeader(tableName);

        const endpoint = `http://localhost:8080/ServerletFinal_war_exploded/data?type=readSQL&table=${tableName}`;


        fetch(endpoint)
            .then(response => {
                if (!response.ok) throw new Error("请求失败：" + response.status);
                return response.json();
            })
            .then(data => {
                if (!Array.isArray(data)) throw new Error("数据格式错误");
                tbody.innerHTML = "";

                const headers = tableHeaders[tableName];
                if (!headers) {
                    tbody.innerHTML = "<tr><td colspan='15'>无表头定义</td></tr>";
                    return;
                }

                data.forEach(row => {
                    const tr = document.createElement("tr");
                    headers.forEach(h => {
                        const td = document.createElement("td");
                        td.textContent = row[h.key] !== undefined ? row[h.key] : "-";
                        tr.appendChild(td);
                    });
                    tbody.appendChild(tr);
                });
            })
            .catch(error => {
                console.error("加载失败：", error);
                tbody.innerHTML = `<tr><td colspan='15' style='color:red;'>加载失败：${error.message}</td></tr>`;
            });
    }

    buttons.forEach(button => {
        button.addEventListener("click", () => {
            buttons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");

            const tableName = button.getAttribute("data-page");
            loadData(tableName);
        });
    });

    loadData("smartphones"); // 默认加载智能手机数据
});
