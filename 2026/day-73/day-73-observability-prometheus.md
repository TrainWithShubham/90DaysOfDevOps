# Day 73 -- Introduction to Observability and Prometheus

## Overview

Today I started the observability block and learned the three pillars of
observability: metrics, logs, and traces. I also set up Prometheus with
Docker, practiced PromQL, added a sample application, debugged a scrape
issue, and explored Prometheus TSDB storage.

## Three Pillars of Observability

### Metrics

Numerical measurements over time, such as CPU usage, memory usage,
request count, and error rate. Prometheus is mainly used for metrics.

### Logs

Timestamped records of events such as application errors and database
failures. Logs help explain why something happened.

### Traces

The journey of a request across services, for example:

`Frontend → API → Payment Service → Database`

Simple way I remember them: - Metrics → What happened? - Logs → Why did
it happen? - Traces → Where did it happen?

## Monitoring vs Observability

Monitoring tells me when something is wrong, for example `CPU > 90%`.

Observability helps me investigate why something is wrong using metrics,
logs, and traces.

## Architecture

``` text
[Your App] --> metrics --> [Prometheus] --> [Grafana Dashboards]
[Your App] --> logs    --> [Promtail] --> [Loki] --> [Grafana]
[Your App] --> traces  --> [OTEL Collector] --> [Grafana/Debug]
[Host]     --> metrics --> [Node Exporter] --> [Prometheus]
[Docker]   --> metrics --> [cAdvisor] --> [Prometheus]
```

## Project Structure

``` text
day-73/
└── observability-stack/
    ├── docker-compose.yml
    └── prometheus.yml
```

## Prometheus Configuration

``` yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "notes-app"
    static_configs:
      - targets: ["notes-app:8000"]
```

Prometheus was configured to scrape targets every 15 seconds.

## Docker Compose

``` yaml
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    restart: unless-stopped

  notes-app:
    image: trainwithshubham/notes-app:latest
    container_name: notes-app
    ports:
      - "8000:8000"
    restart: unless-stopped

volumes:
  prometheus_data:
```

Started with:

``` bash
docker compose up -d
```

## Prometheus Concepts

-   Counter → normally increases. Example: total HTTP requests.
-   Gauge → can increase and decrease. Example: current memory usage.
-   Histogram → groups measurements into buckets, such as request
    duration.
-   Summary → similar to a histogram but calculates percentiles on the
    client side.
-   Labels → key-value information attached to metrics.
-   Time series → unique metric name plus label combination.

## PromQL Queries Practiced

``` promql
up
process_resident_memory_bytes
process_resident_memory_bytes / 1024 / 1024
count({__name__=~".+"})
prometheus_http_requests_total
prometheus_http_requests_total[5m]
rate(prometheus_http_requests_total[5m])
sum(rate(prometheus_http_requests_total[5m]))
prometheus_http_requests_total{code="200"}
prometheus_http_requests_total{code!="200"}
topk(5, prometheus_http_requests_total)
rate(prometheus_http_requests_total{code!="200"}[5m])
```

During the lab, `count({__name__=~".+"})` returned `936`.

## Counter vs Gauge

``` text
Counter → normally keeps increasing
Example → total HTTP requests

Gauge → can increase and decrease
Example → current memory usage
```

## Debugging -- Notes App Target Was DOWN

After adding the Notes App, Prometheus initially did not show the new
target. I restarted Prometheus so it would load the updated
configuration:

``` bash
docker compose restart prometheus
```

The Notes App then appeared, but Prometheus showed:

``` text
DOWN
Error scraping target: server returned HTTP status 404 Not Found
```

Prometheus was trying:

``` text
http://notes-app:8000/metrics
```

I tested it:

``` bash
curl -i http://localhost:8000/metrics
```

Result:

``` text
HTTP/1.1 404 Not Found
```

Then I tested the application:

``` bash
curl -i http://localhost:8000/
```

Result:

``` text
HTTP/1.1 200 OK
```

This confirmed:

``` text
Notes App container   → Running
Port 8000             → Reachable
Application /         → 200 OK
Application /metrics  → 404 Not Found
Prometheus target     → DOWN
```

The application was healthy, but this version did not expose a
Prometheus `/metrics` endpoint.

Important lesson:

`Application running does not automatically mean Prometheus metrics are available.`

## Prometheus Storage and TSDB

I checked Prometheus storage:

``` bash
docker exec prometheus du -sh /prometheus
```

It increased from:

``` text
544.0K → 548.0K
```

This showed that Prometheus was continuing to store metric samples.

In TSDB Status I observed:

``` text
Number of Series:      1040
Number of Chunks:      1040
Number of Label Pairs: 541
```

Prometheus uses a local TSDB and the lab notes a default retention of 15
days. Example retention configuration:

``` yaml
command:
  - '--config.file=/etc/prometheus/prometheus.yml'
  - '--storage.tsdb.retention.time=30d'
  - '--storage.tsdb.retention.size=1GB'
```

The `prometheus_data` volume keeps metric data outside the container so
it can survive container recreation while the volume exists.

## Cleanup

After completing the lab:

``` bash
docker compose down -v
```

This removed the Prometheus container, Notes App container, Compose
network, and Prometheus data volume. My existing Kind Kubernetes
container was left untouched.

## What I Learned

``` text
Application / System
        ↓
Expose Metrics
        ↓
Prometheus Scrapes Metrics
        ↓
Prometheus TSDB
        ↓
PromQL
        ↓
Understand System Behaviour
```

Day 73 helped me understand Prometheus scraping, metric types, labels,
time series, PromQL, storage, retention, and real troubleshooting when
an application does not expose a `/metrics` endpoint.
