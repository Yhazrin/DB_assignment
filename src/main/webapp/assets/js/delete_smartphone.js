// delete_smartphone.js
document.addEventListener("click", async (e) => {
    const btn = e.target;
    if (!btn.matches(".delete-btn")) return;

    const form = btn.closest("form.console-form");
    if (form) {
        e.preventDefault();
        const postUrl = form.action;
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
                alert("✅ Delete success！");
                btn.closest("tr")?.remove();
            } else {
                alert("⚠️ delete failed: " + (result.message || "unknown error"));
            }
        } catch (err) {
            alert("❌ Network error: " + err.message);
        }
    }
});
