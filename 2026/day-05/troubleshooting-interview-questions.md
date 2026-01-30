**strong SRE / mid–senior DevOps engineer**.

---

# 🎤 MOCK SRE INTERVIEW — MODEL ANSWERS

---

## **Question 1**

**“You’re paged for elevated API latency. Where do you start and why?”**

**Answer:**

> I start with a **system-level snapshot** to understand blast radius before diving deep.
> First I check CPU, memory, disk, and network on the host or cluster. Latency is often caused by resource saturation rather than the app itself.
>
> Concretely:
>
> * `top` / `free -h` → CPU & memory pressure
> * `df -h` → disk saturation (often overlooked)
> * `ss -s` → connection spikes
>
> Once I know which resource is constrained, I zoom into the most likely service instead of guessing.

✅ *Why this is good:* calm, methodical, avoids tunnel vision.

---

## **Question 2**

**“PostgreSQL is running but the app is down. How do you prove it’s a DB issue?”**

**Answer:**

> “Running” only means the process exists — not that it’s healthy.
>
> I’d check:
>
> * Active connections vs `max_connections`
> * Query activity and wait states
> * Disk and IO latency
>
> For example:
>
> ```sql
> SELECT count(*) FROM pg_stat_activity;
> SHOW max_connections;
> ```
>
> If connections are exhausted or queries are stuck waiting on IO or locks, that’s strong evidence the database is the bottleneck.
> I also correlate with app logs showing connection timeouts or slow queries.

✅ *Key signal:* correlation between DB state and app symptoms.

---

## **Question 3**

**“Why is restarting the database dangerous? When is it acceptable?”**

**Answer:**

> Restarting a database is dangerous because it:
>
> * Drops all active connections
> * Interrupts in-flight transactions
> * Can cause cascading failures if apps aggressively reconnect
>
> I treat it as a **last-resort containment action**, not a fix.
>
> It’s acceptable when:
>
> * The database is completely wedged
> * Connection exhaustion prevents recovery
> * The business impact of downtime is already high
>
> Even then, I try lighter actions first: terminating idle sessions, throttling traffic, or fixing the upstream cause.

✅ *This shows maturity and production awareness.*

---

## **Question 4**

**“How does rate limiting protect downstream services?”**

**Answer:**

> Rate limiting applies **backpressure** at the edge.
>
> Instead of letting traffic overwhelm the backend, nginx rejects excess requests early with predictable behavior (like HTTP 429).
>
> This:
>
> * Preserves backend capacity for legitimate users
> * Prevents connection exhaustion
> * Avoids cascading failures into databases or caches
>
> It turns an uncontrolled failure into a controlled degradation.

✅ *This is exactly what interviewers want to hear.*

---

## **Question 5 (Senior-level)**

**“What signals tell you this is an app bug, not an infrastructure failure?”**

**Answer:**

> I look for **asymmetry**:
>
> * Infrastructure metrics are stable (CPU, disk, network OK)
> * Errors spike only for a specific endpoint or service
> * Logs show repeated stack traces or retries
> * DB connections grow without corresponding traffic increase
>
> That pattern usually points to:
>
> * Connection leaks
> * Unbounded retries
> * Inefficient queries
>
> Infra failures tend to affect multiple services at once; app bugs are usually isolated.

✅ *This separates juniors from seniors.*

---

## **Bonus Question**

**“What would you automate after surviving this incident?”**

**Answer:**

> I’d automate the *detection and prevention*, not just alerts:
>
> * Connection pool limits enforced by config
> * Automatic rate limiting under load
> * Disk usage alerts tied to log growth
> * Dashboards showing DB connections vs max
>
> I’d also update the runbook with exact commands used so the next on-call doesn’t rediscover them under pressure.

✅ *Runbook + automation = gold.*

---

# 🏆 How strong these answers are

If you said this in an interview:

* ✅ Clear thinking
* ✅ Real incident experience
* ✅ Calm under pressure
* ✅ Production-first mindset

This is **hire-level** for:

* SRE I / II
* DevOps Engineer
* Platform Engineer

---
