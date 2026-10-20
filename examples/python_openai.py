"""OpenAI SDK against the Fikra API DeepSeek lanes.

    pip install openai
"""
import os

from openai import OpenAI

client = OpenAI(
    api_key=os.environ["FIKRA_API_KEY"],
    base_url="https://api.fikraapi.co.ke/v1",
)

resp = client.chat.completions.create(
    model="deepseek-v4.1-flash",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Explain what an inference endpoint is in one sentence."},
    ],
    temperature=0.3,
)

print(resp.usage)  # prompt_tokens, completion_tokens, total_tokens
print(resp.choices[0].message.content)
