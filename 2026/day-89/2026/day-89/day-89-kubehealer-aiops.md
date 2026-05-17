# Day 89 -- Production AI Agents: KubeHealer and AIOps
---

## Challenge Tasks

### Task 1: Understand AIOps and Production Guardrails (Module 4)
Before building production agents, understand the rules:

1. **What is AIOps?**
   - Using AI to automate IT operations: monitoring, diagnosis, remediation
   - Not replacing humans -- augmenting them with intelligent automation
   - The agent handles routine issues (image typos, resource limits) while escalating complex ones

2. **Production guardrails every AI agent needs:**

| Guardrail | Why | Example |
|-----------|-----|---------|
| **Human approval** | Agents should not make destructive changes without permission | "I found 3 broken pods. Here are the fixes. Approve?" |
| **Scope limits** | Agents should only operate in allowed namespaces/clusters | Cannot touch `kube-system` or production databases |
| **Audit trail** | Every action must be recorded | Temporal workflow history: every tool call, every decision |
| **Rollback capability** | Every fix must be reversible | Agent creates patches, not replacements |
| **Timeout and retry limits** | Agents must not loop forever | Max 3 retries per pod, timeout after 5 minutes |
| **Escalation path** | When the agent cannot fix it, alert a human | "config-app needs a ConfigMap I cannot create. Escalating." |

3. **Why durable execution (Temporal) matters:**
   - Without durability: if the agent crashes mid-diagnosis, you lose all progress and state
   - With Temporal: every step is recorded. If the worker crashes and restarts, Temporal replays completed steps from history and resumes
   - This is critical for agents that modify infrastructure -- you cannot afford partial fixes

4. **When to use AI agents vs traditional automation:**

| Use AI Agents When | Use Traditional Automation When |
|--------------------|---------------------------------|
| Problem requires reasoning (diagnose unknown errors) | Problem has a known, fixed solution |
| Multiple possible causes and fixes | One cause, one fix (if X then Y) |
| Natural language output helps humans | No human in the loop |
| Examples: troubleshooting, root cause analysis | Examples: scaling, restarts, deploys |

---

### Task 2: Set Up KubeHealer
KubeHealer lives in a separate repository. Clone it:

```bash
git clone https://github.com/TrainWithShubham/kubehealer.git
cd kubehealer
```

![image](images/repo_clone.png)

