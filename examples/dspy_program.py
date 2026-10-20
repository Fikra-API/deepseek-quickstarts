"""DSPy program on the Fikra API DeepSeek lanes.

    pip install dspy
"""
import os

import dspy

lm = dspy.LM(
    "openai/deepseek-v4.1-flash",
    api_key=os.environ["FIKRA_API_KEY"],
    api_base="https://api.fikraapi.co.ke/v1",
)
dspy.configure(lm=lm)


class RouteSummariser(dspy.Signature):
    """Summarise a Nairobi traffic question in one sentence."""

    question: str = dspy.InputField()
    summary: str = dspy.OutputField()


predict = dspy.ChainOfThought(RouteSummariser)
print(predict(question="Why is Thika Road busy at 6am?").summary)
