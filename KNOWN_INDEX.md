# H5 工具矩阵 · 知识库主索引（KNOWN_INDEX）

> **唯一权威入口。** 每次新对话开始时，只需读本文件即可恢复全部上下文。
> 本文件由 AI 每日 23:59 维护，始终保持精炼、最新。历史细节见 `archive/` 目录。

---

## 一句话目标

用 WorkBuddy 定时任务每天 06:00 自动产出 3 个免费 H5 小工具，推到公网（GitHub Pages），逐步沉淀为微信小程序变现。**质量优先、固定模型（GLM-5.2）、越跑越聪明。**

## 关键信息速查

| 项 | 值 |
|---|---|
| 公网地址 | https://zq0424.github.io/h5-tools-hub/ |
| 代码仓库 | GitHub `ZQ0424/h5-tools-hub`（main 分支 = Pages 源） |
| 部署命令 | `bash /workspace/h5-apps/deploy.sh`（注入组件 + 推 GitHub Contents API） |
| 后端 | Supabase 项目 `jebnpaglwgozboyujxnx`（东京区） |
| 定时任务 | WorkBuddy 任务 id `12336405`，cron `0 0 6 * * *` |
| 固定模型 | GLM-5.2（0.79x），上下文 300k（**禁止轮换**） |
| 工具总数 | **20 个**（11 原有 + 9 新增），7 大分类 |

## 本地权威目录

`/workspace/h5-apps/` —— 合并了两条历史产线的唯一权威工作区（2026-10-15 合并完成）。

```
h5-apps/
├── index.html               门户首页（分类导航/搜索/收藏/周·月·总榜/14语切换/分享海报/💎解锁）
├── manifest.json            工具登记表（20 个工具，含综合评价分 + 分类）
├── KNOWN_INDEX.md           ★ 本文件（知识库主索引）
├── PROJECT_HANDOFF.md       项目交接文档
├── memory.md                每日经验（定时任务追加）
├── deploy.sh                部署脚本（先注入组件，再推全部站点文件）
├── deploy-ghpages.sh        备用部署脚本（旧版）
├── .github_pat              GitHub 经典 PAT（GITHUB_PAT="ghp_..." 格式，勿外泄）
├── robots.txt / sitemap.xml  SEO 配置
├── tools/inject_components.py  工具页统一组件注入器（当前 v7，14语i18n）
├── supabase/functions/portal/  微信支付 Edge Function 草稿
└── <slug>/  ×20             工具子目录（index.html + icon.svg + manifest.webmanifest）
```

## 工具分类（7 类）

| 分类 | 工具 |
|---|---|
| 🧩 全部 | 20 个 |
| 🖼️ 图片 | img-kb-compress、grid-split、color-picker |
| 📝 文字 | xiaohongshu-formatter、copywriter、trad-simp、word-count |
| 💼 办公 | shift-schedule、weekly-report、unit-converter |
| 🏠 生活 | bmi-tracker、countdown、pomodoro |
| 💻 开发 | pwd-gen、qr-generator、text-diff、unix-timestamp、codec-toolkit |
| 🎮 娱乐 | lucky-wheel、random-decider |

## 工具清单（20 个）

### 第二批（pkg3 产物，已部署，已评分）
| slug | 名称 | 主攻词 | 评分 | 分类 |
|---|---|---|---|---|
| lucky-wheel | 转盘抽奖·随机点名 | 转盘抽奖 | 92 | 娱乐 |
| img-kb-compress | 图片压缩到指定KB | 图片压缩 | 90 | 图片 |
| grid-split | 九宫格切图 | 朋友圈九宫格 | 89 | 图片 |
| shift-schedule | 排班表生成器 | 排班表 | 88 | 办公 |
| pwd-gen | 密码生成器 | 密码生成 | 88 | 开发 |
| bmi-tracker | BMI计算器·健康打卡 | BMI计算器 | 87 | 生活 |

### 门户主线（pkg1 产物，已上线，含付费墙/登录/Supabase）
| slug | 名称 | 主攻词 | 评分 | 分类 |
|---|---|---|---|---|
| xiaohongshu-formatter | 小红书笔记排版器 | 小红书排版 | 未评 | 文字 |
| weekly-report | AI 周报生成器 | 周报生成器 | 未评 | 办公 |
| countdown | 倒计时·纪念日 | 考研倒计时 | 未评 | 生活 |
| unit-converter | 单位换算器 | 单位换算 | 未评 | 办公 |
| copywriter | 爆款文案生成器 | 小红书标题 | 未评 | 文字 |

