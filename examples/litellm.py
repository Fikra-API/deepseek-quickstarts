"""LiteLLM pass-through to the Fikra API DeepSeek lanes.

    pip install litellm
"""
import os

from litellm import completion

resp = completion(
    model="custom_openai/deepseek-v4.1-flash",
    api_key=os.environ["FIKRA_API_KEY"],
    api_base="https://api.fikraapi.co.ke/v1",
    messages=[{"role": "user", "content": "Summarise Nairobi traffic in one line."}],
)

print(resp["choices"][0]["message"]["content"])
