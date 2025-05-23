// src/main/webapp/assets/js/overview.js

document.addEventListener("DOMContentLoaded", () => {
    // DOM elements
    const table         = document.getElementById("overview-table");
    const thead         = table.querySelector("thead");
    const tbody         = table.querySelector("tbody");
    const buttons       = document.querySelectorAll(".color-btn");
    const infoText      = document.getElementById("infoText");
    const searchBtn     = document.getElementById("searchBtn");
    const searchInput   = document.getElementById("searchInput");
    const rangeFilters  = document.querySelectorAll(".range-filter .apply");
    const modelFilter   = document.getElementById("search-model");

    // Table headers definition
    const tableHeaders = {
        mobile_brands: [
            { key: "Name",    label: "Name" },
            { key: "Website", label: "Website" },
            { key: "Country", label: "Country" }
        ],
        smartphones: [
            { key: "No",               label: "No" },
            { key: "model",            label: "Model" },
            { key: "brand",            label: "Brand" },
            { key: "price_USD",        label: "Price (USD)" },
            { key: "sim",              label: "SIM" },
            { key: "processor_name",   label: "Processor" },
            { key: "ram",              label: "RAM" },
            { key: "Battery_Capacity", label: "Battery" },
            { key: "Charging_Info",    label: "Charging" },
            { key: "Rear_Camera",      label: "Rear Camera" },
            { key: "Front_Camera",     label: "Front Camera" },
            { key: "card",             label: "Card Slot" },
            { key: "os",               label: "OS" }
        ],
        component: [
            { key: "No",        label: "No" },
            { key: "name",      label: "Name" },
            { key: "core",      label: "Core" },
            { key: "frequency", label: "Frequency" },
            { key: "supplier",  label: "Supplier" }
        ],
        supplier: [
            { key: "No",      label: "No" },
            { key: "name",    label: "Name" },
            { key: "web",     label: "Website" },
            { key: "country", label: "Country" }
        ],
        smartphone_sales_all_countries_1: [
            { key: "Country",     label: "Country" },
            { key: "Brand",       label: "Brand" },
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

    // Table descriptions
    const tableDescriptions = {
        mobile_brands: "Brand table: showing the name of the mobile phone brand, the official website address and the country it belongs to.",
        smartphones:  "Mobilephone information table: including parameters such as model, brand, price, configuration and battery.",
        component:    "Component table: showing the core, frequency and supplier information of various hardware components.",
        supplier:     "Supplier table: including supplier names, official websites and countries.",
        smartphone_sales_all_countries_1: "Sales table (unit: million): presenting the annual sales situation from 2015 to 2024 by country and brand."
    };

    // Current table name
    let currentTable = "smartphones";

    // Render table header
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

    // Render table body with data
    function renderResults(data, tableName) {
        const headers = tableHeaders[tableName];
        tbody.innerHTML = "";
        data.forEach((row, idx) => {
            const tr = document.createElement("tr");
            headers.forEach(h => {
                const td = document.createElement("td");
                if (h.key === "No" && (row[h.key] == null || row[h.key] === "")) {
                    td.textContent = idx + 1;
                } else {
                    td.textContent = row[h.key] ?? "-";
                }
                tr.appendChild(td);
            });
            tbody.appendChild(tr);
        });
    }

    // Fetch and parse JSON data
    async function fetchData(params, tableName) {
        renderTableHeader(tableName);
        tbody.innerHTML = `<tr><td colspan="${tableHeaders[tableName].length}">LOADING...</td></tr>`;
        infoText.textContent = `Loading data for "${tableName}"...`;

        try {
            const resp = await fetch("http://localhost:8080/ServerletFinal_war_exploded/data", {
                method:      "POST",
                credentials: "include",
                headers:     { "Content-Type": "application/x-www-form-urlencoded" },
                body:        params.toString()
            });

            const data = await resp.json();

            // Handle backend custom errors
            if (data.ferror) {
                tbody.innerHTML = `<tr><td colspan="${tableHeaders[tableName].length}" style="color:red;">
          ${data.ferror}
        </td></tr>`;
                infoText.textContent = data.ferror;
                return;
            }
            if (data.error) {
                tbody.innerHTML = `<tr><td colspan="${tableHeaders[tableName].length}" style="color:red;">
          ${data.error}
        </td></tr>`;
                infoText.textContent = data.error;
                return;
            }

            // Validate data format
            if (!Array.isArray(data)) {
                tbody.innerHTML = `<tr><td colspan="${tableHeaders[tableName].length}" style="color:red;">
          Unexpected response format.
        </td></tr>`;
                infoText.textContent = "Unexpected response format.";
                return;
            }

            // Render data normally
            renderResults(data, tableName);
            infoText.textContent = tableDescriptions[tableName] || "Data loaded.";
        } catch (err) {
            console.error("Loading failed:", err);
            tbody.innerHTML = `<tr><td colspan="${tableHeaders[tableName].length}" style="color:red;">
        Loading failed: ${err.message}
      </td></tr>`;
            infoText.textContent = "Loading failed, please check your network or backend response.";
        }
    }

    // Switch table buttons
    buttons.forEach(btn => {
        btn.addEventListener("click", () => {
            buttons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            currentTable = btn.dataset.page;
            const params = new URLSearchParams();
            params.append("type", "readSQL");
            params.append("table", currentTable);
            fetchData(params, currentTable);
        });
    });

    // Search functionality
    searchBtn?.addEventListener("click", e => {
        e.preventDefault();
        const val = searchInput.value.trim();
        if (!val) {
            alert("Please enter a phone No. or model.");
            return;
        }
        const params = new URLSearchParams();
        params.append("type", "readSQL");
        params.append("table", "smartphones");
        if (/^\d+$/.test(val)) {
            params.append("phoneNo", val);
        } else {
            params.append("model", val);
        }
        buttons.forEach(b => b.classList.remove("active"));
        document.querySelector('[data-page="smartphones"]').classList.add("active");
        currentTable = "smartphones";
        fetchData(params, currentTable);
    });

    // Range filtering
    rangeFilters.forEach(btn => {
        btn.addEventListener("click", e => {
            e.preventDefault();
            const div   = btn.closest(".range-filter");
            const field = div.dataset.field;
            const min   = div.querySelector(".min").value;
            const max   = div.querySelector(".max").value;

            const params = new URLSearchParams();
            params.append("type", "readSQL");
            params.append("table", "smartphones");

            if (field === "price") {
                if (min) params.append("key", "price_USD>="), params.append("value", min);
                if (max) params.append("key", "price_USD<="), params.append("value", max);
            } else if (field === "battery") {
                if (min) params.append("key", "Battery_Capacity>="), params.append("value", min);
                if (max) params.append("key", "Battery_Capacity<="), params.append("value", max);
            }

            const m = modelFilter.value.trim();
            if (m) {
                params.append("key", "model");
                params.append("value", m);
            }

            buttons.forEach(b => b.classList.remove("active"));
            document.querySelector('[data-page="smartphones"]').classList.add("active");
            currentTable = "smartphones";
            fetchData(params, currentTable);
        });
    });

    // Initial data fetch
    const initParams = new URLSearchParams();
    initParams.append("type", "readSQL");
    initParams.append("table", currentTable);
    fetchData(initParams, currentTable);
});
