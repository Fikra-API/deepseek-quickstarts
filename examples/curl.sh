#!/usr/bin/env bash
# Stock Chat Completions call against the Fikra API DeepSeek lanes.
set -euo pipefail
: "${FIKRA_API_KEY:?set FIKRA_API_KEY from https://fikraapi.co.ke}"

curl -s https://api.fikraapi.co.ke/v1/chat/completions \
  -H "Authorization: Bearer $FIKRA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "deepseek-v4.1-flash",
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "Say the four busiest roundabouts in Nairobi, comma separated."}
    ],
    "temperature": 0.3
  }' | python3 -c "import json,sys; print(json.load(sys.stdin)['choices'][0]['message']['content'])"

# Streaming variant:
# curl -N https://api.fikraapi.co.ke/v1/chat/completions \
#   -H "Authorization: Bearer $FIKRA_API_KEY" \
#   -H "Content-Type: application/json" \
#   -d '{"model":"deepseek-v4.1-flash","messages":[{"role":"user","content":"Count from 1 to 10."}],"stream":true}'
