architecture.md
Содержимое:
– место ansible-hardening в Sovereign AI
– цепочка: Terraform → Ansible → Kubernetes → Runtime
– trust boundaries (cloud, node, kubelet, container, workload) • control plane trust boundary • CI/CD → infra boundary
– разделение control plane / data plane
– где enforcement (Ansible, OPA), где декларация (Terraform, K8s manifests)
– Security assumptions (Assumptions and guarantees)
– Day-0 / Day-1 / Day-2 model зафиксировать: • кто источник истины • где запрещены ручные изменения

Связи:
– ссылается на hardening-baseline.md как набор контролей
– ссылается на kubernetes-security.md и ai-node-security.md как расширения
– используется как точка входа для threat-model.md