<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Compare Models - Mobile Phone InfoHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/theme-toggle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/compare.css">

    <jsp:include page="sub/header.jsp"/>

</head>
<body>
<div class="container">
    <h1>Compare Mobile Models</h1>
    <div class="controls">
        <label for="numModels">Number of Devices:</label>
        <select id="numModels">
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
        </select>
    </div>
    <div class="selectors" id="deviceSelectors"></div>
    <datalist id="modelList">
        <option value="iPhone 13 Pro">
        <option value="Samsung Galaxy S22">
        <option value="Google Pixel 6">
        <option value="OnePlus 10 Pro">
        <option value="Huawei P50">
    </datalist>
    <div id="specContainer"></div>
</div>
<footer>&copy; 2025 Mobile Phone InfoHub</footer>
<script>
    const specs = [
        { name: 'Display', key: 'display' },
        { name: 'Processor', key: 'processor' },
        { name: 'RAM', key: 'ram' },
        { name: 'Battery', key: 'battery' }
    ];
    const data = {
        'iPhone 13 Pro': { display: '6.1" OLED', processor: 'A15 Bionic', ram: '6 GB', battery: '3095 mAh' },
        'Samsung Galaxy S22': { display: '6.2" AMOLED', processor: 'Snapdragon 8 Gen 1', ram: '8 GB', battery: '3700 mAh' },
        'Google Pixel 6': { display: '6.4" AMOLED', processor: 'Google Tensor', ram: '8 GB', battery: '4614 mAh' },
        'OnePlus 10 Pro': { display: '6.7" Fluid AMOLED', processor: 'Snapdragon 8 Gen 1', ram: '12 GB', battery: '5000 mAh' },
        'Huawei P50': { display: '6.5" OLED', processor: 'Kirin 9000', ram: '8 GB', battery: '4100 mAh' }
    };
    const numSelect = document.getElementById('numModels');
    const selectorsDiv = document.getElementById('deviceSelectors');
    const specContainer = document.getElementById('specContainer');

    function updateSelectors() {
        const count = +numSelect.value;
        selectorsDiv.innerHTML = '';
        for (let i = 0; i < count; i++) {
            const inp = document.createElement('input');
            inp.setAttribute('list', 'modelList');
            inp.className = 'model-input';
            inp.placeholder = `Select model ${i+1}`;
            inp.addEventListener('input', renderSpecs);
            selectorsDiv.appendChild(inp);
        }
        renderSpecs();
    }

    function renderSpecs() {
        const selected = Array.from(document.querySelectorAll('.model-input'))
            .map(i => i.value)
            .filter(v => data[v]);
        specContainer.innerHTML = '';
        specs.forEach(spec => {
            const section = document.createElement('div');
            section.className = 'spec-section';
            const title = document.createElement('div');
            title.className = 'spec-title';
            title.textContent = spec.name;
            section.appendChild(title);

            const valuesDiv = document.createElement('div');
            valuesDiv.className = 'values';
            selected.forEach(model => {
                const card = document.createElement('div');
                card.className = 'value-card';
                const name = document.createElement('div');
                name.className = 'model-name';
                name.textContent = model;
                const val = document.createElement('div');
                val.className = 'model-value';
                val.textContent = data[model][spec.key];
                card.appendChild(name);
                card.appendChild(val);
                valuesDiv.appendChild(card);
            });
            section.appendChild(valuesDiv);
            specContainer.appendChild(section);
        });
    }

    numSelect.addEventListener('change', updateSelectors);
    updateSelectors();
</script>
</body>
</html>
