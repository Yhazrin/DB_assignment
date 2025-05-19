document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    // 带固定参数的基础完整 URL
    const fixedBaseUrl = 'http://localhost:8080/ServerletFinal_war_exploded/data?type=modifySQL&table=smartphones';

    function buildFullUrl() {
        const formData = new FormData(form);

        // 利用 URL 对象方便操作查询参数
        const url = new URL(fixedBaseUrl);

        // 遍历表单参数，排除重复的 type 和 table，追加到查询参数中
        for (const [key, value] of formData.entries()) {
            if (key !== 'type' && key !== 'table') {
                url.searchParams.append(key, value);
            }
        }

        // 返回最终 URL 字符串
        return url.toString();
    }

    form.addEventListener("submit", async (e) => {
        e.preventDefault();

        const fullUrl = buildFullUrl();

        const formData = new FormData(form);
        const bodyParams = new URLSearchParams(formData);

        try {
            const resp = await fetch(fullUrl, {
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
                    window.location.href = `${form.dataset.contextPath}/assets/page/overview.jsp`;
                }, 800);
            } else if (result.result === "fail") {
                alert("⚠️ 添加失败：" + result.message);
            } else if (result.error) {
                alert("❌ 错误：" + result.error);
            } else {
                alert("❓ 未知响应：" + JSON.stringify(result));
            }
        } catch (err) {
            alert("❌ 网络或服务器错误：" + err.message);
        }
    });
});
