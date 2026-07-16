# Prometheus

Prometheus is deployed using the official Helm chart.

The Inventory Platform exposes metrics at `/metrics` using `prometheus-fastapi-instrumentator`.

Prometheus discovers the application automatically through Kubernetes pod annotations:

```yaml
prometheus.io/scrape: "true"
prometheus.io/path: "/metrics"
prometheus.io/port: "8000"
```

No custom scrape configuration is required.