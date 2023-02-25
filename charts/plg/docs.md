## This is a quick reference to create panels in Grafana. 

### CPU Usage
```
100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### Memory Usage
```
100 - ((avg_over_time(node_memory_MemFree_bytes[5m]) + avg_over_time(node_memory_Cached_bytes[5m]) + avg_over_time(node_memory_Buffers_bytes[5m])) / avg_over_time(node_memory_MemTotal_bytes[5m]) * 100)
```

### Network Usage
```
sum by (instance) (irate(node_network_receive_bytes_total[5m])) + sum by (instance) (irate(node_network_transmit_bytes_total[5m]))
```

### Kubernetes Pods
```
sum by (namespace) (kube_pod_status_phase{phase=~"Pending|Running|Succeeded|Failed|Unknown"})
```

### Kubernetes Running Pods 
```
sum by (namespace) (kube_pod_status_phase{phase="Running"})
```

### Kubernetes Pending Pods
```
sum by (namespace) (kube_pod_status_phase{phase="Pending"})
```

### Kubernetes Failed Pods
```
sum by (namespace) (kube_pod_status_phase{phase="Failed"})
```

### Kubernetes Succeeded Pods
```
sum by (namespace) (kube_pod_status_phase{phase="Succeeded"})
```

### Kubernetes Nodes
```
sum by (node) (kube_node_status_condition{condition="Ready", status="true"})
```

For more information, please refer to the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/querying/examples/#kubernetes-cluster-monitoring).