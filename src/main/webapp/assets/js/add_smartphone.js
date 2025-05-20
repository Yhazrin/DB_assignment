document.addEventListener("submit", async (e) => {
    const form = e.target;
    if (!form.matches("form.console-form")) return; // 只处理目标表单

    e.preventDefault();

    // 直接拿 action 作为URL，参数放body即可
    const postUrl = form.getAttribute("action");
    const formData = new FormData(form);

    // 保证 POST 参数全在 bodyParams，url不用再拼参数
    const bodyParams = new URLSearchParams(formData);

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
            alert("✅ 成功！");
            setTimeout(() => {
                // 跳转到 overview.jsp。路径根据实际调整
                window.location.href = "overview.jsp";
            }, 800);
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
