repository-structure.md
Содержимое:
– назначение каждой директории
– где enforcement, где policy, где docs
– как добавлять новые роли
– как расширять compliance без ломки модели

Связи:
– ссылается на architecture.md как концептуальную модель
– используется как навигация для README.md


---

# Наполнение репозитория:

ЭТАП 0. Базовая инициализация репозитория

Входные данные
– Итоговая структура
– Пустые файлы

Шаги
Заполнить README.md (вступление + scope + non-goals).
ansible.cfg — strict defaults (forks, strategy, callbacks, interpreter).
requirements.yml — только необходимые коллекции (community.general, ansible.posix).
.gitignore — artefacts, retry, reports.
linters — ansible-lint, yamllint (strict).

Чеклист
– Репозиторий lint-clean
– Ничего environment-specific в корне

ЭТАП 1. Inventory и модель окружений

Цель
Зафиксировать trust boundaries и control domains.

Шаги
inventories/*/hosts.yaml
– группы: bastion, k8s_control, k8s_worker, ai_gpu
group_vars/all.yaml
– security defaults
– feature flags (enable_gpu, enable_selinux, enable_audit)
Никакой логики в host_vars (только исключения).

Чеклист
– Один inventory = один security domain
– Нет секретов
– Нет логики

ЭТАП 2. Playbook orchestration

Цель
Сделать читаемую security-цепочку.

Шаги
site.yaml
– единая точка входа
bootstrap.yaml
– user, sudo, python, repo, time, locale
hardening.yaml
– os → ssh → audit → firewall → selinux
kubernetes.yaml
– node-level security
ai-nodes.yaml
– GPU + runtime ограничения
break-glass.yaml
– строго изолирован

Чеклист
– Playbooks без tasks
– Только роли
– Чёткий порядок исполнения

ЭТАП 3. Common role

Цель
Единая база для всех хостов.

Шаги
users / groups
sudo baseline
packages (минимум)
ntp / time / locale
handlers для reload/restart

Чеклист
– Никакого hardening здесь
– Только фундамент

ЭТАП 4. OS hardening

Цель
Минимизация attack surface.

Шаги
kernel.yaml
– kptr_restrict, dmesg_restrict, modules
sysctl.yaml
– net, fs, vm
filesystem.yaml
– noexec,nodev,nosuid
sysctl.conf.j2 — декларативно

Чеклист
– Idempotent
– Без distro-specific хака
– CIS-aligned

ЭТАП 5. SSH hardening

Цель
Исключить интерактивный риск.

Шаги
sshd_config.j2
– no root
– key-only
– idle timeout
Fail-safe handler

Чеклист
– Совместимо с break-glass
– Нет password auth

ЭТАП 6. Audit и логирование

Цель
Полная трассируемость.

Шаги
audit.rules.j2
– identity
– sudo
– kernel
rsyslog
– forwarding
– tamper-resistance

Чеклист
– Ничего не логировать «всё подряд»
– Фокус на security events

ЭТАП 7. Firewall и SELinux

Цель
Enforcement, а не рекомендация.

Шаги
Firewall
– default deny
– минимальные allow
SELinux
– enforcing
– kubelet/container contexts

Чеклист
– Нет disable
– Только policy-driven

ЭТАП 8. Container runtime hardening

Цель
Закрыть container escape.

Шаги
daemon.json.j2
– userns
– no-new-privileges
– seccomp
Runtime validation

Чеклист
– Совместимо с k8s
– Без deprecated флагов

ЭТАП 9. Kubernetes node hardening

Цель
Node-level zero trust.

Шаги
kubelet.yaml
– authz
– cert rotation
cni.yaml
– no host access
kubelet-config.yaml.j2

Чеклист
– Совместимо с admission
– Нет cluster-level логики

ЭТАП 10. GPU hardening

Цель
AI-специфическая защита.

Шаги
Ограничение доступа к /dev/nvidia*
Runtime isolation
Запрет shared GPU без explicit allow

Чеклист
– Нет implicit sharing
– Audit-ready

ЭТАП 11. Compliance role

Цель
Security → compliance, а не наоборот.

Шаги
cis.yaml
nist.yaml
Генерация reports

Чеклист
– Mapping, не дублирование
– Только проверяемое

ЭТАП 12. Break-glass

Цель
Контролируемое нарушение контроля.

Шаги
sudoers.j2
TTL логика
Audit hooks

Чеклист
– Не по умолчанию
– Всегда логируется

ЭТАП 13. Policies (Policy-as-Code)

Цель
Fail fast.

Шаги
mandatory-hardening.rego
forbidden-configs.rego
Связка с CI

Чеклист
– Политики читаемые
– Enforcement до merge

ЭТАП 14. CI

Цель
Ни одного unsafe PR.

Шаги
ansible-lint
check-mode
compliance-report

Чеклист
– CI = gate
– Нет ручных проверок

ЭТАП 15. Docs

Цель
Продать архитектуру сеньер-уровня.

Шаги
Architecture → big picture
Threat model → почему
Baseline → что именно
Compliance → аудит

Чеклист
– Документация = часть security
– Без воды