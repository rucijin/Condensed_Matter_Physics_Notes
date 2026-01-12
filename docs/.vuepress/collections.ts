import { defineCollection, defineCollections } from 'vuepress-theme-plume'

const blog = defineCollection({
  type: 'post',
  dir: 'blog',
  title: 'Blog',
  // 文章列表页的链接，如果 `linkPrefix` 未定义，它也将作为 相关的文章的 permalink 的前缀
  link: '/blog/',
  postList: true, // 是否启用文章列表页
  tags: true, // 是否启用标签页
  archives: true, // 是否启用归档页
  categories: true, // 是否启用分类页
  postCover: 'right', // 文章封面位置
  pagination: 30, // 每页显示文章数量
})

const demoDoc = defineCollection({
  type: 'doc',
  dir: 'demo',
  linkPrefix: '/demo',
  title: 'Demo',
  sidebar: 'auto',
})

export default defineCollections([
  blog,
  demoDoc,
])
