"""Strands Agents on the Fikra API DeepSeek lanes.

    pip install 'strands-agents[openai]'
"""
import os

from strands import Agent
from strands.models.openai import OpenAIModel

model = OpenAIModel(
    client_args={
        "api_key": os.environ["FIKRA_API_KEY"],
        "base_url": "https://api.fikraapi.co.ke/v1",
    },
    model_id="deepseek-v4.1-flash",
)

agent = Agent(model=model)
print(agent("Count the words in: Nairobi traffic is a classroom with 3 million students."))
