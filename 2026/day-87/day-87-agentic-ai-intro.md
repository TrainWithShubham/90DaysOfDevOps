# Day 87 – Introduction to Agentic AI for DevOps

## Objective
Learn Agentic AI basics for DevOps and test a local AI model with DevOps troubleshooting.

## Environment
- WSL Ubuntu
- Python virtual environment
- Docker, kubectl, Kind
- Ollama
- LangChain
- Local LLM

## Agentic AI
A normal LLM mainly answers questions. An AI agent combines an LLM with tools so it can inspect real systems.

```text
User Question -> LLM -> Agent -> DevOps Tools -> Result -> Explanation
```

The LLM is the **brain** and tools are the **hands**.

## Hands-on Work

### Environment Verification
The setup verification checked Python, Docker, kubectl, Kind, Ollama, and the local model. The preflight verification completed successfully.

### Module 1 – DevOps Explainer
The local model was tested with a Docker troubleshooting example. It successfully explained a duplicate container-name error in simple language.

```text
DevOps Error -> Local LLM -> Explanation
```

### Module 2 – Tool-Using Agent
The next module introduced tools that could inspect Docker resources.

```text
Question
   |
   v
LLM chooses a tool
   |
   v
Tool reads system information
   |
   v
LLM explains the result
```

During local testing, the tool-agent interaction had model compatibility/performance limitations. This was documented as a local model/tool limitation rather than recorded as a successful tool call.

## Key Lessons
- Ollama runs the LLM locally.
- LangChain connects the LLM with agent tools.
- An agent can reason about a question and select a tool.
- A model that answers text questions may not necessarily support the tool-calling behavior required by an agent framework.
- Verify the model, framework, and tools separately when troubleshooting.

## Interview Explanation
> Agentic AI combines an LLM with tools. The LLM provides reasoning and the tools allow the agent to inspect systems such as Docker or Kubernetes. In this lab I used Ollama for a local model and LangChain for the agent workflow. I also learned that model compatibility is important for tool calling.

## Day 87 Result
- Local Agentic AI environment prepared
- Setup verification completed
- Local LLM tested
- Docker error explanation completed successfully
- Tool-calling agent architecture studied
- Model/tool compatibility troubleshooting performed
- Ready for multi-tool agents and MCP
