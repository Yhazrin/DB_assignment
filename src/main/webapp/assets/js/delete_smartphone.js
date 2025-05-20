document.addEventListener("click", async (e) => {
    const btn = e.target;
    if (!btn.matches(".delete-btn")) return; // 只处理具有 delete-btn 类的按钮

    const model = btn.getAttribute("data-model");
    if (!model) {
        alert("❌ 未指定要删除的手机型号！");
        return;
    }

    if (!confirm(`确认要删除型号为 "${model}" 的手机吗？`)) {
        return;
    }

    const url = new URL("/DB_assignment_war_exploded/console", window.location.origin);
    url.searchParams.append("table", "smartphones");
    url.searchParams.append("type", "console");

    const bodyParams = new URLSearchParams();
    bodyParams.append("action", "delete");
    bodyParams.append("model", model);

    try {
        const resp = await fetch(url.toString(), {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: bodyParams.toString()
        });

        const result = await resp.json();

        if (result.result === "success") {
            alert("✅ 成功！");
            // 可选：从 DOM 中移除被删除的行
            const row = btn.closest("tr");
            if (row) row.remove();
        } else if (result.result === "fail") {
            alert("⚠️ 失败：" + result.message);
        } else if (result.error) {
            alert("❌ 错误：" + result.error);
        } else {
            alert("❓ 未知响应：" + JSON.stringify(result));
        }
    } catch (err) {
        alert("❌ 网络或服务器错误：" + err.message);
    }
});
