// delete_smartphone.js
document.addEventListener("click", async (e) => {
    const btn = e.target;
    if (!btn.matches(".delete-btn")) return;

    const form = btn.closest("form.console-form");
    if (form) {
        e.preventDefault();
        const postUrl = form.action;  // -- 直接用 action --
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
                alert("✅ 删除成功！");
                btn.closest("tr")?.remove();
            } else {
                alert("⚠️ 删除失败：" + (result.message || "未知错误"));
            }
        } catch (err) {
            alert("❌ 网络或服务器错误：" + err.message);
        }
    }
});
