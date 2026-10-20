// Vercel AI SDK against the Fikra API DeepSeek lanes.
//
//   npm install ai @ai-sdk/openai-compatible
//   npx tsx examples/node_ai_sdk.ts
import { createOpenAICompatible } from "@ai-sdk/openai-compatible";
import { generateText } from "ai";

const fikra = createOpenAICompatible({
  name: "fikra",
  apiKey: process.env.FIKRA_API_KEY,
  baseURL: "https://api.fikraapi.co.ke/v1",
  includeUsage: true,
});

const { text, usage } = await generateText({
  model: fikra("deepseek-v4.1-flash"),
  prompt: "Explain what a DeepSeek lane is in one sentence.",
});

console.log(usage);
console.log(text);