**Prerequisites:**
- Docker (for Temporal)
- Kind (for Kubernetes cluster)
- Python 3.10+
- An Anthropic API key (Claude Sonnet 4 -- sign up at https://console.anthropic.com)
- Download temporal cli & check version
    - wget "https://temporal.download/cli/archive/latest?platform=linux&arch=amd64"
    - mv "latest?platform=linux&arch=amd64" temporal-cli.tar.gz
    - sudo mv temporal /usr/local/bin/
    - sudo chmod +x /usr/local/bin/temporal
    - temporal --version

![image](images/Prerequisites.png)

**Create the cluster and deploy broken apps:**

1. Create the cluster and deploy broken apps:
```bash
./setup.sh
```
This creates a Kind cluster called `kubehealer` and deploys 3 intentionally broken apps. You should see:

```
Pod status:
  web-app-xxx       0/1     ErrImagePull
  memory-hog-xxx    0/1     CrashLoopBackOff
  config-app-xxx    0/1     CreateContainerConfigError
```

![image](images/kubehealer_cluster.png)


![image](images/ku_get_pods.png)

2. Start Temporal (durable execution engine):
```bash
temporal server start-dev
```

This runs Temporal locally. The UI is available at `http://localhost:8233`.

![image](images/temporal_srver_start.png)


![image](images/temporal_dashboard.png)


3. Set up the Python environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

![image](images/setup_py_env.png)

4. Set your Anthropic API key:
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```
![image](images/antthropic_api_key.png)
---

### Task 3: Deploy Broken Applications
KubeHealer needs something to fix. Deploy three intentionally broken applications:

- No need to deploy
- Already done in Task2

---

### Task 4: Run KubeHealer
Start the Temporal worker (the agent):
```bash
python3 worker.py
```

![image](images/start_worker.png)

Start the CLI
```bash
python3 cli.py
```
```
you> how many pods are running?
you> what's wrong with web-app?
you> show me the logs for memory-hog
you> heal my cluster
you> approve all fixes
```

**Watch the agent work.** It will:

1. **Scan** -- list all pods, identify broken ones
2. **Diagnose** -- for each broken pod, call `kubectl describe`, read events, send to Claude
3. **Propose fixes:**
   - `web-app`: "Image typo. Fix: change `ngnix:latest` to `nginx:latest`"
   - `memory-app`: "OOMKilled. Fix: increase memory limit to 128Mi"
   - `config-app`: "Missing ConfigMap `app-config`. Cannot fix automatically -- requires manual ConfigMap creation"
4. **Ask for approval** -- presents all fixes and waits for human input

In the terminal, you will see:
```
Found 3 broken pods.

Proposed fixes:
1. web-app: Fix image typo (ngnix -> nginx)
2. memory-app: Increase memory limit (1Mi -> 128Mi)
3. config-app: CANNOT FIX - needs manual ConfigMap creation

Approve all fixes? [yes/no]:
```

Type `yes`. The agent:
- Patches `web-app` with the correct image
- Patches `memory-app` with increased memory
- Skips `config-app` and reports it needs human attention

Verify:
```bash
kubectl get pods
```

`web-app` and `memory-app` should now be Running. `config-app` still broken (as expected).

![image](images/kube_ai_assisant.png)


### Fix config-app manually

The agent told you config-app needs a ConfigMap. Create it:

```bash
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=APP_DEBUG=false
kubectl rollout restart deployment config-app
```

Verify:
```bash
kubectl get pods
```

`Now all 3 pods should be healthy.`


![image](images/kube_ai_assisant2.png)


![image](images/all_healthy_pod.png)


![image](images/temporal_workflow_dash.png)

### Task 5: Test Crash Recovery (Temporal Durability)
This is the production-grade feature. Temporal makes the agent crash-resistant.

**Redeploy the broken apps:**
```bash
./setup.sh
```

![image](images/redeploy.png)

**Start healing**
In the CLI:
```bash
you> heal my cluster
```
Watch the agent start scanning and diagnosing.


![image](images/second_healing.png)

**Kill the worker**

While the agent is mid-diagnosis, go to Terminal (worker) and press **Ctrl+C**.

The workflow is now stuck. Open http://localhost:8233 -- you'll see the workflow in "Running" state with some activities completed and the current one pending.

![image](images/kill_worker.png)

**Restart the worker**

```bash
python worker.py
```
![image](images/2nd_restart_worker.png)

Go back to the Temporal UI. The workflow resumes immediately. Activities that already completed (scan, some diagnoses) are NOT re-executed -- Temporal replays them from cached results. Only the remaining work runs.

The CLI gets the response as if nothing happened.

This is durable execution. The agent's state lives in Temporal, not in the Python process.


![image](images/second_kube_assistant.png)

**Kill the CLI**

You can also kill the CLI (Ctrl+C) and restart it:

```bash
python cli.py
```

It reconnects to the same conversation. Your chat history is preserved.

![image](images/kill_cli.png)

**Temporal UI**

Open http://localhost:8233 in your browser.

Click on any completed workflow. Go to the History tab. You'll see every event:

- `WorkflowExecutionStarted`
- `ActivityTaskScheduled` (call_claude)
- `ActivityTaskCompleted` (Claude's response)
- `ActivityTaskScheduled` (list_pods -- Claude called a tool)
- `ActivityTaskCompleted` (pod list returned)
- `ActivityTaskScheduled` (call_claude -- with tool result)
- `ActivityTaskCompleted` (Claude's final answer)
- ...and so on for every interaction

This is your audit trail. Every Claude call, every tool invocation, every fix -- all recorded with zero custom logging code. If someone asks "what did the AI agent do to our cluster?", the answer is in the workflow history.
---

### Task 6: Reflect on the Agentic AI Journey
Map the 3-day progression:

| Day | Module | What You Built | Pattern |
|-----|--------|---------------|---------|
| 87 | 0-2 | Docker Error Explainer + Docker Agent | Basic LLM -> ReAct Agent |
| 88 | 3, 6 | Multi-tool Agent + MCP Server + CI/CD Analyzer | Multi-domain tools, MCP protocol |
| 89 | 4-5 | KubeHealer -- production self-healing agent | Temporal durability, human approval, guardrails |

**The evolution:**
```
Day 87: LLM explains errors (passive)
   |
Day 88: Agent diagnoses across Docker/K8s/CI (autonomous investigation)
   |
Day 89: Agent diagnoses AND fixes with approval (autonomous action)
```

**Key principles for production AI agents:**
1. **Tools are just CLI wrappers** -- any command you run can become a tool
2. **The ReAct pattern is universal** -- works for any domain
3. **MCP standardizes tool access** -- write once, use everywhere
4. **Guardrails are not optional** -- approval, scope limits, audit trails
5. **Durability matters** -- Temporal prevents lost state during infrastructure changes
6. **Know when NOT to use AI** -- simple if/then automation is better for known problems


**Clean up:**
```bash
kind delete cluster --name kubehealer
# Stop Temporal (Ctrl+C the server)
deactivate
```
![imgae](images/delete_cluster.png)
---

**AIOps principles and the 6 production guardrails**

## AIOps Principles

1. Tools are deterministic interfaces over external systems (CLI, APIs, CRDs)
2. Reasoning patterns like ReAct are useful but must be constrained in production
3. Standard tool protocols improve portability and consistency
4. Guardrails are mandatory for safety, auditability, and control
5. Durable execution systems (e.g., Temporal) ensure state survives failures
6. Prefer deterministic automation over AI for well-defined problems

## Production Guardrails

| Guardrail      | Purpose                | Example                            |
| -------------- | ---------------------- | ---------------------------------- |
| Human approval | Prevent unsafe actions | Confirm production changes         |
| Scope limits   | Restrict blast radius  | Only allow specific namespaces     |
| Audit trail    | Full traceability      | Log all tool calls + decisions     |
| Safe rollback  | Recovery mechanism     | Versioned configs or compensations |
| Retry limits   | Prevent runaway loops  | Max retries per failing pod        |
| Escalation     | Handle unknown cases   | Alert human with full context      |



**KubeHealer architecture: Temporal + Claude + kubectl**

```
CLI (thin terminal)                    Temporal Worker
  |                                         |
  |-- update(send_message, "how many") --->|
  |                                    ConversationWorkflow
  |                                    ├─ activity: call_claude (understand intent)
  |                                    ├─ activity: kubernetes_read (list_pods)
  |                                    ├─ activity: call_claude (analyze result)
  |                                    └─ returns response via update
  |<-- "I see 5 pods running..." ----------|
  |                                         |
  |-- update(send_message, "heal it") ---->|
  |                                    ├─ activity: call_claude (plan diagnosis)
  |                                    ├─ activity: scan_cluster
  |                                    ├─ activity: get_pod_details (x3)
  |                                    ├─ activity: diagnose_pod (x3)
  |                                    ├─ activity: call_claude (summarize issues)
  |                                    ├─ activity: kubernetes_write (start_healing)
  |<-- response with diagnoses ------------|

```

**The 3 broken apps and what the agent diagnosed for each**

| Broken App | Problem | AI Diagnosis | Auto-Fix |
|---|---|---|---|
| web-app | Image "nginx:latestt" (typo) | Detects typo | Patches to nginx:latest |
| memory-hog | 10Mi limit + stress 100M | OOMKilled | Patches to 256Mi |
| config-app | Missing ConfigMap | Can't auto-fix | Skips with explanation |

**How crash recovery works (kill worker, restart, resume)**
> When a worker crashes, Temporal automatically detects the failure and reassigns the workflow to another worker. The workflow resumes from the last recorded state using event history. Completed activities are not re-executed; only unfinished steps are retried. The CLI sees a continuous execution because state is stored in Temporal, not in the worker process.


**When to use AI agents vs traditional automation**

| Use AI Agents When | Use Traditional Automation When |
|--------------------|---------------------------------|
| Problem requires reasoning (diagnose unknown errors) | Problem has a known, fixed solution |
| Multiple possible causes and fixes | One cause, one fix (if X then Y) |
| Natural language output helps humans | No human in the loop |
| Examples: troubleshooting, root cause analysis | Examples: scaling, restarts, deploys |

**How agentic AI connects to every other topic in the 90-day challenge**

| Day | Connection to Agentic AI |
|-----|-------------------------|
| 29-37 (Docker) | Docker tools in Module 2 wrap the same commands you learned |
| 40-49 (GitHub Actions) | CI/CD Analyzer in Module 6 diagnoses the pipelines you built |
| 50-67 (Kubernetes) | Kubernetes tools in Module 3 and KubeHealer use kubectl |
| 73-77 (Observability) | Agents could query Prometheus/Loki for metric-based diagnosis |
| 84-86 (ArgoCD) | An agent could trigger ArgoCD syncs or rollbacks |
---
