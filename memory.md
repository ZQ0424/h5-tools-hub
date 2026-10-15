# H5 工具矩阵 · 经验记忆（由每日生产线自动维护）

> 本文件由定时任务（任务 id 12336405）每日收尾时追加。用于跨日积累「有效做法 / 踩坑 / 选题权重 / 质量红线」，让生产线越跑越聪明。
> 最新经验请同时沉淀进定时任务 prompt 的「经验摘要」锚点段。

## 初始化（2026-10-15）
- 公网托管走 GitHub Pages（仓库 ZQ0424/h5-tools-hub），部署用 deploy.sh + .github_pat（经典 PAT，有 repo 写权限）。
- GitHub 连接器（只读 OAuth）与 CNB 连接器（无网页托管、沙箱取不到令牌）均不可用于自动部署；只有经典 PAT 可行。
- 国内访问 github.io 偏慢，必要时可回流 EdgeOne Pages 或绑备案域名。
- 门户卡片改紧凑布局；新增搜索框、最热榜、点赞（localStorage 本地累计，非跨用户）。

## 后端与排行（2026-10-15）
- Supabase 项目 jebnpaglwgozboyujxnx（东京区），anon key 直接注入前端（RLS 仅允许 anon 读 votes、读写 comments）。
- votes 表字段：slug, total, week, week_start, month, month_start, views_total, views_week, views_month, last_voted_at。
- RPC increment_vote / increment_view 内部按 week_start/month_start 自动重置周/月计数；每次会话 sessionStorage 去重防刷量。
- 门户 tab：最新/收藏/周榜/月榜/总榜 五档；收藏存 localStorage(h5hub_fav)，跨设备同步需登录（待做）。

## 组件与付费（2026-10-15）
- 工具页统一组件 inject_components.py（当前 v5），部署前 deploy.sh 自动注入；定时任务生成新工具后无需手动加组件。
- 组件含：返回首页🏠、点赞👍、收藏⭐、分享海报↗(Canvas+二维码,扫码直达)、评论💬(Supabase comments 表)、💎直接收费入口、浏览量👁。
- 付费墙：免费 10 次(localStorage h5hub_use 计数)，第 11 次弹窗**可关闭但锁死页面**(blur+禁用)，仅💎可重开；付款检测后(h5hub_pro=1)解锁。
  - 当前激活为 honor-system(点"我已支付"→激活)，真·自动到账检测待接入微信商户 Native 支付(Supabase Edge Function + 支付回调)。
- 分享海报解决了"分享图片无法点入"：海报自带工具二维码，扫码直达工具链接。

## 多语言（2026-10-15）
- 门户 i18n 支持 中/英/日/韩/西/法/德/俄 8 语，T() 兜底顺序 当前→en→zh；选外语即时切换并 localStorage 记忆(h5hub_lang)。

## 模型策略（2026-10-15）
- 用户选定固定主力 GLM-5.2(0.79x)，上下文 300k（够用且最省）；质量优先、不轮换模型，已写进定时任务 prompt 并禁止进化机制改动此策略。
