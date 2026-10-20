#!/usr/bin/env bash
# End-to-end key check against the Fikra API DeepSeek lanes.
# Usage: bash smoke-test.sh
set -euo pipefail
: "${FIKRA_API_KEY:?set FIKRA_API_KEY from https://fikraapi.co.ke}"

echo "== 1. /v1/models reachable"
curl -fsS https://api.fikraapi.co.ke/v1/models -H "Authorization: Bearer $FIKRA_API_KEY" \
  | python3 -c "import json,sys; d=json.load(sys.stdin); ids=[m['id'] for m in d['data']]; print(len(ids),'models'); print('deepseek lanes:', [i for i in ids if i.startswith('deepseek')])"

echo "== 2. Chat Completions, non-streaming, 16-token cap"
curl -fsS https://api.fikraapi.co.ke/v1/chat/completions \
  -H "Authorization: Bearer $FIKRA_API_KEY" -H "Content-Type: application/json" \
  -d '{"model":"deepseek-v4.1-flash","messages":[{"role":"user","content":"reply with the word ok"}],"max_tokens":16}' \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(repr(d['choices'][0]['message']['content']), '| usage:', d.get('usage'))"

echo "== 3. Streaming"
curl -NfsS https://api.fikraapi.co.ke/v1/chat/completions \
  -H "Authorization: Bearer $FIKRA_API_KEY" -H "Content-Type: application/json" \
  -d '{"model":"deepseek-v4.1-flash","messages":[{"role":"user","content":"count 1 to 5"}],"max_tokens":32,"stream":true}' \
  | head -6

echo "== 4. Tool calling round-trip (accepts tools/tool_choice)"
curl -fsS https://api.fikraapi.co.ke/v1/chat/completions \
  -H "Authorization: Bearer $FIKRA_API_KEY" -H "Content-Type: application/json" \
  -d '{"model":"deepseek-v4.1-flash","messages":[{"role":"user","content":"what is 6*7? use the calc tool"}],"max_tokens":64,"tools":[{"type":"function","function":{"name":"calc","description":"multiply two numbers","parameters":{"type":"object","properties":{"a":{"type":"number"},"b":{"type":"number"}},"required":["a","b"]}}}]}' \
  | python3 -c "import json,sys; d=json.load(sys.stdin); m=d['choices'][0]['message']; t=m.get('tool_calls') or []; print('tool call requested:', t[0]['function']['name'] if t else 'none')"
echo "== smoke test passed"
