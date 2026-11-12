#!/bin/bash
# Preview helper for Mountains to Sea Therapy.
#
#   ./preview.sh start   - start local server + cloudflared tunnel, print URL
#   ./preview.sh stop    - stop both
#   ./preview.sh url     - print the current tunnel URL
#   ./preview.sh publish - commit + push the live branch (deploys to mountainstoseatherapy.com)
#
# The local server serves the working tree, so you can edit files and refresh.
export HOME=/home/u2bcf7af1aa78e5c4c8683503
export PATH="$HOME/.local/bin:$PATH"
cd "$(dirname "$0")" || exit 1

PORT=8080
CFLOG="$HOME/cf.log"
SITE=https://mountainstoseatherapy.com

case "$1" in
  start)
    pkill -f "http.server $PORT" 2>/dev/null
    pkill -f "cloudflared tunnel" 2>/dev/null
    sleep 1
    nohup python3 -m http.server "$PORT" --bind 127.0.0.1 > "$HOME/preview.log" 2>&1 &
    sleep 2
    nohup "$HOME/.local/bin/cloudflared" tunnel --url "http://127.0.0.1:$PORT" --no-autoupdate > "$CFLOG" 2>&1 &
    echo "Waiting for tunnel..."
    for i in $(seq 1 30); do
      sleep 2
      U=$(grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "$CFLOG" | head -1)
      if [ -n "$U" ]; then
        echo
        echo "  PREVIEW:  $U"
        echo "  LIVE:     $SITE"
        echo
        echo "  Edit files in this folder, then refresh the preview URL."
        exit 0
      fi
    done
    echo "Tunnel did not come up. Check $CFLOG"
    exit 1
    ;;
  stop)
    pkill -f "http.server $PORT" 2>/dev/null
    pkill -f "cloudflared tunnel" 2>/dev/null
    echo "Stopped."
    ;;
  url)
    grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' "$CFLOG" | head -1
    ;;
  publish)
    git add -A
    git commit -m "${2:-Update site content}"
    git push origin claude/improve-website-design-7gWxA
    echo "Pushed. Pages will rebuild in ~1-2 minutes."
    ;;
  *)
    echo "Usage: ./preview.sh {start|stop|url|publish [message]}"
    exit 1
    ;;
esac
