# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个基于 [VuePress 2](https://vuepress.vuejs.org/) 和 [vuepress-theme-plume](https://theme-plume.vuejs.press/) 构建的凝聚态物理知识聚合网站。目标是为凝聚态物理提供包含讲义、公式、练习题和概念解释的在线资源。

## 常用命令

```sh
pnpm i                  # 安装依赖
pnpm docs:dev           # 启动开发服务
pnpm docs:dev-clean     # 清除缓存后启动开发服务
pnpm docs:build         # 构建生产包（含缓存和临时目录清理）
pnpm docs:preview       # 本地预览生产构建（使用 http-server）
pnpm vp-update          # 更新 vuepress 和主题版本
```

## 技术栈

- **Node.js**: `^20.19.0 || >=22.0.0`
- **包管理器**: pnpm `10.28.0`（通过 `packageManager` 字段锁定）
- **框架**: Vue 3 + TypeScript
- **构建工具**: VuePress 2 + Vite bundler
- **主题**: vuepress-theme-plume `1.0.0-rc.202`
- **关键依赖**: `three`（3D 渲染）、`pyodide`（浏览器端 Python 执行）

## 架构一览

### 配置分层

主题采用双配置文件设计，注意**不要在两个文件中重复配置相同的项**（`config.ts` 中的配置会覆盖 `plume.config.ts`）：

- **`docs/.vuepress/config.ts`** — VuePress 本身的配置 + 通过 `plumeTheme({...})` 配置主题。支持的全部字段：`plugins`、`markdown`、`codeHighlighter`、`search`、`comment`、`watermark`、`readingTime`、`copyCode`、`replaceAssets`、`editLink`、`lastUpdated`、`contributors`、`changelog`、`cache`、`hostname`、`configFile`、`encrypt`、`llmstxt` 以及站点级配置（base、lang、bundler 等）。
- **`docs/.vuepress/plume.config.ts`** — 通过 `defineThemeConfig` 定义的纯 UI 层配置。支持的字段：`hostname`、`home`、`logo`、`logoDark`、`appearance`、`profile`、`social`、`navbarSocialInclude`、`navbar`、`collections`、`sidebar`、`sidebarScrollbar`、`aside`、`outline`、`transition`、`footer`、`bulletin`、`copyright`、`prevPage`、`nextPage`、`createTime`、`locales`、`docsRepo`/`docsBranch`/`docsDir`、`autoFrontmatter`、`editLinkPattern`。
  > ⚠️ `plume.config.ts` **不支持**：`plugins`、`markdown`、`codeHighlighter`、`search`、`comment`、`watermark`、`cache`、`encrypt`、`llmstxt` 等。这些只能在 `config.ts` 的 `plumeTheme({...})` 中配置。

### 内容组织（Collections）

内容通过 `docs/.vuepress/collections.ts` 以 Collection 方式组织：

- **blog**（`type: 'post'`）— `docs/blog/` 目录下的博客文章，启用了标签页、归档页、分类页和文章列表，每页 30 篇。
- **quantphys**（`type: 'doc'`）— `docs/quantphys/` 目录下的文档，侧边栏自动生成。

### 自定义组件

在 `docs/.vuepress/client.ts` 中通过 `defineClientConfig` 注册了自定义组件：

- **`Custom.vue`** — 简单的示例组件，展示响应式消息

自定义样式位于 `docs/.vuepress/theme/styles/custom.css`，提供了主题颜色、背景色、文本色的 CSS 变量预设（目前均为注释状态）。

### 部署

GitHub Actions 工作流（`.github/workflows/deploy.yml`）在 push 到 `main` 分支时自动构建并部署到 `gh-pages` 分支。使用 `crazy-max/ghaction-github-pages` 进行部署，需要仓库配置 `CONDMATPHYS_TOKEN` secret 和 `Read and write permissions` 工作流权限。

## Vue Skills

本项目安装了 [vuejs-ai/skills](https://github.com/vuejs-ai/skills)，位于 `.claude/skills/vuejs-ai/`。这些技能在编写 Vue 代码时自动生效，涵盖以下场景：

| 技能 | 适用范围 |
|------|----------|
| `vue-best-practices` | Vue 3 Composition API、`<script setup lang="ts">`、TypeScript、SSR |
| `vue-options-api-best-practices` | Vue 3 Options API 风格 |
| `vue-jsx-best-practices` | Vue 中 JSX 语法 |
| `vue-testing-best-practices` | Vitest、Vue Test Utils、Playwright E2E |
| `vue-router-best-practices` | Vue Router 4 模式、导航守卫、路由参数 |
| `vue-pinia-best-practices` | Pinia 状态管理 |
| `vue-debug-guides` | Vue 3 调试：运行时错误、警告、SSR 水合问题 |
| `create-adaptable-composable` | 使用 `MaybeRef`/`MaybeRefOrGetter` 创建可复用 composable |

## Plume Theme Skills

本项目安装了 [vuepress-theme-plume](https://github.com/pengzhanbo/vuepress-theme-plume) 仓库提供的技能，位于 `.claude/skills/` 目录下（与 `vuejs-ai/` 并列）。这些技能在编写 VuePress 主题配置或 Markdown 内容时自动生效：

| 技能 | 适用范围 |
|------|----------|
| `vuepress-plume-config` | 主题配置生成：`config.ts`、`plume.config.ts`、collections、navbar、sidebar、locales、plugins、encrypt、search、comment、watermark 等 |
| `vuepress-plume-markdown` | Markdown 写作助手：容器（hint/alert/details）、图表（Mermaid/ECharts/Chart.js）、嵌入（YouTube/Bilibili/PDF/CodePen）、代码块增强（highlight/focus/diff/twoslash）、LLMs txt 标记 |

安装来源：[pengzhanbo/vuepress-theme-plume/skills](https://github.com/pengzhanbo/vuepress-theme-plume/tree/main/skills)
