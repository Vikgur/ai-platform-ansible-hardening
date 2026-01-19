# AI Platform Ansible Hardening

Эталонная платформа Ansible-hardening для суверенных и регулируемых AI-инфраструктур.

Данный репозиторий представляет собой **reference-реализацию уровня Senior DevSecOps**, предназначенную для жёстко регулируемых, sovereign AI-сред, где безопасность, воспроизводимость и соответствие требованиям важнее скорости и удобства.

Проект фокусируется на **hardening-инфраструктуре**, а не на конфигурации ради конфигурации:
– операционные системы  
– Kubernetes-ноды  
– GPU-узлы для AI-нагрузок  
– доступ, аудит, контроль изменений  
– соответствие стандартам (CIS, NIST, ISO)  

Ansible используется как **исполняемый контроль безопасности**, встроенный в жизненный цикл платформы и CI/CD, без ручных действий и snowflake-хостов.

## Ключевая идея

> Sovereign AI невозможен без управляемых хостов.  
> Hardening — это не настройка, а архитектурное свойство.

Этот репозиторий показывает, как выглядит **боевой hardening**, применимый в enterprise, государственном и defense-контексте.

---

– README = точка входа и позиционирование
– architecture.md = скелет всей документации
– threat-model.md = причина существования контролей
– hardening-baseline.md = фундамент
– kubernetes-security.md + ai-node-security.md = специализация
– compliance-mapping.md = разговор с аудиторами
– repository-structure.md = масштабирование проекта

---

README.md — что должно быть

Цель
– зачем репозиторий существует в платформе Sovereign AI
– какую проблему DevSecOps / AI security он решает

Scope и границы ответственности
– что именно харднится
– что намеренно вынесено в Terraform / Kubernetes / CI/CD репозитории

Ключевые принципы
– immutable-first
– policy-as-code
– least privilege
– zero trust nodes
– auditability by default

Архитектурное место
– как репозиторий встраивается в общий ландшафт Sovereign AI
– связь с ai-cloud-platform-terraform
– связь с ai-kubernetes-security-platform
– связь с ai-secure-ci-cd-platform

Что внутри
– inventories
– playbooks
– roles
– policies (OPA/Rego)
– ci
– docs

Потоки применения (явно указать:
• idempotency
• re-runnable без side effects)
– bootstrap нового узла
– hardening существующего узла
– kubernetes worker / control-plane
– AI/GPU nodes
– break-glass сценарий

Compliance и стандарты
– CIS / NIST / ISO как first-class citizen
– что покрывается автоматически

Как запускать (подчеркнуть:
• CI — предпочтительный путь
• manual — исключение)
– локально
– из CI
– в связке с Terraform outputs

Как читать docs/
– сквозная логика: architecture → threats → controls → compliance → operations
– рекомендуемый порядок изучения
– ссылки между файлами docs/

Не-цели
– отсутствие ad-hoc ручных изменений
– отсутствие stateful drift-management (это не CMDB)

Lifecycle overview
– оставить кратким
– без operational деталей