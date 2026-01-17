import { defineNavbarConfig } from 'vuepress-theme-plume'

export default defineNavbarConfig([
  { text: '首页', link: '/' },
  { text: '博客', link: '/blog/' },
  { text: '标签', link: '/blog/tags/' },
  { text: '归档', link: '/blog/archives/' },
  { text: '公式简记', link: '/blog/v5ah8jz2/' },
  {
    text: '笔记',
    items: [
      { text: '量子物理', link: '/quantphys/README.md' },
    ],
  },
])
