# Day 75 -- Log Management with Loki and Promtail

## Goal

Day 75 adds centralized log management to the observability stack.

**Metrics tell us what is happening. Logs help us understand why it is
happening.**

## Architecture

``` text
Docker Containers
       ↓
    Promtail
       ↓
      Loki
       ↓
    Grafana
```

Promtail collects Docker logs, Loki stores and queries them, and Grafana
displays Loki logs together with Prometheus metrics.

## Project Structure

``` text
day-75/
├── README.md
├── docker-compose.yml
├── prometheus.yml
├── loki/
│   └── loki-config.yml
├── promtail/
│   └── promtail-config.yml
└── grafana/
    └── provisioning/
        └── datasources/
            └── datasources.yml
```

## Services

The stack used Prometheus, Node Exporter, cAdvisor, Grafana, Notes App,
Loki, and Promtail.

## Loki

Loki listens on port `3100`. Readiness was tested with:

``` bash
curl http://localhost:3100/ready
```

The first response showed that the ingester was still waiting. After
startup completed, Loki returned:

``` text
ready
```

## Promtail

Promtail reads Docker JSON logs from:

``` text
/var/lib/docker/containers/*/*-json.log
```

and sends them to:

``` text
http://loki:3100/loki/api/v1/push
```

The positions file acts like a bookmark so Promtail remembers how far it
has read.

## Grafana Data Sources

Grafana was provisioned with:

``` text
Prometheus → http://prometheus:9090 → metrics
Loki       → http://loki:3100       → logs
```

Prometheus remained the default data source.

## Validation

Docker Compose configuration was checked with:

``` bash
docker compose config
```

The stack was started with:

``` bash
docker compose up -d
```

and verified with:

``` bash
docker compose ps
```

All seven services started.

## Troubleshooting: Old Docker Logs

Promtail initially received a Loki `400 Bad Request` because some
existing Docker log entries had timestamps that were too old.

Fresh application requests were generated:

``` bash
for i in $(seq 1 20); do
  curl -s http://localhost:8000 > /dev/null
done
```

A direct Loki query returned successful log streams afterward, proving
that the Promtail → Loki pipeline worked.

## LogQL Practiced

All Docker logs:

``` logql
{job="docker"}
```

Logs containing `error`:

``` logql
{job="docker"} |= "error"
```

Exclude logs containing `health`:

``` logql
{job="docker"} != "health"
```

Count logs over five minutes:

``` logql
count_over_time({job="docker"}[5m])
```

Log rate:

``` logql
rate({job="docker"}[5m])
```

Count error-containing logs over five minutes:

``` logql
count_over_time({job="docker"} |= "error" [5m])
```

## Metrics + Logs Together

The final Grafana dashboard displayed both data types side by side.

### Container CPU --- Prometheus

``` promql
rate(container_cpu_usage_seconds_total[5m]) * 100
```

### Docker Logs --- Loki

``` logql
{job="docker"}
```

Final flow:

``` text
              Grafana
             /       \
            /         \
   Prometheus          Loki
       ↑                ↑
    Metrics            Logs
       ↑                ↑
    cAdvisor         Promtail
                        ↑
                 Docker Containers
```

This allows troubleshooting using the same time range:

``` text
Prometheus shows a metric problem
              ↓
Check the same timestamp
              ↓
Loki shows the related logs
              ↓
Investigate why it happened
```

## Interview Explanation

**Prometheus tells me what is happening through metrics. Loki helps me
understand why it may be happening through logs. Grafana lets me view
both together and correlate them using the same time range.**

Prometheus uses **PromQL** for metrics. Loki uses **LogQL** for logs.

## Day 75 Result

-   Loki configured and running
-   Promtail collecting Docker logs
-   Loki readiness verified
-   Promtail → Loki pipeline verified
-   Prometheus and Loki available in Grafana
-   LogQL filtering and counting practiced
-   Error logs investigated
-   Prometheus metrics and Loki logs displayed together
-   Metrics/log correlation completed

**Day 75 completed successfully.**
