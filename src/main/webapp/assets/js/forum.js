// src/main/webapp/assets/js/forum.js

console.log('🔄 forum.js loaded');

document.addEventListener('DOMContentLoaded', () => {
    // Modal related DOM references
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
        console.error('⚠️ Page elements not found');
        return;
    }

    const BASE_URL = 'http://localhost:8080/ServerletFinal_war_exploded/data';
    let currentForumID = null;

    // Load all forums
    async function loadForums() {
        const url = `${BASE_URL}?type=readSQL&table=forums`;
        console.log('🌐 requesting forums', url);
        try {
            const res = await fetch(url, { credentials: 'include' });
            const forums = await res.json();
            forumListEl.innerHTML = forums.map(f => `
                <li>
                  <a href="#" data-id="${f.forumID}" class="forum-link">
                    ${f.title} <span class="count">(${f.postCount})</span>
                  </a>
                </li>
            `).join('');
            attachForumClicks();
        } catch (err) {
            console.error('🔥 loadForums failed:', err);
            forumListEl.innerHTML = `<li>Failed to load forums, please refresh</li>`;
        }
    }

    // Attach click events to forums
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

    async function loadPosts(forumID) {
        const url = `${BASE_URL}?type=readSQL&table=posts&forumID=${forumID}`;
        console.log('🌐 requesting posts', url);
        try {
            const res = await fetch(url, { credentials: 'include' });
            const posts = await res.json();
            if (!posts.length) {
                postListEl.innerHTML = '';
                noPostsEl.style.display = '';
            } else {
                noPostsEl.style.display = 'none';
                postListEl.innerHTML = posts.map(p => `
    <div class="topic-item interactive" data-id="${p.id}">
      <div class="topic-main">
      <div class="topic-header">
        <h3 class="topic-title">${p.title}</h3>
        <div class="topic-meta">by <span class="author">${p.authorName || "?"}</span></div>
      </div>
        <p class="topic-content">${p.content}</p>
      </div>

      <div class="topic-actions">
        <button class="btn like-btn">👍 <span class="like-count">${p.likes||0}</span></button>
        <button class="btn comment-toggle-btn">💬 <span class="comment-count">${(p.commentID||'').split(',').filter(x=>x).length}</span></button>
      </div>
      <div class="comments-section" style="display:none">
        <div class="comments-list"></div>
        <form class="comment-form">
          <input type="text" name="comment" placeholder="Write your comment..." required>
          <button type="submit" class="btn">Post</button>
        </form>
      </div>
    </div>
    `).join('');
                attachActionClicks();
            }
        } catch (err) {
            console.error('🔥 Failed to fetch posts:', err);
            postListEl.innerHTML = `<div class="message">Failed to load posts, please retry</div>`;
        }
    }

    // Attach click events for likes, comment toggles, and posting comments
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
                    postID: card.dataset.id
                }).toString();
                const res = await fetch(url, {
                    method:'POST',
                    credentials: 'include',
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

    // Load comments for a specific post
    async function loadCommentsForCard(card, postId) {
        const listEl = card.querySelector('.comments-list');
        listEl.innerHTML = 'loading...';
        try {
            const res = await fetch(`${BASE_URL}?type=readSQL&table=comments&postID=${postId}`);
            const comments = await res.json();
            if (!comments.length) {
                listEl.innerHTML = '<p class="no-comments">no comments yet</p>';
            } else {
                listEl.innerHTML = comments.map(c => `
                  <div class="comment-item">
                    <strong>${c.authorName || c.author}</strong>
                    <span class="comment-time">${new Date(c.createTime).toLocaleString()}</span>
                    <p>${c.content}</p>
                  </div>
      `).join('');
            }
        } catch {
            listEl.innerHTML = '<p class="no-comments">load comments failed</p>';
        }
    }

    // Create a new forum
    newForumBtn.addEventListener('click', async () => {
        const data = await openModal([
            { name: 'title',       label: 'forum title:', type: 'text',     placeholder: 'please enter forum title' },
            { name: 'description', label: 'forum description:', type: 'textarea', placeholder: 'please enter forum description' }
        ], 'create new forum');
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
            console.error('🔥 create forum failed:', err);
        }
    });

    // Post a new topic
    newPostBtn.addEventListener('click', async () => {
        if (!currentForumID) return;

        const data = await openModal([
            { name:'title',   label:'post title:', type:'text'    },
            { name:'content', label:'post content:', type:'textarea'}
        ], 'post new topic');
        if (!data) return;

        data.forumID = currentForumID;
        const url  = `${BASE_URL}?type=modifySQL&table=posts`;
        const body = new URLSearchParams(data).toString();

        try {
            const res  = await fetch(url, {
                method: 'POST',
                credentials: 'include',
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
            console.error('🔥 post new topic failed:', err);
        }
    });

    // Initialize the forum
    loadForums();

});
