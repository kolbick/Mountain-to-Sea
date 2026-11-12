#!/bin/bash
export HOME=/home/u2bcf7af1aa78e5c4c8683503
cd /home/u2bcf7af1aa78e5c4c8683503/projects/Mountain-to-Sea
{
echo "=== remove remaining scratch, keep preview.sh ==="
rm -f final.sh stage1.sh verify.sh tun2.sh cf.sh stg.sh urls.sh tunnel.sh state.sh state2.sh next.sh
chmod +x preview.sh
git add -A
git status --short
git commit -q -m "chore: add preview.sh helper for local preview + tunnel workflow" 2>&1 | tail -2
git push origin claude/improve-website-design-7gWxA 2>&1 | tail -2
echo
echo "=== repo contents ==="
git ls-files
echo
echo "=== live site check ==="
echo "  index md5 = $(curl -sS --max-time 25 https://mountainstoseatherapy.com/index.html | md5sum | cut -c1-32)"
echo "  probe 404? $(curl -sS -o /dev/null -w '%{http_code}' https://mountainstoseatherapy.com/deploy-probe.txt)"
echo "  tunnel: $(grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' $HOME/cf.log | head -1)"
} > /home/u2bcf7af1aa78e5c4c8683503/fin3.txt 2>&1
echo launched
