/**
 * compare.js - 处理手机比较页面的初始化和事件绑定
 */
document.addEventListener('DOMContentLoaded', function() {
    // 如果 updateSelectors 函数存在，就调用它
    if (typeof updateSelectors === 'function') {
        updateSelectors();
    }
    
    // 标记可交互的表格行
    const interactiveRows = document.querySelectorAll('.compare-table tr[data-action]');
    interactiveRows.forEach(row => {
        row.classList.add('interactive');
    });
    
    // 绑定打印按钮事件
    const printBtn = document.getElementById('print-btn');
    if (printBtn) {
        printBtn.addEventListener('click', function() {
            window.print();
        });
    }
    
    // 绑定分享按钮事件
    const shareBtn = document.getElementById('share-btn');
    if (shareBtn) {
        shareBtn.addEventListener('click', function() {
            // 获取当前URL用于分享
            const shareUrl = window.location.href;
            
            // 检查是否支持分享API
            if (navigator.share) {
                navigator.share({
                    title: '手机对比结果',
                    text: '查看这些手机型号的对比结果',
                    url: shareUrl
                })
                .catch(err => {
                    console.error('分享失败:', err);
                    // 如果分享API失败，回退到复制链接
                    copyToClipboard(shareUrl);
                });
            } else {
                // 不支持分享API时复制链接到剪贴板
                copyToClipboard(shareUrl);
            }
        });
    }
    
    // 绑定收藏按钮事件
    const favBtn = document.getElementById('add-to-favorites');
    if (favBtn) {
        favBtn.addEventListener('click', function() {
            // 这里将来可以实现保存到用户的收藏列表中
            alert('该功能即将上线，敬请期待！');
        });
    }
    
    // 辅助函数：复制文本到剪贴板
    function copyToClipboard(text) {
        // 创建一个临时的textarea元素
        const textarea = document.createElement('textarea');
        textarea.value = text;
        document.body.appendChild(textarea);
        textarea.select();
        
        try {
            // 执行复制命令
            document.execCommand('copy');
            alert('链接已复制到剪贴板！');
        } catch (err) {
            console.error('复制失败:', err);
            alert('复制链接失败，请手动复制: ' + text);
        }
        
        // 清理DOM
        document.body.removeChild(textarea);
    }
});
