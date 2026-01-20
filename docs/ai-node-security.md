# AI Node Security в Sovereign AI

Данный документ описывает security-модель для GPU и AI-нод в платформе Sovereign AI.

Он расширяет `docs/kubernetes-security.md`, напрямую опирается на `docs/threat-model.md` в части AI-угроз и используется в `docs/compliance-mapping.md` как источник AI-специфичных контролей.

Фокус документа — **изоляция вычислений и данных в multi-tenant AI-среде**.

# Роль AI-нод в архитектуре

AI-ноды рассматриваются как:

– высокоценные вычислительные активы  
– точки концентрации чувствительных данных  
– усиленная поверхность атаки  

Компрометация AI-ноды считается критическим инцидентом независимо от blast-radius.

# Модели изоляции GPU

Используемые модели изоляции:

– device-level isolation  
– namespace и cgroup ограничения  
– запрет прямого доступа к host GPU  
– строгая привязка GPU к workload  

Совместное использование GPU допускается только при наличии формальных ограничений.

# Runtime ограничения для AI workloads

Для AI workloads применяются дополнительные runtime-контроли:

– запрет privileged контейнеров  
– ограничение capabilities  
– контроль доступа к device files  
– ограничение IPC и shared memory  
– контроль сетевых соединений  

AI workload никогда не считается доверенным.

# Предотвращение утечек данных

Механизмы предотвращения data exfiltration:

– ограничение egress-трафика  
– контроль доступа к storage  
– изоляция training и inference данных  
– обязательное логирование доступа  

Любая утечка данных рассматривается как нарушение суверенитета.

# Multi-tenant AI threat surface

В multi-tenant среде учитываются угрозы:

– side-channel атаки через GPU  
– cross-workload data leakage  
– persistence в runtime или драйверах  
– обход ограничений через ML-фреймворки  

Контроли направлены на минимизацию перекрёстного влияния.

# Взаимодействие с Kubernetes Security

AI-node security строится поверх Kubernetes:

– использует node labeling и taints  
– опирается на admission-контроли  
– требует строгого workload placement  

Ansible обеспечивает корректное состояние узла, Kubernetes — контроль workloads.

# Применение и гарантии

AI hardening:

– применяется после OS и Kubernetes hardening  
– переисполняем без side-effects  
– проверяем через CI  

Гарантии действуют только при соблюдении всей цепочки доверия.

# Связанные документы

– `docs/kubernetes-security.md`  
– `docs/threat-model.md`  
– `docs/hardening-baseline.md`  
– `docs/compliance-mapping.md`  
