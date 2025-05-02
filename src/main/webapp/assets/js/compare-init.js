// compare-init.js
// 路径: webapp/assets/js/compare-init.js

document.addEventListener('DOMContentLoaded', function() {
    const numSelect    = document.getElementById('numModels');
    const selectorsDiv = document.getElementById('deviceSelectors');
    const compareBtn   = document.getElementById('compare-btn');
    const resetBtn     = document.getElementById('reset-btn');

    /**
     * 根据URL参数预填已选ID
     */
    function getSelectedIds() {
        const params = new URLSearchParams(window.location.search);
        return params.getAll('id');
    }

    /**
     * 生成并插入选择器
     */
    function updateSelectors() {
        const count = parseInt(numSelect.value, 10) || 3;
        selectorsDiv.innerHTML = '';
        selectorsDiv.style.display = 'flex';
        selectorsDiv.style.gap = 'var(--spacing-md)';

        for (let i = 0; i < count; i++) {
            const container = document.createElement('div');
            container.className = 'model-selector';

            const input = document.createElement('input');
            input.type = 'text';
            input.id = `modelInput${i}`;             // 添加 id
            input.name = `modelInput${i}`;           // 添加 name，防止 autofill 警告
            input.className = 'model-input';
            input.placeholder = `输入手机型号 #${i + 1}`;
            input.type = 'text';
            input.className = 'model-input';
            input.placeholder = `输入手机型号 #${i + 1}`;

            const hidden = document.createElement('input');
            hidden.type = 'hidden';
            hidden.name = 'id';
            hidden.className = 'selected-id';

            const resultsDiv = document.createElement('div');
            resultsDiv.className = 'search-results';

            // 根据关键词过滤并显示结果
            function showResults(term) {
                resultsDiv.innerHTML = '';
                
                // 1. 空搜索词时显示全部结果
                if (!term) {
                    // 显示所有手机数据，最多显示10个以防列表太长
                    const limitedData = allPhoneData.slice(0, 10);
                    if (limitedData.length > 0) {
                        limitedData.forEach(p => {
                            const item = document.createElement('div');
                            item.className = 'search-result-item';
                            item.textContent = `${p.brand} ${p.name}`;
                            item.addEventListener('click', () => selectItem(p, input, hidden, resultsDiv, container));
                            resultsDiv.appendChild(item);
                        });
                    } else {
                        resultsDiv.innerHTML = '<div class="no-results">没有可用的手机数据</div>';
                        console.error('allPhoneData 为空或未定义', allPhoneData);
                    }
                } else {
                    // 2. 放宽搜索标准：使用分词搜索
                    const searchTerms = term.toLowerCase().split(/\s+/);
                    
                    // 只要匹配任意一个词就显示结果
                    const matches = allPhoneData.filter(p => {
                        const fullText = `${p.brand} ${p.name}`.toLowerCase();
                        return searchTerms.some(term => fullText.includes(term));
                    });
                    
                    if (matches.length === 0) {
                        // 进一步放宽：搜索单个字符匹配
                        const looseMatches = allPhoneData.filter(p => {
                            const fullText = `${p.brand} ${p.name}`.toLowerCase();
                            return term.split('').some(char => fullText.includes(char));
                        }).slice(0, 10); // 限制结果数量
                        
                        if (looseMatches.length > 0) {
                            resultsDiv.innerHTML = '<div class="loose-match-notice">未找到精确匹配，显示相关结果：</div>';
                            looseMatches.forEach(p => {
                                const item = document.createElement('div');
                                item.className = 'search-result-item';
                                item.textContent = `${p.brand} ${p.name}`;
                                item.addEventListener('click', () => selectItem(p, input, hidden, resultsDiv, container));
                                resultsDiv.appendChild(item);
                            });
                        } else {
                            resultsDiv.innerHTML = '<div class="no-results">未找到匹配结果</div>';
                        }
                    } else {
                        matches.forEach(p => {
                            const item = document.createElement('div');
                            item.className = 'search-result-item';
                            item.textContent = `${p.brand} ${p.name}`;
                            item.addEventListener('click', () => selectItem(p, input, hidden, resultsDiv, container));
                            resultsDiv.appendChild(item);
                        });
                    }
                }
                
                // 3. 确保搜索结果可见
                resultsDiv.classList.add('show');
                
                // 4. 检查数据是否正确加载
                if (!allPhoneData || allPhoneData.length === 0) {
                    console.error('allPhoneData为空或未定义，请检查数据加载');
                    resultsDiv.innerHTML = '<div class="error">数据加载错误，请刷新页面</div>';
                }
            }

            // 选择条目
            function selectItem(p, inputEl, hiddenEl, resultsEl, wrap) {
                hiddenEl.value = p.id;
                inputEl.value = `${p.brand} ${p.name}`;
                resultsEl.classList.remove('show');
                // 在container底部插入已选择视图
                let selectedDiv = wrap.querySelector('.selected-model');
                if (!selectedDiv) {
                    selectedDiv = document.createElement('div');
                    selectedDiv.className = 'selected-model';
                    wrap.appendChild(selectedDiv);
                }
                selectedDiv.innerHTML = `<span>${p.brand} ${p.name}</span><span class=\"remove-btn\">&times;</span>`;
                selectedDiv.querySelector('.remove-btn').addEventListener('click', e => {
                    e.stopPropagation();
                    hiddenEl.value = '';
                    selectedDiv.remove();
                    inputEl.style.display = 'block';
                    inputEl.value = '';
                });
                inputEl.style.display = 'none';
            }

            // 输入和聚焦事件
            input.addEventListener('input', e => {
                const term = e.target.value.trim().toLowerCase();
                if (!term) {
                    resultsDiv.classList.remove('show');
                    return;
                }
                showResults(term);
            });

            // 聚焦时显示全部项
            input.addEventListener('focus', () => {
                // 始终显示所有选项
                showResults('');
            });

            // 点击外部关闭下拉
            document.addEventListener('click', e => {
                if (!container.contains(e.target)) {
                    resultsDiv.classList.remove('show');
                }
            });

            container.appendChild(input);
            container.appendChild(hidden);
            container.appendChild(resultsDiv);
            selectorsDiv.appendChild(container);
        }

        // 预填已选
        populateFromUrl();
    }

    /**
     * 根据 URL 参数自动填充已选手机
     */
    function populateFromUrl() {
        const ids = getSelectedIds();
        const containers = document.querySelectorAll('.model-selector');
        ids.forEach((id, idx) => {
            if (idx < containers.length) {
                const p = allPhoneData.find(x => String(x.id) === id);
                if (p) {
                    const wrap = containers[idx];
                    const input = wrap.querySelector('.model-input');
                    const hidden = wrap.querySelector('.selected-id');
                    const results = wrap.querySelector('.search-results');
                    selectItem(p, input, hidden, results, wrap);
                }
            }
        });
    }

    // 点击“开始对比”
    compareBtn.addEventListener('click', () => {
        const ids = Array.from(document.querySelectorAll('.selected-id'))
            .map(i => i.value).filter(Boolean);
        if (ids.length === 0) {
            alert('请至少选择一款手机进行对比');
            return;
        }
        const url = new URL(window.location.pathname, window.location.origin);
        ids.forEach(id => url.searchParams.append('id', id));
        window.location.href = url.toString();
    });

    // 点击“重置”
    resetBtn.addEventListener('click', () => {
        window.location.href = window.location.pathname;
    });

    // 初次执行
    updateSelectors();
    numSelect.addEventListener('change', updateSelectors);
});