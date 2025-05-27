// src/main/webapp/assets/js/profile.js  — Login.js style, all English

console.log('🔄 profile.js loaded');

/*
 * Fixed backend root URL (direct, per user requirement).
 * For dynamic usage, you could inject via <meta data-base-url> or backend template.
 */
const BASE_URL = 'http://localhost:8080/ServerletFinal_war_exploded';
// User ID can be injected by backend session or data- attribute; fallback to 'u1' here
const USER_ID  = document.body.dataset.userId || 'u1';

/** Main entry when DOM is ready */
document.addEventListener('DOMContentLoaded', () => {
    console.log('✨ DOMContentLoaded – USER_ID =', USER_ID);

    // —— Key DOM elements ——
    const nameEl      = document.getElementById('userName');
    const emailEl     = document.getElementById('email');
    const dateEl      = document.getElementById('registerDate');
    const deviceEl    = document.getElementById('deviceName');   // optional
    const postsList   = document.getElementById('postsList');
    const commentsList= document.getElementById('commentsList');

    if (!postsList || !commentsList) {
        console.error('⚠️ Missing #postsList or #commentsList element, aborting profile.js');
        return;
    }

    /* --------------------------------------------------
     * Load three sections: User / Posts / Comments
     * On failure, log error and display empty state.
     * -------------------------------------------------- */

    loadSection('users',   handleUser,   []);
    loadSection('posts',   arr => renderList(arr, postsList, renderPostItem, 'No posts yet'));
    loadSection('comments',arr => renderList(arr, commentsList, renderCommentItem, 'No comments yet'));

    /* ---------------- Internal Functions ---------------- */

    /** General loader for each section */
    function loadSection(table, onSuccess, fallback = []) {
        const url = `${BASE_URL}/data?type=readSQL&table=${table}&userID=${encodeURIComponent(USER_ID)}`;
        console.log(`🌐 Fetching ${table} →`, url);

        fetch(url, { credentials: 'include' })
            .then(res => {
                console.log(`📶 ${table} response:`, res.status, res.statusText);
                if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
                return res.json();
            })
            .then(json => {
                console.log(`✅ ${table} data:`, json);
                onSuccess(json);
            })
            .catch(err => {
                console.error(`🔥 Failed to load ${table}:`, err);
                onSuccess(fallback);
            });
    }

    /** Render user info section */
    function handleUser(res) {
        const u = Array.isArray(res) ? res[0] : res || {};
        safeText(nameEl,   u.username   ?? 'Unknown');
        safeText(emailEl,  u.email      ?? '—');
        safeText(dateEl,   fmtDate(u.registerDate));
        if (deviceEl) safeText(deviceEl, u.deviceName ?? '—');
    }

    /** Generic list renderer */
    function renderList(arr, wrapper, itemRenderer, emptyLabel) {
        if (!wrapper) return;
        if (!Array.isArray(arr) || arr.length === 0) {
            wrapper.innerHTML = `<li class="activity-item">— ${emptyLabel} —</li>`;
            return;
        }
        wrapper.innerHTML = arr.map(itemRenderer).join('');
    }

    /** Render a single post */
    function renderPostItem(p) {
        return `<li class="activity-item">
      <a href="post.jsp?pid=${p.id ?? ''}" target="_blank">${escapeHTML(p.title ?? 'Untitled')}</a>
      <span class="activity-date">${fmtDate(p.createdAt)}</span>
      <span>👁 ${p.views ?? 0} ・ 💬 ${p.replies ?? 0}</span>
    </li>`;
    }

    /** Render a single comment */
    function renderCommentItem(c) {
        return `<li class="activity-item">
      <a href="post.jsp?pid=${c.postId ?? ''}" target="_blank">Post: ${escapeHTML(c.postTitle ?? 'Untitled')}</a>
      <p>${escapeHTML(c.content ?? '')}</p>
      <span class="activity-date">${fmtDate(c.createdAt)}</span>
    </li>`;
    }

    /* ---------------- Utils ---------------- */
    function safeText(el, txt) { if (el) el.textContent = txt; }

    function fmtDate(iso) {
        if (!iso) return '—';
        const d = new Date(iso);
        return isNaN(d) ? iso : d.toLocaleDateString() + ' ' + d.toLocaleTimeString([], {hour:'2-digit',minute:'2-digit'});
    }

    function escapeHTML(str = '') {
        return str.replace(/[&<>"']/g, ch => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;', '\'':'&#39;'}[ch]));
    }
});
