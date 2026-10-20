"""CrewAI agent running on the Fikra API DeepSeek lanes.

    pip install crewai
"""
import os

from crewai import Agent, Crew, Task

agent = Agent(
    role="Route analyst",
    goal="Summarise Nairobi traffic patterns",
    backstory="A logistics analyst who watches matatu routes.",
    llm="openai/deepseek-v4.1-flash",
    base_url="https://api.fikraapi.co.ke/v1",
    api_key=os.environ["FIKRA_API_KEY"],
)

crew = Crew(
    agents=[agent],
    tasks=[
        Task(
            description="In one sentence, why is Thika Road busy at 6am?",
            expected_output="One sentence.",
        )
    ],
)

print(crew.kickoff())
