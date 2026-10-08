# Day 89 -- KubeHealer: AI-Powered Kubernetes Self-Healing

## Objective

Day 89 focused on AIOps using KubeHealer with Kubernetes, Temporal, and
Claude. The goal was to diagnose unhealthy Kubernetes workloads, propose
safe remediation, keep human control and guardrails, execute supported
fixes, escalate unsafe cases, and track workflow history with Temporal.

## 1. What is AIOps?

AIOps means using AI to help operate and troubleshoot IT systems.
Traditional monitoring can report that something is broken. AIOps can
also help explain why it is broken and propose a possible fix.

AI should not have unlimited control over production systems. Safe
automation needs guardrails.

## 2. Six Guardrails

1.  **Human Approval** -- important changes should require human
    approval.
2.  **Scope Limits** -- AI should only operate on approved resources and
    actions.
3.  **Audit Trail** -- diagnoses, proposed fixes, approvals, and results
    should be recorded.
4.  **Rollback** -- automation should have a recovery path if a change
    causes problems.
5.  **Timeout and Retry Limits** -- workflows should not retry forever.
6.  **Escalation** -- if the system cannot safely fix a problem, it
    should stop and ask a human.

## 3. Architecture

``` text
Broken Kubernetes Workload
          |
          v
     KubeHealer
       /     \
      v       v
Kubernetes   Claude AI
   API       Diagnosis
      \       /
       v     v
   Guardrails / Human Control
              |
              v
           Temporal
              |
              v
      Execute / Track Fix
              |
              v
       Kubernetes Workload
```

**Kubernetes** provided the workloads being diagnosed and repaired.

**Claude** analyzed Kubernetes information and helped generate diagnoses
and proposed remediation.

**Temporal** managed durable workflow execution and stored workflow
history.

**KubeHealer** connected Kubernetes, AI, safety controls, and workflow
execution.

## 4. Lab Environment

The lab used a local Kind Kubernetes cluster, a Python virtual
environment, KubeHealer, Temporal development server and Web UI,
Anthropic API integration, and the Kubernetes Python client.

No AWS infrastructure was required for Day 89.

## 5. Three Broken Applications

### Broken Image

The web workload used an incorrect container image.

**Symptom:** `ImagePullBackOff / ErrImagePull`

**Diagnosis:** Kubernetes could not pull the invalid image.

**Remediation:** Use a valid NGINX image.

### Memory Problem

The memory workload had an extremely small memory limit.

**Symptom:** `CrashLoopBackOff / Error`

**Diagnosis:** The container did not have enough memory to operate
correctly.

**Remediation:** Increase the memory resource configuration.

### Missing ConfigMap

The configuration workload referenced a ConfigMap that did not exist.

**Symptom:** `CreateContainerConfigError`

**Diagnosis:** Required application configuration was missing.

**Decision:** Escalate instead of blindly creating configuration that
could not safely be inferred.

This demonstrated an important AIOps rule: sometimes the safest
automated action is to make no change and ask a human.

## 6. KubeHealer Workflow

``` text
Detect
  ↓
Collect Kubernetes Information
  ↓
AI Diagnosis
  ↓
Proposed Remediation
  ↓
Safety / Human Control
  ↓
Execute Supported Action
  ↓
Verify Result
  ↓
Record Workflow History
```

The worker connected successfully to the required services and processed
workflow tasks.

## 7. Compatibility Issues Found

### Claude Model Compatibility

The repository referenced a Claude model identifier that was unavailable
through the configured API. The available model list was checked and the
configuration was updated to an available Claude Sonnet model so the lab
could continue.

### Kubernetes Resource Compatibility

A second issue involved assumptions in the remediation implementation.
Part of the remediation code expected Deployment-managed workloads,
while testing also exposed standalone-Pod behavior.

Kubernetes correctly rejected changing immutable resource fields on an
already-created standalone Pod.

### Lesson

A production healing system should first identify whether a Pod belongs
to a Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, or is a
standalone Pod before applying remediation.

## 8. Final Kubernetes Result

