// form.js
(() => {
    // 1. 字段定义
    const fields = [
        { name: 'model',            label: 'Model',            type: 'text',   required: true },
        { name: 'brand',            label: 'Brand',            type: 'text',   required: true },
        { name: 'price_USD',        label: 'Price (USD)',      type: 'number', required: true, step: '0.01' },
        { name: 'sim',              label: 'SIM',              type: 'text',   required: true },
        { name: 'processor_name',   label: 'Processor',        type: 'text',   required: true },
        { name: 'ram',              label: 'RAM',              type: 'text',   required: true },
        { name: 'Battery_Capacity', label: 'Battery Capacity', type: 'text',   required: true },
        { name: 'Charging_Info',    label: 'Charging Info',    type: 'text',   required: true },
        { name: 'Rear_Camera',      label: 'Rear Camera',      type: 'text',   required: true },
        { name: 'Front_Camera',     label: 'Front Camera',     type: 'text',   required: true },
        { name: 'card',             label: 'Card Slot',        type: 'text',   required: true },
        { name: 'os',               label: 'OS',               type: 'text',   required: true }
    ];

    document.addEventListener('DOMContentLoaded', () => {
        // 从 JSP 注入的全局变量里取 contextPath
        const ctx = window.CONTEXT_PATH || '';

        // 绑定上方三个按钮
        const modes = ['add','delete','update'];
        document.querySelectorAll('.console-btn').forEach((btn,i) => {
            btn.addEventListener('click', () => createSmartphoneForm(modes[i], ctx));
        });

        // 默认进页面先展示“add”表单
        createSmartphoneForm('add', ctx);
    });

    /**
     * 根据 mode 动态生成表单
     * @param {'add'|'delete'|'update'} mode
     * @param {string} ctx   contextPath
     */
    function createSmartphoneForm(mode, ctx) {
        const container = document.getElementById('formContainer');
        container.innerHTML = '';

        const form = document.createElement('form');
        form.className = 'console-form';
        form.method    = 'post';
        // **务必** 确保写对 "smartphones"
        form.action    = `${ctx}/data?type=modifySQL&table=smartphones&action=${mode}`;

        // delete 模式只要 model，否则渲染全部字段
        const toRender = mode==='delete'
            ? fields.filter(f=>f.name==='model')
            : fields;

        toRender.forEach(f=>{
            const wrap = document.createElement('div');
            wrap.className = 'form-group';
            wrap.innerHTML = `
        <label for="${f.name}">${f.label}</label>
        <input
          type="${f.type}"
          id="${f.name}"
          name="${f.name}"
          ${f.required?'required':''}
          ${f.step?`step="${f.step}"`:''}
        />
      `;
            form.appendChild(wrap);
        });

        // 按钮
        const footer = document.createElement('div');
        footer.className = 'form-actions';
        footer.innerHTML = `
      <button type="submit" class="btn color-btn">
        ${mode==='add'?'Add Smartphone':mode==='delete'?'Delete Smartphone':'Change Smartphone'}
      </button>
      <button type="reset" class="btn color-btn">Reset</button>
    `;
        form.appendChild(footer);

        container.appendChild(form);
    }
})();
