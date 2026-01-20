# Оглавление

- [Kubernetes Security Layer в Sovereign AI](#kubernetes-security-layer-в-sovereign-ai)
- [Роль Kubernetes в цепочке доверия](#роль-kubernetes-в-цепочке-доверия)
- [Требования к kubelet hardening](#требования-к-kubelet-hardening)
- [Node-level security controls](#node-level-security-controls)
- [Взаимодействие с механизмами Kubernetes](#взаимодействие-с-механизмами-kubernetes)
- [Границы ответственности](#границы-ответственности)
- [Kubernetes-специфичные угрозы](#kubernetes-специфичные-угрозы)
- [Применение и жизненный цикл](#применение-и-жизненный-цикл)
- [Связанные документы](#связанные-документы)

---

# Kubernetes Security Layer в Sovereign AI

Данный документ описывает security-модель Kubernetes на уровне узлов и kubelet в платформе Sovereign AI.

Он расширяет `docs/hardening-baseline.md`, уточняет архитектуру из `docs/architecture.md` и дополняет `docs/threat-model.md` Kubernetes-специфичными угрозами.

Фокус документа — **node-level security**, а не политики workloads.

---

# Роль Kubernetes в цепочке доверия

Kubernetes в Sovereign AI рассматривается как:

– оркестратор workloads  
– потребитель доверенных нод  
– enforcement-слой поверх hardened-хостов  

Kubernetes **не является** источником доверия.  
Он предполагает, что ноды уже приведены к корректному baseline.

---

# Требования к kubelet hardening

Kubelet считается частью attack surface узла и подлежит обязательному hardening.

Требования:

– защищённый kubelet API  
– аутентификация и авторизация включены  
– запрет анонимного доступа  
– ограничение доступа по сети  
– защищённая конфигурация certs  
– контроль параметров запуска  

Любое отклонение от baseline считается нарушением.

---

# Node-level security controls

Для Kubernetes-нод применяются дополнительные контроли:

– изоляция control-plane узлов  
– запрет workload-планирования на control-plane  
– ограничение доступа к hostPath  
– контроль cgroup и namespaces  
– защита kube-proxy и CNI  

Эти контроли дополняют OS-hardening, а не заменяют его.

---

# Взаимодействие с механизмами Kubernetes

Ansible hardening интегрируется с Kubernetes security-механизмами:

– seccomp  
  Подготовка узла и профилей.

– AppArmor  
  Обеспечение доступности и корректной конфигурации.

– admission controllers  
  Ansible не подменяет admission, а создаёт доверенную основу.

Ansible обеспечивает **возможность enforcement**, Kubernetes — **само enforcement на уровне workloads**.

---

# Границы ответственности

Явное разделение ответственности:

Ansible отвечает за:  
– kubelet конфигурацию  
– node-level hardening  
– runtime окружение  
– базовые security-профили  

Kubernetes отвечает за:  
– admission policies  
– workload isolation  
– network policies  
– runtime enforcement  

Смешение ролей считается архитектурной ошибкой.

---

# Kubernetes-специфичные угрозы

Дополняя `docs/threat-model.md`, выделяются угрозы:

– компрометация kubelet  
– несанкционированный доступ к node API  
– escape из контейнера на узел  
– lateral movement через kubelet  
– компрометация control-plane через node  

Контроли направлены на сужение этих поверхностей атаки.

---

# Применение и жизненный цикл

Kubernetes hardening:

– применяется только после OS-hardening  
– переисполняем без side-effects  
– проверяем через CI  

Любые изменения kubelet-конфигурации:  
– проходят через Git  
– применяются Ansible  
– логируются и аудируются  

---

# Связанные документы

– `docs/hardening-baseline.md`  
– `docs/architecture.md`  
– `docs/threat-model.md`  
– `docs/ai-node-security.md`  
– `docs/compliance-mapping.md`  
