document.addEventListener("submit", async (e) => {
    const form = e.target;
    if (!form.matches("form.console-form")) return; // 只处理目标表单

    e.preventDefault();

    const fixedBaseUrl = form.getAttribute("action");
    const formData = new FormData(form);

    const url = new URL(fixedBaseUrl);
    for (const [key, value] of formData.entries()) {
        if (key !== 'type' && key !== 'table') {
            url.searchParams.append(key, value);
        }
    }

    const bodyParams = new URLSearchParams(formData);

    try {
        const resp = await fetch(url.toString(), {
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
                window.location.href =
                    'http://localhost:8081/DB_assignment_war_exploded/assets/page/overview.jsp';
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

