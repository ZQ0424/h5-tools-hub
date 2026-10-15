# H5 工具矩阵 · 项目交接文档（电脑端续接用）

> 本文件记录当前项目全量状态与待办，供在电脑端打开本项目后续接对话。最后更新：2026-10-15。

## 一句话目标
用 WorkBuddy 定时任务每天 06:00 自动产出 3 个免费 H5 小工具，推到公网，逐步沉淀为微信小程序变现。质量优先、固定模型、越跑越聪明。

## 关键信息速查
| 项 | 值 |
|---|---|
| 公网地址 | https://zq0424.github.io/h5-tools-hub/ |
| 代码仓库 | GitHub `ZQ0424/h5-tools-hub`（main 分支 = GitHub Pages 源） |
| 部署方式 | `bash /workspace/h5-apps/deploy.sh`（自动注入组件 + 推 GitHub Contents API） |
| 后端 | Supabase 项目 `jebnpaglwgozboyujxnx`（东京区） |
| 定时任务 | WorkBuddy 任务 id `12336405`，cron `0 0 6 * * *`，prompt 见 `/tmp/gen_prompt.txt` |
| 固定模型 | GLM-5.2（0.79x），上下文 300k |

## 本地文件结构（/workspace/h5-apps）
- `index.html` — 门户首页：搜索/收藏/周·月·总榜/8语切换/分享海报/💎解锁入口
- `manifest.json` — 工具登记表（slug/name/desc/icon/keywords/path/generated）
- `deploy.sh` — 部署脚本（先注入组件，再推全部 `*/index.html`）
- `tools/inject_components.py` — 工具页统一组件注入器（当前 v5）
- `.github_pat` — GitHub PAT（本地机密，勿外泄）
- `memory.md` — 经验记忆（定时任务每日追加）
- `<slug>/index.html` ×5 — 小红书排版/周报/倒计时/单位换算/文案

## 已完成功能
1. 每日 06:00 自动产出 3 个 H5（去重/防同质化/强留存/i18n/UI 质量优先/自我进化），自动部署。
2. 门户：紧凑卡片+简介、搜索框、⭐收藏 tab、🔥周榜/📅月榜/🏆总榜/🆕最新、🌐8 语切换。
3. 全站跨用户真实数据：点赞👍、浏览量👁、评论💬（Supabase，周/月自动重置）。
4. 分享↗：现场生成海报（工具图标+名称+站点 slogan+二维码），扫码直达，解决"分享图无法点入"。
5. 返回首页🏠：每个工具页固定入口。
6. 付费墙：免费 10 次后**可关闭弹窗但锁死工具**，💎可直接收费；¥19.9/年、¥49.9/永久；微信/支付宝切换。

## 数据库 schema（public）
- `votes(slug PK, total, week, week_start, month, month_start, views_total, views_week, views_month, last_voted_at)` — RLS: anon select
- `comments(id uuid PK, slug, name, body[1-500], created_at)` — RLS: anon select+insert（delete 被 RLS 拦截）
- RPC `increment_vote(text)→int`、`increment_view(text)→int`（周/月自动重置）

## ⏳ 待办 / 待你提供
1. **微信支付真闭环**：你已开通微信商户（支付宝未开通）。需从 pay.weixin.qq.com 提供：商户号 mchid、APIv3 密钥、商户 API 证书(.pem 私钥+证书序列号)、关联 AppID；并在产品中心开通 **Native 支付**、留支付回调地址给我填。提供后我用 Supabase Edge Function 实现：扫码→自动判到账→自动解锁（替代当前 honor-system 激活）。
2. **支付宝**：等你开通后给 应用APPID+应用私钥+支付宝公钥。
3. **登录+收藏云同步**：当前收藏/付费状态存本机 localStorage（换设备不同步）。要跨设备需加 Supabase Auth（邮箱/微信登录）+ favorites 表。你点头即可开做。
4. （可选）国内提速：买域名+备案回流 EdgeOne Pages。
5. （可选）热门工具打"🔥热门"角标、更细时间维度排行。

## Supabase 容量说明
免费档 500MB 库 + 1GB 存储 + 5 万月活 + 2GB 月流量；当前小表几千用户无压力、不会崩；7 天无访问会休眠，但每日定时任务会访问所以保持在线。万级日活再升 Pro($25/月)。

## 如何在电脑端续接
- WorkBuddy 登录同一账号 → 打开本项目（工作区 `/workspace/h5-apps`）→ 本文件及全部代码已同步可见。
- 对我说"接着上次"即可，我会先读本文件 + `memory.md` 恢复上下文。
- 关键命令：部署 `bash /workspace/h5-apps/deploy.sh`；仅注入组件 `python3 /workspace/h5-apps/tools/inject_components.py`。
