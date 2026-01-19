threat-model.md
Содержимое:
– модели атакующих
– AI-специфичные угрозы (GPU, training data, inference data)
– атаки на supply chain (Ansible roles, images, kube binaries)
– lateral movement между workloads и узлами (явно разделить:
• node → node
• workload → node
• workload → workload)
– out-of-scope и допущения

Связи:
– маппинг угроз → controls из hardening-baseline.md
– ссылки на kubernetes-security.md и ai-node-security.md как mitigation layers
– вход для compliance-mapping.md
– явная ссылка на assumptions в architecture.md
