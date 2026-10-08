# Day 74 -- Exporters and Grafana

## Overview

Today I continued the observability lab by adding exporters and Grafana
to the Prometheus setup.

I worked with: - Prometheus - Node Exporter - cAdvisor - Grafana -
Docker Compose - PromQL - Notes App

The goal was to collect host and container metrics with exporters, query
them with Prometheus, and visualize them in Grafana.

## Architecture

``` text
Host / WSL
   |
   +--> Node Exporter :9100 ----+
   |                            |
Docker Containers               |
   |                            v
   +--> cAdvisor :8080 ----> Prometheus :9090
                                |
                                v
                           Grafana :3000
```

Node Exporter provides host/system metrics. cAdvisor provides container
metrics. Prometheus scrapes the metrics, and Grafana displays them.

## Docker Compose Stack

The completed lab used: - Prometheus -- port 9090 - Notes App -- port
8000 - Node Exporter -- port 9100 - cAdvisor -- port 8080 - Grafana --
port 3000

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

  - job_name: "node-exporter"
    static_configs:
      - targets: ["node-exporter:9100"]

  - job_name: "cadvisor"
    static_configs:
      - targets: ["cadvisor:8080"]
```

## Node Exporter

Node Exporter exposed host metrics such as CPU, memory, filesystem,
network, and system load.

I verified it with:

``` bash
curl http://localhost:9100/metrics | head -20
```

Prometheus showed `node-exporter` as UP.

### CPU

``` promql
node_cpu_seconds_total{mode="idle"}
```

CPU usage percentage:

``` promql
100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### Memory

``` promql
node_memory_MemAvailable_bytes
```

Memory usage percentage:

``` promql
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100
```

## cAdvisor

cAdvisor collected Docker/container metrics and Prometheus showed
`cadvisor:8080` as UP.

The cAdvisor interface displayed CPU, memory, and network information.

### cAdvisor Label Debugging

The lab-style query:

``` promql
container_memory_usage_bytes{name!=""}
```

returned no data in my environment.

I tested the base metric:

``` promql
container_memory_usage_bytes
```

and Prometheus returned many results. The returned metrics had labels
such as `id`, `instance`, and `job`, but no usable `name` label.

So I adapted the query to the labels actually available:

``` promql
container_memory_usage_bytes / 1024 / 1024
```

For container CPU:

``` promql
rate(container_cpu_usage_seconds_total[5m]) * 100
```

This taught me to inspect the real metric labels before assuming an
exporter is broken.

## Prometheus Targets

During the lab:

``` text
Prometheus      UP
Node Exporter   UP
cAdvisor        UP
Notes App       DOWN
```

The Notes App returned HTTP 404 for `/metrics`. The application itself
was reachable, but that image did not expose a Prometheus metrics
endpoint.

Important lesson:

``` text
Application running != Prometheus metrics endpoint available
```

## Grafana

Grafana ran at:

``` text
http://localhost:3000
```

Prometheus was configured inside Grafana with:

``` text
http://prometheus:9090
```

The Windows browser uses `http://localhost:9090`, while the Grafana
container uses `http://prometheus:9090` because Docker service names
resolve inside the Docker network.

## Grafana Dashboard

Dashboard name:

``` text
DevOps Observability Overview
```

### CPU Usage %

``` promql
100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

Visualization: Gauge

### Memory Usage %

``` promql
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100
```

Visualization: Gauge

### Container CPU Usage

``` promql
rate(container_cpu_usage_seconds_total[5m]) * 100
```

Visualization: Time series

### Container Memory (MB)

``` promql
container_memory_usage_bytes / 1024 / 1024
```

Visualization: Bar chart

### Disk Usage %

``` promql
(1 - node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100
```

Visualization: Stat

## Grafana Provisioning

I created:

``` text
grafana/
└── provisioning/
    ├── datasources/
    └── dashboards/
```

Prometheus datasource provisioning:

``` yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
    editable: false
```

This lets Grafana configure the Prometheus datasource automatically.

## Imported Node Exporter Dashboard

I imported Grafana dashboard ID `1860` (Node Exporter Full).

It successfully displayed: - CPU Busy - System Load - RAM Used - Swap
Used - Root filesystem usage - CPU cores - Total RAM - Uptime - CPU
graphs - Memory graphs - Network traffic - Disk usage

This confirmed:

``` text
Host
 ↓
Node Exporter
 ↓
Prometheus
 ↓
Grafana
 ↓
Dashboard
```

## Useful Commands

Start:

``` bash
docker compose up -d
```

Validate:

``` bash
docker compose config
```

Check containers:

``` bash
docker compose ps
```

Check Node Exporter:

``` bash
curl http://localhost:9100/metrics | head -20
```

Restart Prometheus after configuration changes:

``` bash
docker compose restart prometheus
```

Destroy the Day 74 stack and its volumes:

``` bash
docker compose down -v
```

## What I Learned

I learned that exporters expose metrics for Prometheus. Node Exporter
provides host metrics, while cAdvisor provides container metrics.

Prometheus collects and queries the metrics, and Grafana visualizes
them.

I also learned an important troubleshooting lesson: a PromQL query can
return no data because the labels available in my environment differ
from the labels expected by the example query. I should inspect the raw
metric and its labels first.

The complete observability flow is:

``` text
Infrastructure / Containers
          ↓
       Exporters
          ↓
      Prometheus
          ↓
        Grafana
          ↓
      Dashboards
```

## Cleanup

After the lab:

``` bash
docker compose down -v
```

This removes the Day 74 containers, Compose network, and volumes. The
separate Kind Kubernetes container is unrelated to this lab and should
not be removed as part of Day 74 cleanup.
