# Day 77 -- Observability Project: Full Stack with Docker Compose

## Goal

Build and verify a complete observability stack using Docker Compose.

The lab combines the concepts practiced in Days 73--76:

-   Prometheus for metrics
-   Node Exporter for host metrics
-   cAdvisor for container metrics
-   Loki for log storage/querying
-   Promtail for collecting Docker logs
-   OpenTelemetry Collector for telemetry/traces
-   Grafana for visualization
-   Notes App as the sample application

------------------------------------------------------------------------

## Architecture

``` text
Host Machine
    |
    +--> Node Exporter --------+
                               |
Docker Containers             v
    +--> cAdvisor --------> Prometheus ----+
                                           |
Docker Logs --> Promtail --> Loki ---------+--> Grafana
                                           |
Application --> OTEL Collector ------------+
                  |
                Traces
```

Simple meaning:

-   **Metrics** tell us WHAT is happening.
-   **Logs** help explain WHY it may be happening.
-   **Traces** show WHERE a request travelled.
-   **Grafana** gives us one place to view observability data.

------------------------------------------------------------------------

## Project Setup

Repository used:

``` bash
git clone https://github.com/LondheShubham153/observability-for-devops.git
cd observability-for-devops
```

Project structure:

``` text
.
├── README.md
├── assets
├── docker-compose.yml
├── grafana
│   └── provisioning
│       ├── dashboards
│       └── datasources
├── loki
│   └── loki-config.yml
├── notes-app
├── otel-collector
│   └── otel-collector-config.yml
├── prometheus.yml
└── promtail
    └── promtail-config.yml
```

------------------------------------------------------------------------

## Start the Stack

``` bash
docker compose up -d
```

Verify:

``` bash
docker compose ps
```

Services verified running:

``` text
cadvisor
grafana
loki
node-exporter
notes-app
otel-collector
prometheus
promtail
```

------------------------------------------------------------------------

## Prometheus Target Verification

Opened Prometheus and checked target health.

The following targets were **UP**:

``` text
docker / cAdvisor     -> cadvisor:8080
node-exporter         -> node-exporter:9100
otel-collector        -> otel-collector:8889
prometheus            -> localhost:9090
```

This proves Prometheus can successfully scrape the configured metric
exporters.

------------------------------------------------------------------------

## Metric Testing

### Host CPU

``` promql
node_cpu_seconds_total
```

This returned CPU metrics from Node Exporter.

### Container Memory

``` promql
container_memory_usage_bytes
```

This returned container resource metrics from cAdvisor.

Important lesson:

> Node Exporter monitors the host machine, while cAdvisor monitors
> containers.

------------------------------------------------------------------------

## OpenTelemetry Collector

Collector configuration:

``` yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch: {}

exporters:
  prometheus:
    endpoint: 0.0.0.0:8889
  debug:
    verbosity: basic

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

### Trace Test

A fresh OTLP trace was sent to:

``` text
http://localhost:4318/v1/traces
```

Then the collector logs were checked:

``` bash
docker logs otel-collector --since=1m 2>&1 | tail -50
```

Successful output included:

``` text
Traces
otelcol.signal: "traces"
resource spans: 1
spans: 1
```

This proves:

``` text
Trace
  ↓
OTLP HTTP Receiver :4318
  ↓
OpenTelemetry Collector
  ↓
Batch Processor
  ↓
Debug Exporter
  ↓
Trace processed successfully
```

In this lab, traces were verified through the collector's debug
exporter. A dedicated trace backend was not used for storing and
visualizing traces.

------------------------------------------------------------------------

## Loki and Promtail

Log flow:

``` text
Docker Containers
       ↓
    Promtail
       ↓
      Loki
       ↓
    Grafana
```

Grafana used Loki as the datasource for Docker logs.

LogQL query:

``` logql
{job="docker"}
```

Optional error filtering:

``` logql
{job="docker"} |= "error"
```

------------------------------------------------------------------------

## Final Grafana Dashboard

A unified Grafana dashboard was created.

### Panel 1 -- CPU Usage %

Datasource: **Prometheus**

``` promql
100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### Panel 2 -- Memory Usage %

Datasource: **Prometheus**

``` promql
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100
```

### Panel 3 -- Container Memory MB

Datasource: **Prometheus**

``` promql
container_memory_usage_bytes / 1024 / 1024
```

### Panel 4 -- Container CPU %

Datasource: **Prometheus**

``` promql
rate(container_cpu_usage_seconds_total[5m]) * 100
```

### Panel 5 -- Docker Logs

Datasource: **Loki**

``` logql
{job="docker"}
```

Final dashboard layout:

``` text
+------------------------+------------------------+
| Container Memory MB    | CPU Usage %            |
| cAdvisor + Prometheus  | Node Exporter          |
+------------------------+------------------------+
| Container CPU %        | Memory Usage %         |
| cAdvisor + Prometheus  | Node Exporter          |
+------------------------+------------------------+
|                 Docker Logs                     |
|               Promtail + Loki                   |
+-------------------------------------------------+
```

------------------------------------------------------------------------

## What Each Tool Does

  -----------------------------------------------------------------------
  Tool                                Simple Purpose
  ----------------------------------- -----------------------------------
  Prometheus                          Collects and stores metrics

  Node Exporter                       Exposes host CPU, RAM, disk and
                                      network metrics

  cAdvisor                            Exposes Docker container resource
                                      metrics

  Promtail                            Collects Docker logs

  Loki                                Stores and queries logs

  OpenTelemetry Collector             Receives and processes telemetry
                                      such as traces

  Grafana                             Visualizes and correlates
                                      observability data
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## Days 73--77 Learning Flow

``` text
Day 73
Prometheus + PromQL
        ↓
Day 74
Node Exporter + cAdvisor + Grafana
        ↓
Day 75
Loki + Promtail + LogQL
        ↓
Day 76
OpenTelemetry + Alerting
        ↓
Day 77
Full Observability Integration
```

------------------------------------------------------------------------

## Interview Explanation

> I built a Docker Compose observability stack. Node Exporter and
> cAdvisor expose infrastructure and container metrics to Prometheus.
> Promtail collects Docker logs and sends them to Loki. OpenTelemetry
> Collector receives telemetry such as traces. Grafana is used to
> visualize and correlate the observability data.

Short version:

> Prometheus gives me metrics, Loki gives me logs, OpenTelemetry handles
> telemetry and traces, and Grafana helps me view and correlate the
> information.

------------------------------------------------------------------------

## Cleanup

After completing and saving the dashboard:

``` bash
docker compose down -v
```

This removes the lab containers, network, and Compose volumes.

------------------------------------------------------------------------

## Final Result

Day 77 completed successfully.

Verified:

-   Docker Compose observability stack running
-   Prometheus targets UP
-   Node Exporter host metrics
-   cAdvisor container metrics
-   Loki/Promtail Docker logs
-   OpenTelemetry trace processing
-   Unified Grafana dashboard
-   Metrics + logs + traces concepts understood

**Day 77 -- Complete**
