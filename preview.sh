#!/bin/bash
# Preview the live site locally, exactly as GitHub Pages serves it.
# Usage: ./preview.sh [port]
PORT="${1:-8080}"
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Serving $DIR on http://localhost:$PORT"
echo "Pages: index.html about.html contact.html how-i-work.html insurance-fees.html who-i-help.html"
echo "Ctrl-C to stop."
cd "$DIR" && python3 -m http.server "$PORT"
