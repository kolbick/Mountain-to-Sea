#!/bin/bash
export HOME=/home/u2bcf7af1aa78e5c4c8683503
cd /home/u2bcf7af1aa78e5c4c8683503/projects/Mountain-to-Sea
{
rm -f fin3.sh
git add -A
git commit -q -m "chore: remove leftover scratch script"
git push origin claude/improve-website-design-7gWxA 2>&1 | tail -2
echo
echo "=== tracked files ==="
git ls-files
echo
echo "=== staging tunnel alive ==="
pgrep -af cloudflared | head -2
pgrep -af "http.server 8080" | head -2
echo "  url: $(grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' $HOME/cf.log | head -1)"
echo
echo "=== production ==="
echo "  index md5 = $(curl -sS --max-time 25 https://mountainstoseatherapy.com/index.html | md5sum | cut -c1-32)"
echo "  probe     = $(curl -sS -o /dev/null -w '%{http_code}' https://mountainstoseatherapy.com/deploy-probe.txt)"
echo "  expected  = 730c5213338176a2b4b4d17147e584fb"
} > /home/u2bcf7af1aa78e5c4c8683503/fin5.txt 2>&1
echo launched
