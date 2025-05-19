document.addEventListener('DOMContentLoaded', function() {
    document.body.addEventListener("pointermove", (e) => {
        const { currentTarget: el, clientX: x, clientY: y } = e;
        const { top: t, left: l, width: w, height: h } = el.getBoundingClientRect();
        el.style.setProperty('--posX', x - l - w / 2 + 'px');
        el.style.setProperty('--posY', y - t - h / 2 + 'px');
    });
});
