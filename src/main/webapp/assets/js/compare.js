document.addEventListener("DOMContentLoaded", function() {
    // Define the fields for the spec comparison
    const specFields = [
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
    ];

    let comparePhones = [];

    function renderCompareTable() {
        const container = document.getElementById("compareResult");
        if (!container) {
            console.error("[Table] Cannot find #compareResult!");
            return;
        }
        if (comparePhones.length === 0) {
            container.innerHTML = `<div style="color:#888;text-align:center;margin:24px 0;">No phones compared yet.</div>`;
            console.log("[Table] No data: comparePhones is empty");
            return;
        }

        let html = `<table class="compare-table"><tr><th>Spec</th>`;

        comparePhones.forEach(phone => {
            let phoneBrand = phone.brand !== undefined && phone.brand !== null ? phone.brand : "";
            let phoneModel = phone.model !== undefined && phone.model !== null ? phone.model : "";
            let phoneNo = phone.No !== undefined && phone.No !== null ? phone.No : "-";

            html += `<th>${phoneBrand} ${phoneModel}<br>No.${phoneNo}</th>`;
        });

        html += `</tr>`;


        html += `</tr>`;

        for (let rowIdx = 0; rowIdx < specFields.length; rowIdx++) {
            let f = specFields[rowIdx];
            html += `<tr><td class="spec-label">${f.label}</td>`;
            for (let colIdx = 0; colIdx < comparePhones.length; colIdx++) {
                let phone = comparePhones[colIdx];
                let value = phone[f.key] ?? "-";
                html += `<td class="phone-info">${value}</td>`;
                // CLEAR, guaranteed debug:
                console.log(`[DEBUG] Table: row=${rowIdx} col=${colIdx} key=${f.key} value=`, value);
            }
            html += `</tr>`;
        }
        html += `</table>`;

        container.innerHTML = html;
        console.log("[Table] Rendered with", comparePhones.length, "phone(s)");
    }

    // Bind Search button
    document.getElementById("searchNoBtn").onclick = function() {
        const input = document.getElementById("searchNoInput");
        const no = input.value.trim();
        if (!no) {
            alert("Please enter a phone No.");
            return;
        }
        // Prevent duplicate
        if (comparePhones.some(ph => String(ph.No) === String(no))) {
            alert("Already in compare list!");
            return;
        }
        const url = `http://localhost:8080/ServerletFinal_war_exploded/data?type=readSQL&table=smartphones&phoneNo=${encodeURIComponent(no)}`;
        console.log("[Fetch] GET", url);
        fetch(url)
            .then(res => res.json())
            .then(data => {
                console.log("[Fetch] Response:", data);
                if (!Array.isArray(data) || data.length === 0) {
                    alert("No phone found with No = " + no);
                    return;
                }
                comparePhones.push(data[0]);
                renderCompareTable();
                input.value = "";
            })
            .catch(err => {
                alert("Error fetching data: " + err);
                console.error(err);
            });
    };

    // Bind Reset button
    document.getElementById("resetBtn").onclick = function() {
        comparePhones = [];
        renderCompareTable();
    };

    // Initial render
    renderCompareTable();
});