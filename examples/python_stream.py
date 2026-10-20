"""Streaming Chat Completions with the OpenAI SDK.

    pip install openai
"""
import os

from openai import OpenAI

client = OpenAI(
    api_key=os.environ["FIKRA_API_KEY"],
    base_url="https://api.fikraapi.co.ke/v1",
)

stream = client.chat.completions.create(
    model="deepseek-v4.1-flash",
    messages=[{"role": "user", "content": "Count from 1 to 10."}],
    stream=True,
)

for chunk in stream:
    delta = chunk.choices[0].delta
    if delta.content:
        print(delta.content, end="", flush=True)
print()