### 第三批（本次新增，参考 67tool.com，已部署）
| slug | 名称 | 主攻词 | 分类 |
|---|---|---|---|
| qr-generator | 二维码生成器 | 二维码生成 | 开发 |
| text-diff | 文本比对 | 文本比对 | 开发 |
| trad-simp | 繁简转换 | 繁简转换 | 文字 |
| word-count | 字数统计 | 字数统计 | 文字 |
| color-picker | 颜色提取 | 取色器 | 图片 |
| pomodoro | 番茄钟 | 番茄工作法 | 生活 |
| random-decider | 随机决定 | 随机数/抽签 | 娱乐 |
| unix-timestamp | 时间戳转换 | 时间戳 | 开发 |
| codec-toolkit | 编解码工具箱 | Base64/MD5 | 开发 |

> 全部 20 个工具已注入统一组件 v7（返回首页/点赞/收藏云同步/分享海报/评论/付费墙/浏览量，全部文案已 i18n 化，跟随浏览器语言自动切换 14 语言）。

## 已完成功能

1. 每日 06:00 自动产出 3 个 H5，自动部署（去重/防同质化/强留存/i18n/自我进化）。
2. 门户：紧凑卡片、搜索、⭐收藏、🔥周榜/📅月榜/🏆总榜/🆕最新、🌐14语切换。
3. 跨用户真实数据：点赞👍、浏览量👁、评论💬（Supabase，周/月自动重置）。
4. 分享海报↗（Canvas 生成，含二维码，扫码直达）。
5. 付费墙：免费 10 次后锁死，💎¥19.9/年、¥49.9/永久，微信/支付宝（当前 honor-system）。
6. 登录+收藏云同步：邮箱登录，收藏存 Supabase `favorites` 表。
7. **全站 i18n（14 语言）**：中/英/日/韩/西/法/德/俄/葡/阿/印地/越/泰/印尼，门户 + 注入组件均按浏览器语言自动检测，无需手动切换。

## 数据库 schema（Supabase public）

- `votes(slug PK, total, week, week_start, month, month_start, views_total, views_week, views_month, last_voted_at)` — RLS: anon select
- `comments(id, slug, name, body[1-500], created_at)` — RLS: anon select+insert
- `favorites(id, user_id→auth.users, slug, created_at, unique(user_id,slug))` — RLS: authenticated 仅自己，触发器 `fav_uid_trg` 自动填 user_id
- RPC `increment_vote(text)→int`、`increment_view(text)→int`（周/月自动重置）

## ⏳ 待办（按优先级）

1. **微信支付真闭环**：需用户提供 mchid / APIv3 密钥 / 商户证书(.pem+序列号) / AppID，并开通 Native 支付 + 回调地址。草稿已存在 `supabase/functions/portal/index.ts`。
2. **支付宝**：需 APPID + 应用私钥 + 支付宝公钥。
3. **登录方式扩展**：短信验证码 OTP（用户已选定手机号方案，需 Twilio/Vonage/阿里云短信密钥）替代邮箱登录。
4. **支付 UI 适配国外**：已加入 Stripe 双轨方案，但尚未实现（需 Stripe 密钥 + 后端收款回调）。
5. **Supabase 后台关「Confirm email」**：否则邮箱注册收不到确认邮件登不进。
6. （可选）国内提速（EdgeOne/备案域名）、热门角标、更细排行、会员云同步。

## ⚠️ 关键踩坑记录（必读）

1. **PAT 格式**：`.github_pat` 内是 `GITHUB_PAT="ghp_..."` 格式（deploy.sh 用 `source` 读取）。若改用「只放 token」的脚本，需同步改读取方式。
2. **部署脚本已改进**：原 deploy.sh 只推 index.html，现已扩展推送 icon.svg/manifest.webmanifest（PWA 完整性）。
3. **GitHub 连接器只读**：自动部署必须用经典 PAT，不能用连接器。
4. **CNB 不托管网页**：无 Pages API，仅国内镜像备用。
5. **预览面板勿点卡片**：对 github.io 相对路径跳转会超时，需浏览器/微信地址栏直开。
6. **定时任务写回 prompt 被禁**：自动化环境禁止 `scheduler-api.sh update`，经验改落盘 `evolve-summary.md`/`memory.md`。
7. **pkg2 与 pkg3 的 h5-apps 完全重复**：已合并，pkg2 可废弃。

## 每日恢复流程（新对话开头照做）

1. 读本文件 `KNOWN_INDEX.md`（当前状态、工具清单、待办、踩坑）。
2. 读 `memory.md`（最新经验）和 `archive/`（如需历史细节）。
3. 读 `manifest.json`（工具去重依据）。
4. 直接说需求，无需重新介绍背景。

---

*最后更新：2026-10-15（组件 i18n v7 完成并部署）*
