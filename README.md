# deepseek-quickstarts

Runnable clients for the [Fikra API](https://fikraapi.co.ke) DeepSeek lanes. Fikra API is an OpenAI-compatible inference endpoint from Nairobi, billed per token in USD with a $1 minimum top-up (M-Pesa or card).

Headline lane, `deepseek-v4.1-flash`: $0.045 per 1M input tokens, $0.09 per 1M output tokens, 1M context. The October 17 build (`deepseek-v4.1-flash-1017`) is $0.05/$0.11. The July 31 build (`deepseek-v4-flash-0731`) is $0.045/$0.10. Prices verified 2026-10-19 on the [pricing page](https://fikraapi.co.ke/pricing).

## DeepSeek lanes

| Model id | In $/1M | Out $/1M | Context | Output cap |
| --- | --- | --- | --- | --- |
| deepseek-v4.1-flash | 0.045 | 0.09 | 1,048,576 | 65,536 |
| deepseek-v4.1-flash-1017 | 0.05 | 0.11 | 1,048,576 | 65,536 |
| deepseek-v4-flash-0731 | 0.045 | 0.10 | 1,048,576 | 65,536 |

Model ids mirror `GET /v1/models`. The same `/v1` also serves GLM 5.3 ($1.05/$3.35), GLM 5.3 Flash ($0.155/$0.49), GLM 5.2 ($0.75/$1.65), Kimi K3 ($2.10/$10.50), StepFun Step 5 preview ($1.25/$3.30), Qwen 3.8 27B ($0.045/$0.35, cached input $0.10), MiMo V2.6 Pro ($0.60/$1.20), Nemotron 3.5 Super VL ($0.50/$1.25), a Gemini 4 Argon forward route and the house lanes (`fikra-auto`, `fikra-auto-pro`, `fikra-pro-20b`, `fikra-pro-120b`, `fikra-code-35b`, `fikra-qwen-27b`, `fikra-qwen-max`).

## Setup

```bash
# create a key at https://fikraapi.co.ke, top up with M-Pesa or card
export FIKRA_API_KEY=your-api-key
export FIKRA_BASE_URL=https://api.fikraapi.co.ke/v1
```

Chat Completions follows the OpenAI surface: `tools`, `tool_choice`, `n`, `seed`, `stop`, `presence_penalty`, `frequency_penalty` and `response_format` (structured JSON output). Reasoning models emit reasoning content on the wire; the endpoint does not expose `thinking` or `reasoning_effort` controls.

## Examples

| File | What it shows |
| --- | --- |
| [examples/curl.sh](examples/curl.sh) | Plain Chat Completions POST plus a streaming variant |
| [examples/python_openai.py](examples/python_openai.py) | OpenAI SDK against the endpoint |
| [examples/python_stream.py](examples/python_stream.py) | OpenAI SDK streaming |
| [examples/node_ai_sdk.ts](examples/node_ai_sdk.ts) | Vercel AI SDK `createOpenAICompatible` |
| [examples/litellm.py](examples/litellm.py) | LiteLLM `custom_openai` pass-through |
| [examples/crewai.py](examples/crewai.py) | CrewAI agent with the documented LLM class pattern |
| [examples/dspy_program.py](examples/dspy_program.py) | DSPy program on `deepseek-v4.1-flash` |

## Status monitor

`lane-probe.yml` in this repo runs nightly (02:17 UTC): one 16-token Chat Completions call per DeepSeek lane, commits `lanes.json` here.

## Contribute

If a snippet rots (SDK version drift, model retirement), open an issue or PR. Keep model ids synced with the pricing page.
