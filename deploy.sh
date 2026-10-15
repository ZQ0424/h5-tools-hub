#!/usr/bin/env bash
# 部署脚本：把 /workspace/h5-apps 下的 H5 工具推送到 GitHub Pages（公开、可被搜索引擎收录）
# 用法：bash deploy.sh
set -u

cd "$(dirname "$0")"

# 读取 PAT：优先用环境变量，否则读本地 .github_pat
if [ -z "${GITHUB_PAT:-}" ] && [ -f .github_pat ]; then
  source .github_pat
fi
if [ -z "${GITHUB_PAT:-}" ]; then
  echo "❌ 未找到 GITHUB_PAT（请设置环境变量或填写 .github_pat）"
  exit 1
fi

OWNER="ZQ0424"
REPO="h5-tools-hub"
BRANCH="main"
API="https://api.github.com/repos/$OWNER/$REPO/contents"

echo "=== 注入统一组件（返回/点赞/收藏/分享/评论/付费墙）==="
python3 tools/inject_components.py || echo "⚠️ 注入脚本失败，继续部署未注入版本"

# 自动发现全部站点文件：门户 + manifest + README + 所有工具文件（index.html / icon.svg / manifest.webmanifest）
mapfile -t files < <(printf '%s\n' "index.html" "manifest.json" "README.md" "PROJECT_HANDOFF.md" "robots.txt" "sitemap.xml"; find . -mindepth 2 \( -name 'index.html' -o -name 'icon.svg' -o -name 'manifest.webmanifest' \) -not -path './supabase/*' -not -path './tools/*' | sed 's|^\./||' | sort)

put_file() {
  local f="$1"
  local b64 sha code resp
  b64=$(base64 -w0 "$f")
  resp=$(curl -s -w "\n%{http_code}" -X PUT -H "Authorization: Bearer $GITHUB_PAT" -H "Content-Type: application/json" \
    "$API/$f" -d "$(jq -n --arg m "deploy $f" --arg c "$b64" '{message:$m, content:$c, branch:"main"}')")
  code=$(echo "$resp" | tail -n1)
  # 已存在（409 冲突 / 422 缺 sha）时：取 sha 后更新
  if [ "$code" = "409" ] || [ "$code" = "422" ]; then
    sha=$(curl -s -H "Authorization: Bearer $GITHUB_PAT" "$API/$f?ref=$BRANCH" | python3 -c "import sys,json;print(json.load(sys.stdin)['sha'])")
    code=$(curl -s -o /dev/null -w "%{http_code}" -X PUT -H "Authorization: Bearer $GITHUB_PAT" -H "Content-Type: application/json" \
      "$API/$f" -d "$(jq -n --arg m "deploy $f" --arg c "$b64" --arg s "$sha" '{message:$m, content:$c, sha:$s, branch:"main"}')")
  fi
  echo "  $code  $f"
}

echo "=== 推送到 GitHub Pages ($OWNER/$REPO) ==="
for f in "${files[@]}"; do
  [ -f "$f" ] && put_file "$f"
done

echo "=== 确保 GitHub Pages 已开启 ==="
curl -s -o /dev/null -X POST -H "Authorization: Bearer $GITHUB_PAT" -H "Content-Type: application/json" \
  "https://api.github.com/repos/$OWNER/$REPO/pages" -d '{"source":{"branch":"main","path":"/"}}' 2>/dev/null
echo ""
echo "✅ 完成。公网地址：https://$OWNER.github.io/$REPO/"
