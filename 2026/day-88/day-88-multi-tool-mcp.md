# Day 88 – Multi-Tool Agents, MCP, and CI/CD Analysis

## Objective
Work with multiple DevOps tools, learn Model Context Protocol (MCP), troubleshoot Kubernetes through MCP, inspect GitHub Actions failures, and build a custom tool.

## Environment
- WSL Ubuntu
- Python virtual environment
- Docker, kubectl, Kind
- Ollama with `gemma4`
- LangChain
- FastMCP
- GitHub CLI (`gh`)

## Task 1 – Multi-Tool Agent
The multi-tool lab introduced Docker and Kubernetes tools that an AI agent can choose from. A deliberately broken Docker container and Kubernetes pod were created for troubleshooting practice.

The Kubernetes test pod used an invalid image and entered `ImagePullBackOff`.

```text
User -> LLM -> ReAct Agent -> Docker/Kubernetes Tools -> Result -> Answer
```

The earlier local multi-tool agent test experienced a model/tool execution delay. The resources were verified independently, and the later MCP implementation successfully diagnosed the Kubernetes problem.

## Task 2 – MCP
MCP stands for **Model Context Protocol**. It provides a standard way for AI clients to connect to external tools and data.

```text
AI Client / Agent
        |
       MCP
        |
        v
    MCP Server
        |
        +-- Kubernetes tools
        +-- Pod details
        +-- Events
```

The lab used an MCP server, MCP client, reusable tools, and `stdio` transport.

## Task 3 – Kubernetes MCP Server and Client
The lab used:

```text
module-3/mcp_server.py
module-3/agent_with_mcp.py
```

The exact lab model, `gemma4`, was installed in Ollama. FastMCP started successfully with the **Kubernetes Tools** server using `stdio`.

The agent listed pods in the default namespace and detected the deliberately broken pod in `ImagePullBackOff`.

When asked why the pod was not running, the MCP agent inspected Kubernetes information and correctly determined that the configured container image did not exist. It explained that the image name needed to point to a valid published image.

```text
Question -> gemma4 -> MCP Client -> Kubernetes MCP Server
         -> Kubernetes information -> LLM explanation
```

This successfully demonstrated MCP tool discovery and Kubernetes troubleshooting.

## Task 4 – CI/CD Failure Analyzer
The CI/CD analyzer was run inside an existing Git repository with GitHub Actions history.

It used GitHub CLI to inspect workflow runs and successfully located a previous failed workflow. When it attempted to retrieve the detailed logs, GitHub returned:

```text
HTTP 410: Server Error
```

The detailed historical logs were therefore unavailable, so the agent correctly stated that it could not provide a detailed root-cause analysis.

This is documented as an external log-availability limitation, not as a successful failure-log diagnosis.

```text
User -> AI Agent -> GitHub CLI -> Workflow Runs / Logs -> Analysis
```

## Task 5 – Custom Log Searcher
A custom LangChain tool named `search_logs` was created in:

```text
log_search_tool.py
```

It accepts a log file and search pattern, scans the file, and returns matching lines.

Testing with the pattern `ERROR` successfully returned:

```text
Line 2: ERROR Database connection failed
Line 4: ERROR Connection timeout
```

This demonstrated how a custom DevOps operation can be wrapped as an AI-agent tool.

## Task 6 – Cleanup
The temporary broken resources were cleaned up:
- Broken Docker container removed
- Broken Kubernetes pod deleted
- Docker verified clean for that test container
- No resources remained in the default Kubernetes namespace

The existing local Kind cluster was retained for later local labs. No AWS infrastructure was created for Day 88.

## Key Lessons

### ReAct
```text
Think -> Choose Tool -> Run Tool -> Read Result -> Answer
```

### MCP
MCP separates the AI client from tool implementations and provides a standard interface for discovering and using tools.

### CI/CD Agent
An AI agent can use GitHub CLI to inspect workflow history and logs, but it is limited by the data GitHub still makes available.

### Custom Tools
Existing scripts and command-line operations can be wrapped as tools and made available to an AI agent.

## Interview Explanation
> On Day 88 I worked with multi-tool AI agents and MCP. I ran a FastMCP Kubernetes server over stdio and connected an AI client using the local gemma4 model. The agent discovered Kubernetes tools through MCP and diagnosed an ImagePullBackOff issue caused by an invalid image. I also tested a GitHub Actions failure analyzer and built a custom log-search tool.

## Screenshot Evidence
Keep screenshots showing:
- FastMCP Kubernetes server using `stdio`
- MCP agent detecting and diagnosing the broken pod
- CI/CD analyzer finding a failed workflow
- Custom Log Searcher returning error lines

Before publishing screenshots, crop or blur credentials, tokens, account information, and infrastructure identifiers.

## Day 88 Result
- Multi-tool agent architecture studied
- MCP concepts understood
- FastMCP Kubernetes server started successfully
- MCP client successfully used Kubernetes tools
- Broken Kubernetes pod diagnosed through MCP
- CI/CD analyzer inspected workflow history
- Historical logs were unavailable due to HTTP 410
- Custom Log Searcher built and tested
- Temporary resources cleaned up
- Day 88 hands-on lab completed
