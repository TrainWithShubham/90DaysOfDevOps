# Day 76 -- OpenTelemetry and Alerting

## Goal

Day 76 adds the third pillar of observability --- **traces** --- using
OpenTelemetry (OTEL), plus Prometheus and Grafana alerting.

The completed stack covers: - **Metrics** → Prometheus - **Logs** →
Loki - **Traces** → OpenTelemetry Collector - **Visualization and
alerts** → Grafana

## OpenTelemetry in Simple Words

OpenTelemetry (OTEL) is a vendor-neutral framework for generating,
collecting, processing, and exporting telemetry data.

The Collector follows this flow:

``` text
Application → Receiver → Processor → Exporter → Backend
```

-   **Receiver:** accepts telemetry.
-   **Processor:** prepares telemetry; this lab uses batching.
-   **Exporter:** sends telemetry to another system.

Ports used: - `4317` --- OTLP gRPC - `4318` --- OTLP HTTP - `8889` ---
Prometheus-compatible metrics endpoint

## Trace and Span

A **trace** is the complete journey of one request. A **span** is one
step inside that journey.

``` text
TRACE: User request
├── Span 1 → API
├── Span 2 → Authentication
└── Span 3 → Database
```

## Project Structure

``` text
day-76/
├── README.md
├── alert-rules.yml
├── docker-compose.yml
├── prometheus.yml
├── otel-collector/
│   └── otel-collector-config.yml
├── loki/
│   └── loki-config.yml
├── promtail/
│   └── promtail-config.yml
├── grafana/
│   └── provisioning/
│       └── datasources/
│           └── datasources.yml
└── day-76-otel-alerting.md
```

## OTEL Collector Configuration

``` yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:

exporters:
  prometheus:
    endpoint: "0.0.0.0:8889"
  debug:
    verbosity: detailed

service:
  pipelines:
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [prometheus]
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [debug]
    logs:
      receivers: [otlp]
      processors: [batch]
      exporters: [debug]
```

Metrics flow:

``` text
OTLP → OTEL Collector → :8889 → Prometheus
```

Trace flow:

``` text
OTLP → OTEL Collector → Debug output
```

## Services

  Service          Port             Purpose
  ---------------- ---------------- -----------------------------
  Prometheus       9090             Metrics storage/querying
  Node Exporter    9100             Host metrics
  cAdvisor         8080             Container metrics
  Grafana          3000             Dashboards and alerting
  Loki             3100             Log storage
  Promtail         9080 internal    Docker log collection
  OTEL Collector   4317/4318/8889   Telemetry collection/export
  Notes App        8000             Sample application

Final `docker compose ps` verification showed all eight services
running, with cAdvisor healthy.

## OTEL Collector Verification

Command:

``` bash
docker logs otel-collector 2>&1 | tail -10
```

Observed:

``` text
Starting GRPC server ... :4317
Starting HTTP server ... :4318
Everything is ready. Begin running and processing data.
```

Prometheus Targets showed `cadvisor`, `node-exporter`, `otel-collector`,
and `prometheus` UP. The OTEL scrape endpoint was `otel-collector:8889`.

## Test Trace

A sample OTLP trace was POSTed to:

``` text
http://localhost:4318/v1/traces
```

Verification:

``` bash
docker logs otel-collector 2>&1 | grep -A 15 "test-span"
```

Observed:

``` text
Name: test-span
Kind: Internal
http.method: GET
http.status_code: 200
otelcol.signal: traces
```

This proved:

``` text
curl → OTLP HTTP :4318 → Receiver → Batch Processor → Debug Exporter → docker logs
```

## Test OTLP Metric

A metric named `test_requests_total` with value `42` was sent through
OTLP.

PromQL:

``` promql
test_requests_total
```

Result:

``` text
test_requests_total = 42
```

Labels included `exported_job="my-test-service"`,
`instance="otel-collector:8889"`, and `job="otel-collector"`.

Flow:

``` text
curl → OTEL :4318 → Prometheus exporter :8889 → Prometheus → PromQL → 42
```

## Prometheus Alert Rules

Five rules were configured:

-   **HighCPUUsage:** CPU above 80% for 2 minutes; severity `warning`.
-   **HighMemoryUsage:** memory above 85% for 2 minutes; severity
    `warning`.
-   **ContainerDown:** expected Notes App cAdvisor series absent for 1
    minute; severity `critical`.
-   **TargetDown:** `up == 0` for 1 minute; severity `critical`.
-   **HighDiskUsage:** root disk above 90% for 5 minutes; severity
    `critical`.

Alert lifecycle:

``` text
INACTIVE → condition true → PENDING → "for:" duration passes → FIRING
```

