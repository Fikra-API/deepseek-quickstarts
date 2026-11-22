# deepseek-quickstarts

Runnable clients for the [Fikra API](https://fikraapi.co.ke) DeepSeek lanes. Fikra API is an OpenAI-compatible inference endpoint from Nairobi, billed per token in USD with a $5 minimum top-up (M-Pesa or card).

Headline lane, `deepseek-v4.1-flash`: $0.1875 per 1M input tokens, $0.75 per 1M output tokens, 1M context. The October 17 build (`deepseek-v4.1-flash-1017`) is $0.1875/$0.75. The July 31 build (`deepseek-v4-flash-0731`) is $0.55/$1.65. A free window, `deepseek-v4-1-flash-economy-free`, is also available. Prices checked 2026-11-21 on the [pricing page](https://fikraapi.co.ke/pricing).

## DeepSeek lanes

| Model id | In $/1M | Out $/1M | Context | Output cap |
| --- | --- | --- | --- | --- |
| deepseek-v4.1-flash | 0.1875 | 0.75 | 1,048,576 | 65,536 |
| deepseek-v4.1-flash-1017 | 0.1875 | 0.75 | 1,048,576 | 65,536 |
| deepseek-v4-flash-0731 | 0.55 | 1.65 | 1,048,576 | 65,536 |

Model ids mirror `GET /v1/models`. The same `/v1` also serves GLM 5.3 ($1.225/$3.85), GLM 5.3 Flash ($0.1875/$0.625), GLM 5.2 ($1.75/$5.50), Kimi K3 ($2.4375/$12.1875), Qwen 3.8 27B ($0.045/$0.35), MiMo V2.6 Pro ($0.50/$1.00), Nemotron 3.5 Super VL ($0.50/$1.25), Gemini 4 Argon ($2.50/$12.00), Qwen 4 Max ($1.875/$5.625), and the house lanes (`fikra-auto`, `fikra-auto-pro`, `fikra-pro-20b`, `fikra-pro-120b`, `fikra-code-35b`, `fikra-qwen-27b`).

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
| [examples/smoke-test.sh](examples/smoke-test.sh) | Key check, models list, completion, streaming, tools round-trip |
| [examples/aider.yml](examples/aider.yml) | Aider config pointed at the endpoint |
| [examples/strands.py](examples/strands.py) | Strands Agents via the OpenAI provider |

## Strands Agents

`examples/strands.py` runs a one-shot agent through the SDK's built-in OpenAI provider pointed at `https://api.fikraapi.co.ke/v1` (model `deepseek-v4.1-flash`):

```python
pip install 'strands-agents[openai]'
export FIKRA_API_KEY=...  # https://fikraapi.co.ke
python examples/strands.py
```

## Status monitor

`lane-probe.yml` in this repo runs nightly (02:17 UTC): one 16-token Chat Completions call per DeepSeek lane, commits `lanes.json` here.

## Contribute

If a snippet rots (SDK version drift, model retirement), open an issue or PR. Keep model ids synced with the pricing page.
