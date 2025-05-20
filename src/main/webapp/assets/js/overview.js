document.addEventListener("DOMContentLoaded", function () {
    const tbody = document.querySelector("#overview-table tbody");
    const thead = document.querySelector("#overview-table thead");
    const buttons = document.querySelectorAll(".color-btn");
    const infoText = document.getElementById("infoText");
    // 表头定义
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
            { key: "Column_2015", label: "2015" },
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
    };

    const tableDescriptions = {
        "mobile_brands": "Brand table: showing the name of the mobile phone brand, the official website address and the country it belongs to.",
        "smartphones": "Mobilephone information table: including parameters such as model, brand, price, configuration and battery.",
        "component": "Component table: showing the core, frequency and supplier information of various hardware components.",
        "supplier": "Supplier table: including supplier names, official websites and countries.",
        "smartphone_sales_all_countries_1": "Sales table (unit: million): presenting the annual sales situation from 2015 to 2024 by country and brand."
    };

    let currentTable = "smartphones"; // 当前表格名

    function renderTableHeader(tableName) {
        const headers = tableHeaders[tableName];
        if (!headers) return;

        thead.innerHTML = "";
        const tr = document.createElement("tr");

        headers.forEach(h => {
            const th = document.createElement("th");
            th.textContent = h.label;
            tr.appendChild(th);
        });

        thead.appendChild(tr);
    }

    function renderResults(data, tableName) {
        const headers = tableHeaders[tableName];
        if (!headers) return;

        tbody.innerHTML = "";
        data.forEach((row, index) => {
            const tr = document.createElement("tr");
            headers.forEach(h => {
                const td = document.createElement("td");
                // 若字段是 No 且缺失，则补 index+1
                td.textContent = h.key === "No" && row[h.key] == null ? index + 1 : (row[h.key] ?? "-");
                tr.appendChild(td);
            });
            tbody.appendChild(tr);
        });
    }

    async function fetchData(params, tableName) {
        tbody.innerHTML = "<tr><td colspan='15'>LOADING...</td></tr>";
        renderTableHeader(tableName);
        infoText.textContent = "Loading data for " + tableName + "...";

        try {
            const url = `http://localhost:8080/ServerletFinal_war_exploded/data?${params.toString()}`;
            const resp = await fetch(url);
            const data = await resp.json();

            if (Array.isArray(data)) {
                renderResults(data, tableName);
                infoText.textContent = tableDescriptions[tableName] || "Data loaded.";
            } else {
                throw new Error("数据格式错误");
            }
        } catch (err) {
            console.error("加载失败：", err);
            tbody.innerHTML = `<tr><td colspan='15' style='color:red;'>加载失败：${err.message}</td></tr>`;
            infoText.textContent = "加载失败，请检查网络连接或表名。";
        }
    }

    // 按钮切换表格
    buttons.forEach(button => {
        button.addEventListener("click", () => {
            buttons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");

            currentTable = button.getAttribute("data-page");
            const params = new URLSearchParams();
            params.append("type", "readSQL");
            params.append("table", currentTable);
            fetchData(params, currentTable);
        });
    });

    document.getElementById("searchBtn")?.addEventListener("click", function (event) {
        event.preventDefault(); // 阻止默认提交

        const searchInput = document.getElementById("searchInput");
        const inputValue = searchInput?.value?.trim();

        if (!inputValue) {
            alert("Please enter a phone No. or model.");
            return;
        }

        const params = new URLSearchParams();
        params.append("type", "readSQL");
        params.append("table", "smartphones");

        // 判断输入是否全是数字
        if (/^\d+$/.test(inputValue)) {
            // 全数字，作为 phoneNo 查询
            params.append("phoneNo", inputValue);
        } else {
            // 含非数字字符，作为 model 查询
            params.append("model", inputValue);
        }

        currentTable = "smartphones";
        buttons.forEach(btn => btn.classList.remove("active"));
        document.querySelector('[data-page="smartphones"]')?.classList.add("active");

        fetchData(params, currentTable);
    });



    // 区间过滤器（只作用于 smartphones 表）
    document.querySelectorAll(".range-filter .apply").forEach(button => {
        button.addEventListener("click", (event) => {
            event.preventDefault();

            const params = new URLSearchParams();
            params.append("type", "readSQL");
            params.append("table", "smartphones");

            const filterDiv = button.closest(".range-filter");
            const field = filterDiv.dataset.field;
            const min = filterDiv.querySelector(".min").value;
            const max = filterDiv.querySelector(".max").value;

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

            currentTable = "smartphones"; // 强制切回手机表
            buttons.forEach(btn => btn.classList.remove("active"));
            document.querySelector('[data-page="smartphones"]')?.classList.add("active");
            fetchData(params, currentTable);
        });
    });

    // 默认加载
    const initParams = new URLSearchParams();
    initParams.append("type", "readSQL");
    initParams.append("table", currentTable);
    fetchData(initParams, currentTable);
});
