# 🚀 新对话开场指引（START HERE）

> 本文件是给「小程序」项目（或任何新环境）的新对话准备的。
> 新对话开始时，让 AI 执行下面的步骤，即可 100% 恢复全部上下文。

## 第一步：恢复资产

```bash
git clone https://github.com/ZQ0424/h5-tools-hub.git /workspace/h5-apps
cd /workspace/h5-apps
```

## 第二步：读取知识库（按顺序）

1. **`KNOWN_INDEX.md`** —— 主索引：项目状态、20 个工具清单、待办、踩坑、关键决策。读完即恢复 90% 上下文。
2. `manifest.json` —— 工具登记表（20 个工具 + 分类 + 评分），做新工具时用于去重。
3. `archive/` —— 历史细节（按需读）。

## 第三步：恢复部署能力（需要用户操作一次）

部署需要 GitHub 经典 PAT。请用户把 PAT 粘贴给你后：

```bash
echo "GITHUB_PAT=\"ghp_xxx\"" > /workspace/h5-apps/.github_pat
```

之后 `bash deploy.sh` 即可部署。PAT 不要提交到任何仓库。

## 项目现状速览（2026-10-15）

- 公网：https://zq0424.github.io/h5-tools-hub/
- 20 个工具全部在线，统一组件 v7（14 语言 i18n）
- 后端：Supabase `jebnpaglwgozboyujxnx`（votes/comments/favorites 三表已建好）
- 前端已就绪，等三样东西就能商业化：支付密钥（微信商户/支付宝/Stripe）、短信 OTP 密钥、收款码图片 URL

## 新对话第一句话模板（给用户）

> 「读 /workspace/h5-apps/KNOWN_INDEX.md 恢复上下文，然后我们继续做小程序。」
