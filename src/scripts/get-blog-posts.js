const { document, window } = global;

class GetBlogPosts {
  constructor() {
    this.posts = {};

    this.el = {
      blogSection: document.querySelectorAll('.js-blog')[0],
      blogList: document.querySelectorAll('.js-blog-list')[0]
    };

    this.getPosts();

  }

  getPosts() {
    window.fetch('https://rd6jaga8bb.execute-api.us-east-2.amazonaws.com/beta/medium').then(response => response.json()).then(json => {
      this.posts = json.payload.references.Post;
      this.parsePosts();
      this.renderPosts();
    }).catch(ex => {
      console.error('parsing failed', ex);
    });
  }

  parsePosts() {

    const posts = [];

    Object.entries(this.posts).forEach(([key, post]) => {
      posts.push(post);
      posts[posts.length - 1].key = key;
    });

    posts.sort((a, b) => b.firstPublishedAt - a.firstPublishedAt);

    this.posts = posts;

  }

  renderPosts() {

    // Object.entries(this.posts).forEach(([key, post]) => {

    this.posts.forEach(post => {
      const li = document.createElement('li');
      const a = document.createElement('a');
      li.classList.add('c-blog-article-list-item');
      li.classList.add('o-list-item');
      a.classList.add('c-blog-link');
      a.classList.add('o-link');
      a.classList.add('u-padding');
      a.href = `https://medium.com/@darryl.snow/${post.uniqueSlug}`;
      a.title = `Read ${post.title} on my Medium blog`;
      a.textContent = post.title;
      // a.setAttribute('data-key', key);
      li.appendChild(a);
      this.el.blogList.appendChild(li);
    });

  }
}

export default new GetBlogPosts();
