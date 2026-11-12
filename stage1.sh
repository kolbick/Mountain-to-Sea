#!/bin/bash
export HOME=/home/u2bcf7af1aa78e5c4c8683503
cd /home/u2bcf7af1aa78e5c4c8683503/projects/Mountain-to-Sea

{
echo "=== remove scratch scripts and the deploy probe from the LIVE branch ==="
rm -f buildcheck.sh deploy_step1.sh deploy_step2.sh deploy_test.sh probe2.sh probe3.sh probe4.sh \
      setsource.sh state.sh state2.sh next.sh urls.sh tunnel.sh deploy-probe.txt
git status --short

git add -A
git commit -q -m "chore: remove temporary deploy probe and scratch scripts"
git push origin claude/improve-website-design-7gWxA 2>&1 | tail -2

echo
echo "=== start local preview server on 8080 ==="
pkill -f "http.server 8080" 2>/dev/null
nohup python3 -m http.server 8080 --bind 127.0.0.1 > "$HOME/preview.log" 2>&1 &
sleep 2
curl -sS -o /dev/null -w '  local server -> %{http_code}\n' http://127.0.0.1:8080/index.html

echo
echo "=== start persistent localhost.run tunnel ==="
pkill -f "localhost.run" 2>/dev/null
sleep 1
nohup ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  -o ServerAliveInterval=30 -o ExitOnForwardFailure=yes \
  -N -R 80:localhost:8080 nokey@localhost.run > "$HOME/tunnel.log" 2>&1 &
sleep 25
echo "--- tunnel.log ---"
cat "$HOME/tunnel.log"
} > /home/u2bcf7af1aa78e5c4c8683503/stage1.txt 2>&1
echo launched
