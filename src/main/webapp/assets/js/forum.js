// src/main/webapp/assets/js/forum.js

console.log('🔄 forum.js 加载完成');

document.addEventListener('DOMContentLoaded', () => {
    // —— Modal 相关 DOM 引用 ——（保持不变）
    const inputModal   = document.getElementById('inputModal');
    const modalHeader  = document.getElementById('modalHeader');
    const modalForm    = document.getElementById('modalForm');
    const modalCancel  = document.getElementById('modalCancel');

    function openModal(fieldList, headerText) {
        return new Promise(resolve => {
            modalHeader.textContent = headerText;
            modalForm.innerHTML = '';
            fieldList.forEach(f => {
                const lbl = document.createElement('label');
                lbl.textContent = f.label;
                const inp = f.type === 'textarea'
                    ? document.createElement('textarea')
                    : document.createElement('input');
                inp.name = f.name;
                inp.placeholder = f.placeholder || '';
                if (f.type !== 'textarea') inp.type = f.type;
                modalForm.append(lbl, inp);
            });
            inputModal.classList.remove('hidden');
            modalCancel.onclick = () => {
                inputModal.classList.add('hidden');
                resolve(null);
            };
            modalForm.onsubmit = e => {
                e.preventDefault();
                const formData = new FormData(modalForm);
                const result = {};
                fieldList.forEach(f => {
                    result[f.name] = formData.get(f.name).trim();
                });
                inputModal.classList.add('hidden');
                resolve(result);
            };
        });
    }

    const forumListEl    = document.getElementById('forumList');
    const postListEl     = document.getElementById('postList');
    const currentTitleEl = document.getElementById('currentForumTitle');
    const noPostsEl      = document.getElementById('noPosts');
    const newPostBtn     = document.getElementById('newPostBtn');
    const newForumBtn    = document.getElementById('newForumBtn');

    if (!forumListEl || !postListEl || !currentTitleEl || !noPostsEl || !newPostBtn || !newForumBtn) {
        console.error('⚠️ 缺少必须的 DOM 元素');
        return;
    }

    const BASE_URL = 'http://localhost:8080/ServerletFinal_war_exploded/data';
    let currentForumID = null;

    // —— 1. 加载所有版块 ——
    async function loadForums() {
        const url = `${BASE_URL}?type=readSQL&table=forums`;
        console.log('🌐 发起获取版块请求', url);
        try {
            const res = await fetch(url);
            const forums = await res.json();
            forumListEl.innerHTML = forums.map(f => `
                <li>
                  <a href="#" data-id="${f.forumID}">
                    ${f.title} <span class="count">(${f.postCount})</span>
                  </a>
                </li>
            `).join('');
            attachForumClicks();
        } catch (err) {
            console.error('🔥 获取版块失败：', err);
            forumListEl.innerHTML = `<li>加载版块失败，请刷新</li>`;
        }
    }

    // —— 2. 点击版块 ——
    function attachForumClicks() {
        forumListEl.querySelectorAll('a[data-id]').forEach(a => {
            a.addEventListener('click', async e => {
                e.preventDefault();
                currentForumID = a.dataset.id;
                currentTitleEl.textContent = a.textContent;
                newPostBtn.disabled = false;
                await loadPosts(currentForumID);
            });
        });
    }

    // —— 3. 加载该版块的帖子 ——
    async function loadPosts(forumID) {
        const url = `${BASE_URL}?type=readSQL&table=posts&forumID=${forumID}`;
        console.log('🌐 发起获取帖子请求', url);
        try {
            const res = await fetch(url);
            const posts = await res.json();
            if (!posts.length) {
                postListEl.innerHTML = '';
                noPostsEl.style.display = '';
            } else {
                noPostsEl.style.display = 'none';
                postListEl.innerHTML = posts.map(p => `
    <div class="topic-item interactive" data-id="${p.id}">
      <div class="topic-main">
        <h3 class="topic-title">${p.title}</h3>
        <p class="topic-content">${p.content}</p>
      </div>
      <div class="topic-actions">
        <button class="btn like-btn">👍 <span class="like-count">${p.likes||0}</span></button>
        <button class="btn comment-toggle-btn">💬 <span class="comment-count">${(p.commentID||'').split(',').filter(x=>x).length}</span></button>
      </div>
      <div class="comments-section" style="display:none">
        <div class="comments-list"></div>
        <form class="comment-form">
          <input type="text" name="comment" placeholder="写下你的评论…" required>
          <button type="submit" class="btn">发布</button>
        </form>
      </div>
    </div>
    `).join('');
                attachActionClicks();
            }
        } catch (err) {
            console.error('🔥 获取帖子失败：', err);
            postListEl.innerHTML = `<div class="message">加载帖子失败，请重试</div>`;
        }
    }

    // —— 4. 绑定点赞/评论切换/发表评论 ——
    function attachActionClicks() {
        postListEl.querySelectorAll('.topic-item').forEach(card => {
            const toggleBtn       = card.querySelector('.comment-toggle-btn');
            const commentsSection = card.querySelector('.comments-section');

            toggleBtn.addEventListener('click', async () => {
                if (commentsSection.style.display === 'none') {
                    commentsSection.style.display = 'block';
                    await loadCommentsForCard(card, card.dataset.id);
                } else {
                    commentsSection.style.display = 'none';
                }
            });

            const form = card.querySelector('.comment-form');
            form.addEventListener('submit', async e => {
                e.preventDefault();
                const text = form.comment.value.trim();
                if (!text) return;
                const url = `${BASE_URL}?type=modifySQL&table=comments`;
                const body = new URLSearchParams({
                    content: text,
                    author: '当前用户名',  // 从 Session 或全局变量取
                    postID: card.dataset.id
                }).toString();
                const res = await fetch(url, {
                    method:'POST',
                    headers:{'Content-Type':'application/x-www-form-urlencoded'},
                    body
                });
                const json = await res.json();
                if (json.result === 'success') {
                    form.comment.value = '';
                    await loadCommentsForCard(card, card.dataset.id);
                    const cnt = card.querySelector('.comment-count');
                    cnt.textContent = parseInt(cnt.textContent||'0') + 1;
                } else {
                    alert(json.error || json.message);
                }
            });
        });
    }

    // —— 5. 加载评论 ——
    async function loadCommentsForCard(card, postId) {
        const listEl = card.querySelector('.comments-list');
        listEl.innerHTML = '加载中…';
        try {
            const res = await fetch(`${BASE_URL}?type=readSQL&table=comments&postID=${postId}`);
            const comments = await res.json();
            if (!comments.length) {
                listEl.innerHTML = '<p class="no-comments">暂无评论</p>';
            } else {
                listEl.innerHTML = comments.map(c => `
      <div class="comment-item">
        <strong>${c.authorID}</strong>
        <span class="comment-time">${new Date(c.createTime).toLocaleString()}</span>
        <p>${c.content}</p>
      </div>
      `).join('');
            }
        } catch {
            listEl.innerHTML = '<p class="no-comments">加载评论失败</p>';
        }
    }

    // —— 6. 新建版块 ——
    newForumBtn.addEventListener('click', async () => {
        const data = await openModal([
            { name: 'title',       label: '版块标题：', type: 'text',     placeholder: '请输入版块标题' },
            { name: 'description', label: '版块简介：', type: 'textarea', placeholder: '请输入版块简介' }
        ], '新建论坛版块');
        if (!data) return;
        const url  = `${BASE_URL}?type=modifySQL&table=forums`;
        const body = new URLSearchParams(data).toString();
        try {
            const res  = await fetch(url, {
                method:'POST',
                headers:{'Content-Type':'application/x-www-form-urlencoded'},
                body
            });
            const json = await res.json();
            if (json.result === 'success') loadForums();
            else alert(json.error || json.message);
        } catch (err) {
            console.error('🔥 新建版块失败：', err);
        }
    });

    // —— 7. 发新帖 ——
    newPostBtn.addEventListener('click', async () => {
        if (!currentForumID) return;

        // 只要标题／内容
        const data = await openModal([
            { name:'title',   label:'帖子标题：', type:'text'    },
            { name:'content', label:'帖子内容：', type:'textarea'}
        ], '发布新帖子');
        if (!data) return;

        data.forumID = currentForumID;
        const url  = `${BASE_URL}?type=modifySQL&table=posts`;
        const body = new URLSearchParams(data).toString();

        try {
            const res  = await fetch(url, {
                method: 'POST',
                credentials: 'include',          // ← 关键
                headers: {'Content-Type':'application/x-www-form-urlencoded'},
                body
            });
            const json = await res.json();
            if (json.result === 'success') {
                await loadPosts(currentForumID);
            } else {
                alert(json.error || json.message);
            }
        } catch (err) {
            console.error('🔥 发帖失败：', err);
        }
    });



    // —— 初始化 ——
    loadForums();
});
