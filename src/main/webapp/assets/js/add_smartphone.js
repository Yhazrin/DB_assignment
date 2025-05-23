// add_smartphone.js
document.addEventListener("submit", async (e) => {
    const form = e.target;
    if (!form.matches("form.console-form")) return;

    e.preventDefault();

    // 直接用 JSP 里写好的 action
    const postUrl = form.action;

    // 把表单数据收集到 body
    const bodyParams = new URLSearchParams(new FormData(form));

    try {
        const resp = await fetch(postUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: bodyParams.toString()
        });

        if (!resp.ok) {
            alert(`❌ 提交失败，状态码：${resp.status}`);
            return;
        }
        const result = await resp.json();

        if (result.result === "success") {
            alert("✅ 添加成功！");
            setTimeout(() => {
                // 跳回 overview.jsp
                window.location.href = `${window.CONTEXT_PATH}/assets/page/overview.jsp`;
            }, 800);
        } else {
            alert("⚠️ 添加失败：" + (result.message || "未知错误"));
        }
    } catch (err) {
        alert("❌ 网络或服务器错误：" + err.message);
    }
});
