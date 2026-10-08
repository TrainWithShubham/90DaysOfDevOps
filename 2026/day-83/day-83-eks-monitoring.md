# Day 83 -- Prometheus and Grafana Monitoring on EKS

## Goal

Monitor the AI BankApp EKS environment using Prometheus, Grafana, Spring
Boot Actuator, Micrometer, and ServiceMonitor.

## Metrics Flow

`Spring Boot → Actuator/Micrometer → /actuator/prometheus → ServiceMonitor → Prometheus → Grafana`

## Spring Boot Metrics

The application contained: - `spring-boot-starter-actuator` -
`micrometer-registry-prometheus`

Metrics were exposed at `/actuator/prometheus`.

## kube-prometheus-stack

The Prometheus Community `kube-prometheus-stack` Helm chart was
installed in the `monitoring` namespace.

It provided Prometheus, Grafana, Alertmanager, Prometheus Operator,
kube-state-metrics, and node-exporter.

## Verify Application Metrics

``` bash
kubectl port-forward -n bankapp svc/bankapp-service 8080:8080
curl -s http://localhost:8080/actuator/prometheus
```

The endpoint returned application startup/ready time, disk, and HikariCP
database connection metrics.

## ServiceMonitor

The BankApp Service port was named `http`. A `ServiceMonitor` named
`bankapp-monitor` was created in the `monitoring` namespace and
configured to scrape `/actuator/prometheus` every 30 seconds from the
BankApp Service.

## Prometheus Validation

``` bash
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
```

Prometheus discovered the BankApp targets.

PromQL:

``` promql
application_ready_time_seconds
```

The query returned two series corresponding to the two BankApp Pods
running after HPA scaling. This proved:

`BankApp → ServiceMonitor → Prometheus`

## Grafana

Grafana's Kubernetes dashboard displayed cluster CPU, memory, resource
requests/limits, and namespace usage. This confirmed successful
visualization of EKS/Kubernetes metrics.

> Before sharing screenshots publicly, crop or blur passwords, AWS
> account information, credentials, and other sensitive information.

## Useful Commands

``` bash
kubectl get pods -n monitoring
kubectl get servicemonitor -n monitoring
kubectl get endpoints bankapp-service -n bankapp
kubectl top pods -n bankapp
```

## Cleanup

To avoid AWS cost, Kubernetes-created cloud resources were removed
before Terraform infrastructure.

The BankApp namespace was deleted, which removed the Gateway and PVCs.
The Envoy LoadBalancer Service disappeared and `kubectl get pv` returned
no resources. Manually installed monitoring, cert-manager, and Envoy
Helm releases were then uninstalled.

Finally:

``` bash
terraform plan -destroy
terraform destroy
```

The destroy plan showed 84 resources and Terraform completed
successfully with all 84 destroyed. The AWS EKS console then showed zero
clusters, and the EC2 console showed no running worker instances in
`us-west-2`.

## Interview Explanation

> I implemented EKS monitoring using kube-prometheus-stack. Spring Boot
> exposed metrics through Actuator and Micrometer. I created a
> ServiceMonitor so Prometheus could scrape the application, verified
> the metrics using PromQL, and used Grafana Kubernetes dashboards to
> monitor CPU, memory, and workloads.

## Result

-   Prometheus and Grafana working
-   Actuator/Micrometer metrics exposed
-   ServiceMonitor working
-   BankApp targets discovered
-   PromQL verified application metrics
-   Grafana Kubernetes dashboard verified
-   AWS Load Balancer and EBS-backed PVs cleaned up
-   Terraform destroyed 84 infrastructure resources
-   EKS deletion and no running EC2 workers verified
