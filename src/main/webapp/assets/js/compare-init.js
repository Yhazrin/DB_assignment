// compare-init.js
// Path: webapp/assets/js/compare-init.js

document.addEventListener('DOMContentLoaded', function() {
    const ctx = window.__ctx || '';
    const numSelect = document.getElementById('numModels');
    const selectorsDiv = document.getElementById('deviceSelectors');
    const compareBtn = document.getElementById('compare-btn');
    const resetBtn = document.getElementById('reset-btn');

    // Load phone data from server JSON API
    async function loadPhoneData() {
        const res = await fetch(`${ctx}/compare?json=true`);
        if (!res.ok) {
            throw new Error(`HTTP error! status: ${res.status}`);
        }
        return await res.json();
    }

    // Initialize selectors and event handlers with loaded data
    function initialize(allPhoneData) {
        // Get selected ids from URL parameters
        function getSelectedIds() {
            const params = new URLSearchParams(window.location.search);
            return params.getAll('id');
        }

        // Handle selecting an item
        function selectItem(p, inputEl, hiddenEl, resultsEl, wrap) {
            hiddenEl.value = p.id;
            inputEl.value = `${p.brand} ${p.name}`;
            resultsEl.classList.remove('show');

            let selectedDiv = wrap.querySelector('.selected-model');
            if (!selectedDiv) {
                selectedDiv = document.createElement('div');
                selectedDiv.className = 'selected-model';
                wrap.appendChild(selectedDiv);
            }
            selectedDiv.innerHTML = `<span>${p.brand} ${p.name}</span><span class="remove-btn">&times;</span>`;
            selectedDiv.querySelector('.remove-btn').addEventListener('click', e => {
                e.stopPropagation();
                hiddenEl.value = '';
                selectedDiv.remove();
                inputEl.style.display = 'block';
                inputEl.value = '';
            });
            inputEl.style.display = 'none';
        }

        // Show search results
        function showResults(term, input, hidden, resultsDiv, container) {
            resultsDiv.innerHTML = '';
            const items = [];
            if (!term) {
                items.push(...allPhoneData.slice(0, 10));
            } else {
                const searchTerms = term.toLowerCase().split(/\s+/);
                let matches = allPhoneData.filter(p =>
                    searchTerms.some(t => `${p.brand} ${p.name}`.toLowerCase().includes(t))
                );
                if (matches.length === 0) {
                    matches = allPhoneData.filter(p =>
                        term.split('').some(ch => `${p.brand} ${p.name}`.toLowerCase().includes(ch))
                    ).slice(0, 10);
                    if (matches.length > 0) {
                        resultsDiv.innerHTML = '<div class="loose-match-notice">No exact matches found, showing related results:</div>';
                    }
                }
                items.push(...matches);
            }

            if (items.length === 0) {
                resultsDiv.innerHTML = `<div class="no-results">${term ? 'No matching results found' : 'No phone data available'}</div>`;
            } else {
                items.forEach(p => {
                    const item = document.createElement('div');
                    item.className = 'search-result-item';
                    item.textContent = `${p.brand} ${p.name}`;
                    item.addEventListener('click', () => selectItem(p, input, hidden, resultsDiv, container));
                    resultsDiv.appendChild(item);
                });
            }

            resultsDiv.classList.add('show');
        }

        // Generate selectors
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
                input.id = `modelInput${i}`;
                input.name = `modelInput${i}`;
                input.className = 'model-input';
                input.placeholder = `Enter phone model #${i + 1}`;

                const hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'id';
                hidden.className = 'selected-id';

                const resultsDiv = document.createElement('div');
                resultsDiv.className = 'search-results';

                // Events
                input.addEventListener('input', () => {
                    const term = input.value.trim();
                    if (!term) {
                        resultsDiv.classList.remove('show');
                        return;
                    }
                    showResults(term, input, hidden, resultsDiv, container);
                });

                input.addEventListener('focus', () => showResults('', input, hidden, resultsDiv, container));

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

            populateFromUrl();
        }

        // Pre-fill from URL
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

        // Compare action
        compareBtn.addEventListener('click', () => {
            const ids = Array.from(document.querySelectorAll('.selected-id'))
                .map(i => i.value).filter(Boolean);
            if (ids.length === 0) {
                alert('Please select at least one phone to compare');
                return;
            }
            const url = new URL(window.location.pathname, window.location.origin);
            ids.forEach(id => url.searchParams.append('id', id));
            window.location.href = url.toString();
        });

        // Reset action
        resetBtn.addEventListener('click', () => {
            window.location.href = window.location.pathname;
        });

        updateSelectors();
        numSelect.addEventListener('change', updateSelectors);
    }

    // Load data and initialize
    loadPhoneData()
        .then(initialize)
        .catch(err => {
            console.error('加载数据失败：', err);
            document.getElementById('compareResults')
                .innerHTML = '<div class="error">Data load error, please refresh the page</div>';
        });
});