The final evidence showed the two repairable workloads healthy while the
missing-configuration case remained unresolved for escalation.

``` text
Configuration workload -> CreateContainerConfigError
Memory workload        -> Running
Web workload           -> Running
```

The final principle was:

``` text
Safe to repair automatically? -> Repair
Not enough information?       -> Escalate
```

## 9. Temporal Workflow Evidence

The Temporal Web UI displayed KubeHealer workflow history. During
troubleshooting, both running and failed workflow executions were
visible.

The failed executions are part of the real lab evidence because they
recorded compatibility problems encountered during testing.

Temporal also demonstrated the idea of **durable execution**: workflow
history remains available even when workers or individual execution
attempts encounter problems.

## 10. AI Healing vs Traditional Automation

  -----------------------------------------------------------------------
  Traditional Automation              AI-Assisted AIOps
  ----------------------------------- -----------------------------------
  Uses predefined rules               Can analyze operational context

  Requires known conditions           Can assist with unfamiliar symptoms

  Executes predetermined actions      Can propose remediation from
                                      evidence

  Limited reasoning                   Adds an AI reasoning layer

  Depends heavily on fixed            Can assist diagnosis, but still
  assumptions                         needs guardrails
  -----------------------------------------------------------------------

AI does not replace Kubernetes knowledge. Engineers still need to
understand controllers, permissions, resources, observability, rollback,
failure modes, and security.

## 11. Connection to Previous DevOps Topics

``` text
Docker
  ↓
Kubernetes
  ↓
Terraform
  ↓
GitHub Actions
  ↓
Ansible
  ↓
Helm
  ↓
EKS
  ↓
GitOps / Argo CD
  ↓
Agentic AI
  ↓
MCP / AI Tools
  ↓
AIOps / KubeHealer
```

Day 89 added a new question to the DevOps journey: can AI help
understand an operational failure and safely participate in remediation?

## 12. Cleanup

After collecting evidence: - The Day 89 Kind cluster was deleted. - The
Temporal development server was stopped. - The Python virtual
environment was deactivated. - No AWS resources were created for this
lab. - An unrelated local Kind cluster from earlier work was
intentionally left untouched.

## 13. Screenshot Evidence

Add these screenshots to the repository/documentation: - KubeHealer
worker, diagnosis, proposed remediation, or workflow execution. - Final
Kubernetes state showing the repaired workloads and escalation case. -
Temporal Web UI showing KubeHealer workflow history.

Before publishing, crop or blur credentials, API keys, tokens, internal
identifiers, and other sensitive information.

## 14. Problems and Lessons

The lab did not work perfectly on the first attempt. Issues included an
unavailable Claude model identifier, workload/remediation compatibility
assumptions, Kubernetes immutable Pod fields, and workflow failures
during testing.

These failures demonstrated a real DevOps responsibility: automation
must handle actual platform behavior rather than only the expected happy
path.

## 15. Interview Explanation

**Question: What did you do in your KubeHealer AIOps lab?**

I built a local Kubernetes AIOps lab using KubeHealer, Temporal, and
Claude. I tested image, memory, and configuration failures. The
AI-assisted workflow helped diagnose problems and propose remediation
while using safety guardrails. I also investigated compatibility issues
between Kubernetes workload types and remediation code. The repairable
workloads were recovered, while the unsafe configuration case was
escalated. Temporal provided durable workflow history and showed how AI
can safely support DevOps operations.

## 16. Main Takeaway

> **AI should assist operations, not receive uncontrolled access to
> operations.**

``` text
AI Reasoning
     +
Kubernetes Knowledge
     +
Human Control
     +
Guardrails
     +
Audit History
     +
Safe Remediation
     =
Responsible AIOps
```

## Day 89 Status

**Completed**

-   AIOps concepts and six guardrails covered
-   Local Kubernetes environment tested
-   KubeHealer and Claude integration tested
-   Three failure scenarios investigated
-   Supported remediation demonstrated
-   Escalation behavior demonstrated
-   Temporal workflow history captured
-   Final Kubernetes evidence captured
-   Environment cleaned up
