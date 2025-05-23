// src/main/webapp/assets/js/delete_smartphone.js

document.addEventListener("click", async (e) => {
    const btn = e.target;
    if (!btn.matches(".delete-btn")) return;

    const form = btn.closest("form.console-form");
    if (form) {
        e.preventDefault();
        const postUrl = form.action;  // Use form action URL
        const bodyParams = new URLSearchParams(new FormData(form));

        try {
            const resp = await fetch(postUrl, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: bodyParams.toString()
            });
            const result = await resp.json();

            if (result.result === "success") {
                alert("✅ Deletion successful!");
                btn.closest("tr")?.remove();
            } else {
                alert("⚠️ Deletion failed: " + (result.message || "Unknown error"));
            }
        } catch (err) {
            alert("❌ Network or server error: " + err.message);
        }
    }
});
