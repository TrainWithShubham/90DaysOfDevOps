# Week 10: Observability Challenge with Prometheus and Grafana on KIND/EKS

This challenge is part of the 90DaysOfDevOps program and focuses on solving advanced, production-grade observability scenarios using Prometheus and Grafana. You will deploy, configure, and fine-tune monitoring and alerting systems on a KIND cluster, and as a bonus, monitor and log an AWS EKS cluster. This exercise is designed to push your skills with advanced configurations, custom queries, dynamic dashboards, and robust alerting mechanisms, while preparing you for technical interviews.

**Important:**  
1. Fork the [online_shop repository](https://github.com/Amitabh-DevOps/online_shop) and implement all tasks on your fork.  
2. Document all steps, commands, screenshots, and observations in a file named `solution.md` within your fork.  
3. Submit your `solution.md` file in the Week 10 (Observability) task folder of the 90DaysOfDevOps repository.

---

## Task 1: Setup a KIND Cluster for Observability

**Real-World Scenario:**  
Simulate a production-like Kubernetes environment locally by creating a KIND cluster to serve as the foundation for your monitoring setup.

**Steps:**
1. **Install KIND:**  
   - Follow the official KIND installation guide.
2. **Create a KIND Cluster:**  
   - Run:
     ```bash
     kind create cluster --name observability-cluster
     ```
3. **Verify the Cluster:**  
   - Run `kubectl get nodes` and capture the output.
4. **Document in `solution.md`:**  
   - Include installation steps, the commands used, and output from `kubectl get nodes`.

**Interview Questions:**
- What are the benefits and limitations of using KIND for production-like testing?
- How can you simulate production scenarios using a local KIND cluster?

---

## Task 2: Deploy Prometheus on KIND with Advanced Configurations

**Real-World Scenario:**  
Deploy Prometheus on your KIND cluster with a custom configuration that includes advanced scrape settings and relabeling rules to ensure high-quality metric collection.

**Steps:**
1. **Create a Custom Prometheus Configuration:**  
   - Write a `prometheus.yml` with custom scrape configurations targeting cluster components (e.g., kube-state-metrics, Node Exporter) and advanced relabeling rules to clean up metric labels.
2. **Deploy Prometheus:**  
   - Deploy Prometheus using a Kubernetes Deployment or via a Helm chart.
3. **Verify and Tune:**  
   - Access the Prometheus UI to verify that metrics are being scraped as expected.
   - Adjust relabeling rules and scrape intervals to optimize performance.
4. **Document in `solution.md`:**  
   - Include your `prometheus.yml` and screenshots of the Prometheus UI showing active targets and effective relabeling.

**Interview Questions:**
- How do advanced relabeling rules refine metric collection in Prometheus?
- What performance issues might you encounter when scraping targets on a KIND cluster, and how would you address them?

---

## Task 3: Deploy Grafana and Build Production-Grade Dashboards

**Real-World Scenario:**  
Deploy Grafana on your KIND cluster and configure it to use Prometheus as a data source. Then, create dashboards that reflect real production metrics, including custom queries and complex visualizations.

**Steps:**
1. **Deploy Grafana:**  
   - Create a Kubernetes Deployment and Service for Grafana.
2. **Configure the Data Source:**  
   - In the Grafana UI, add Prometheus as a data source.
3. **Design Production Dashboards:**  
   - Create dashboards with panels that display key metrics (e.g., CPU, memory, disk I/O, network latency) using advanced PromQL queries.
   - Customize panel visualizations (e.g., graphs, tables, heatmaps) to present data effectively.
4. **Document in `solution.md`:**  
   - Include configuration details, screenshots of dashboards, and an explanation of the queries and visualization choices.

**Interview Questions:**
- What factors are critical when designing dashboards for production monitoring?
- How do you optimize PromQL queries for performance and clarity in Grafana?

---

## Task 4: Configure Alerting and Notification Rules

**Real-World Scenario:**  
Establish robust alerting to detect critical issues (e.g., resource exhaustion, node failures) and notify the operations team immediately.

**Steps:**
1. **Define Alerting Rules:**  
   - Add alerting rules in `prometheus.yml` or configure Prometheus Alertmanager for specific conditions.
2. **Configure Notification Channels:**  
   - Set up Grafana (or Alertmanager) to send notifications via email, Slack, or another channel.
3. **Test Alerts:**  
   - Simulate alert conditions (e.g., by temporarily reducing resources) to verify that notifications are sent.
4. **Document in `solution.md`:**  
   - Include your alerting configuration, screenshots of triggered alerts, and a brief rationale for chosen thresholds.

**Interview Questions:**
- How do you design effective alerting rules to minimize false positives in production?
- What challenges do you face in configuring notifications for a dynamic environment?

---

## Task 5: Deploy Node Exporter for Enhanced System Metrics

**Real-World Scenario:**  
Enhance system monitoring by deploying Node Exporter on your KIND cluster to collect detailed metrics such as CPU, memory, disk, and network usage, which are critical for troubleshooting production issues.

**Steps:**
1. **Deploy Node Exporter:**  
   - Create a Deployment or DaemonSet to deploy Node Exporter across all nodes in your KIND cluster.
2. **Verify Metrics Collection:**  
   - Ensure Node Exporter endpoints are correctly scraped by Prometheus.
3. **Document in `solution.md`:**  
   - Include your Node Exporter YAML configuration and screenshots showing metrics collected in Prometheus.
   - Explain the importance of system-level metrics in production monitoring.

**Interview Questions:**
- What additional system metrics does Node Exporter provide that are crucial for production?
- How would you integrate Node Exporter metrics into your existing Prometheus setup?

---

## Bonus Task: Monitor and Log an AWS EKS Cluster

**Real-World Scenario:**  
For an added challenge, provision or use an existing AWS EKS cluster and set up Prometheus and Grafana to monitor and log its performance. This task simulates the observability of a production cloud environment.

**Steps:**
1. **Provision an EKS Cluster:**  
   - Use Terraform to deploy an EKS cluster (or leverage an existing one) and document key configuration settings.
2. **Deploy Prometheus and Grafana on EKS:**  
   - Configure Prometheus with appropriate scrape targets for the EKS cluster.
   - Deploy Grafana and integrate it with Prometheus.
3. **Integrate Logging (Optional):**  
   - Optionally, configure a logging solution (e.g., Fluentd or CloudWatch) to capture EKS logs.
4. **Document in `solution.md`:**  
   - Summarize your EKS provisioning steps, Prometheus and Grafana configurations, and any logging integration.
   - Explain how monitoring and logging improve observability in a cloud environment.

**Interview Questions:**
- What are the key challenges of monitoring an EKS cluster versus a local KIND cluster?
- How would you integrate logging with monitoring tools to ensure comprehensive observability?

---

## How to Submit

1. **Push Your Final Work to GitHub:**  
   - Fork the [online_shop repository](https://github.com/Amitabh-DevOps/online_shop) and ensure all files (Prometheus and Grafana configurations, Node Exporter YAML, Terraform files for the bonus task, `solution.md`, etc.) are committed and pushed to your fork.

2. **Create a Pull Request (PR):**  
   - Open a PR from your branch (e.g., `observability-challenge`) to the main repository.
   - **Title:**  
     ```
     Week 10 Challenge - Observability Challenge (Prometheus & Grafana on KIND/EKS)
     ```
   - **PR Description:**  
     - Summarize your approach, list key commands/configurations, and include screenshots or logs as evidence.

3. **Submit Your Documentation:**  
   - **Important:** Place your `solution.md` file in the Week 10 (Observability) task folder of the 90DaysOfDevOps repository.

4. **Share Your Experience on LinkedIn:**  
   - Write a post summarizing your Observability challenge experience.
   - Include key takeaways, challenges faced, and insights (e.g., KIND/EKS setup, advanced configurations, dashboard creation, alerting strategies, and Node Exporter integration).
   - Use the hashtags: **#90DaysOfDevOps #Prometheus #Grafana #KIND #EKS #Observability #DevOps #InterviewPrep**
   - Optionally, provide links to your repository or blog posts detailing your journey.

---

## TrainWithShubham Resources for Observability

- **[Prometheus & Grafana One-Shot Video](https://youtu.be/DXZUunEeHqM?si=go1m-THyng7Ipyu6)**

---

## Additional Resources

- **[Prometheus Official Documentation](https://prometheus.io/docs/)**
- **[Grafana Official Documentation](https://grafana.com/docs/)**
- **[Alertmanager Documentation](https://prometheus.io/docs/alerting/latest/alertmanager/)**
- **[Kubernetes Monitoring with Prometheus](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/)**
- **[Grafana Dashboards](https://grafana.com/grafana/dashboards/)**

---

Complete these tasks, answer the interview questions in your documentation, and use your work as a reference to prepare for real-world DevOps challenges and technical interviews.