When the condition clears, the alert returns to inactive.

## TargetDown Test

Node Exporter was deliberately stopped:

``` bash
docker compose stop node-exporter
```

Prometheus could not scrape `node-exporter:9100`, so `up == 0` became
true.

Observed:

``` text
TargetDown: INACTIVE → PENDING → FIRING
```

Node Exporter was restored:

``` bash
docker compose start node-exporter
```

This successfully demonstrated a real Prometheus alert lifecycle.

## Debugging Lesson: ContainerDown

`ContainerDown` fired even though Notes App was running.

Rule:

``` promql
absent(container_last_seen{name="notes-app"})
```

The query returned `1`, meaning the matching time series was absent. We
also found:

``` promql
container_memory_usage_bytes{name!=""}
```

returned no data, while unfiltered `container_memory_usage_bytes`
returned data.

The cAdvisor data in this environment did not expose the expected
`name="notes-app"` label. Therefore the alert query did not match the
real labels.

**Lesson:** a firing alert does not automatically prove an application
is broken. Check the PromQL expression and actual metric labels.

## Grafana Contact Point

Created:

``` text
Name: DevOps Team
Integration: Email
```

Flow:

``` text
Alert → Notification policy → Contact point → Email/Slack/PagerDuty/etc.
```

Actual email delivery from a local Docker Grafana setup also requires
suitable SMTP configuration.

## Grafana Alert Rule

Created:

``` text
High Container Memory
```

Datasource: `Prometheus`

Working query for this environment:

``` promql
container_memory_usage_bytes / 1024 / 1024
```

Configuration:

``` text
Threshold: IS ABOVE 100 MB
Evaluation interval: 1m
Pending period: 2m
Label: severity=warning
Contact point: DevOps Team
Folder: DevOps Alerts
Evaluation group: DevOps Evaluation
```

The saved rule displayed `High Container Memory → Normal`.

## Prometheus Alerts vs Grafana Alerts

**Prometheus alerts** evaluate PromQL conditions directly against
metrics. In this lab, Prometheus displayed the alert state. Without
Alertmanager, the Prometheus setup did not provide the notification
routing used here.

**Grafana alerts** can evaluate metric conditions and route firing
alerts to configured contact points.

## Full Architecture

``` text
                    METRICS
Node Exporter ─────┐
cAdvisor ──────────┼──→ Prometheus ──→ Grafana
OTEL :8889 ────────┘         │
                             └──→ Alert Rules

                     LOGS
Docker Containers → Promtail → Loki → Grafana

                    TRACES
Application/curl → OTLP :4318 → OTEL Collector → Debug Output
                                           └──→ Future: Jaeger/Tempo
```

## Three Pillars

-   **Metrics:** WHAT happened? Example: CPU 85%, memory 90%.
-   **Logs:** WHY did it happen? Example: ERROR, HTTP 404.
-   **Traces:** WHERE did it happen in the request journey?

``` text
Metrics → WHAT?
Logs    → WHY?
Traces  → WHERE?
```

## Useful Commands

``` bash
docker compose up -d
docker compose ps
docker logs otel-collector
docker logs otel-collector 2>&1 | grep -A 15 "test-span"
docker compose stop node-exporter
docker compose start node-exporter
docker compose down -v
```

## Interview Explanation

> I built a Docker Compose observability stack using Prometheus,
> Grafana, Loki, Promtail, Node Exporter, cAdvisor, and OpenTelemetry.
> Prometheus collected metrics, Loki stored logs, and OpenTelemetry
> handled OTLP telemetry and traces. I also created Prometheus and
> Grafana alerts and tested a TargetDown alert by stopping Node
> Exporter.

OpenTelemetry: \> The OpenTelemetry Collector receives telemetry,
processes it, and exports it. In my lab it received OTLP data on ports
4317 and 4318. Metrics were exposed for Prometheus on port 8889, while
traces were sent to the debug exporter.

Alert lifecycle: \> An alert starts inactive. When its condition becomes
true, it can become pending. If the condition stays true for the
configured pending period, it becomes firing. When the condition clears,
it returns to normal.

## Final Result

``` text
OpenTelemetry Collector       DONE
OTLP gRPC :4317               DONE
OTLP HTTP :4318               DONE
Prometheus exporter :8889     DONE
Test trace                    DONE
test-span in OTEL logs        DONE
OTLP test metric              DONE
test_requests_total = 42      DONE
Prometheus alert rules        DONE
TargetDown test               DONE
Grafana contact point         DONE
Grafana memory alert          DONE
8-service stack verification  DONE
```

Day 76 successfully added **traces and alerting** to the existing
metrics-and-logs observability stack.
