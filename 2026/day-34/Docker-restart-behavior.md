**Docker restart behavior.**

---

# What just happened

when you direct killing your database container

You ran:

```bash
docker kill postgres_db
```

Then:

```text
postgres_db → Exited (137)
```

And it **did NOT restart**, despite:

```yaml
restart: always
```

---

# Why it didn’t restart

This is the key rule:

> **`restart: always` only works under the Docker daemon, not manual user intervention**

When you use:

* `docker stop`
* `docker kill`

Docker interprets that as:

> “The user explicitly wants this container stopped”

So it **will not restart it automatically**.

---

# How to prove restart policy works

Instead of killing it manually, simulate a failure *inside* the container:

### Option 1: Kill PID 1 inside container

```bash
docker exec postgres_db kill 1
```

Now check:

```bash
docker ps
```

You should see:

```text
postgres_db → restarting → Up again
```

---

### Option 2: Let it crash naturally (misconfig)

Temporarily break env:

```yaml
POSTGRES_PASSWORD: ""
```

Then:

```bash
docker compose up
```

It will crash → restart loop (because of `always`)

---

# Difference: `always` vs `on-failure`

### `restart: always`

* Restarts on:

  * crash
  * daemon restart
* Does NOT restart if *you manually stop/kill it*

---

### `restart: on-failure`

* Restarts **only if exit code ≠ 0**
* Does NOT restart on:

  * clean exit
  * manual stop

---

# Why your test behaved this way

```text
Exit code: 137
```

That means:

* SIGKILL (you killed it)
* Docker treats this as **intentional termination**

---

# Subtle but important Compose behavior

Also note:

Your `depends_on`:

```yaml
depends_on:
  pg-data:
    condition: service_healthy
```

Only affects:

* **startup order**

It does **NOT**:

* restart the web app if DB dies
* re-trigger dependency checks after startup

So your system now is:

```text
flask_app → running (but DB is gone)
redis → running
postgres → dead
```

---

# Real-world implication

This is why production systems use:

* retry logic in the app (you partially added it 👍)
* or orchestration (Kubernetes liveness/readiness probes)

---

# If you want DB to come back automatically after manual kill

You’d need to restart via Compose, not Docker:

```bash
docker compose restart pg-data
```

or:

```bash
docker compose up -d
```

---

# Quick Summary

* Your config is correct
* Your test method bypassed restart policy 
* `depends_on` is **not runtime dependency management**, only startup sequencing

---

