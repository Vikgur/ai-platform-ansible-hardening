# Оглавление

- [Структура репозитория Ansible Hardening](#структура-репозитория-ansible-hardening)
- [Архитектурная логика структуры](#архитектурная-логика-структуры)
- [Корень репозитория](#корень-репозитория)
  - [inventories/](#inventories)
  - [playbooks/](#playbooks)
  - [roles/](#roles)
  - [collections/](#collections)
  - [policies/](#policies)
  - [ci/](#ci)
  - [scripts/](#scripts)
  - [docs/](#docs)
- [Назначение директорий и файлов](#назначение-директорий-и-файлов)
  - [README.md](#readmemd)
  - [ansible.cfg](#ansiblecfg)
  - [requirements.yml](#requirementsyml)
  - [.ansible-lint](#ansible-lint)
  - [.yamllint](#yamllint)
  - [.gitignore](#gitignore)
  - [inventories/](#inventories-1)
  - [playbooks/](#playbooks-1)
    - [site.yaml](#siteyaml)
    - [bootstrap.yaml](#bootstrapyaml)
    - [hardening.yaml](#hardeningyaml)
    - [kubernetes.yaml](#kubernetesyaml)
    - [ai-nodes.yaml](#ai-nodesyaml)
    - [break-glass.yaml](#break-glassyaml)
  - [collections/](#collections-1)
    - [ansible_collections/.gitkeep](#ansible_collectionsgitkeep)
  - [policies/](#policies-1)
    - [ansible/](#ansible)
    - [README.md](#readmemd-1)
  - [ci/](#ci-1)
    - [ansible-lint.yml](#ansible-lintyml)
    - [ansible-check.yml](#ansible-checkyml)
    - [compliance-report.yml](#compliance-reportyml)
  - [scripts/](#scripts-1)
    - [bootstrap.sh](#bootstrapsh)
    - [run-playbook.sh](#run-playbooksh)
    - [verify.sh](#verifysh)
    - [architecture_bootstrap.sh](#architecture_bootstrapsh)
  - [docs/](#docs-1)
    - [architecture.md](#architecturemd)
    - [threat-model.md](#threat-modelmd)
    - [hardening-baseline.md](#hardening-baselinemd)
    - [kubernetes-security.md](#kubernetes-securitymd)
    - [ai-node-security.md](#ai-node-securitymd)
    - [break-glass.md](#break-glassmd)
    - [compliance-mapping.md](#compliance-mappingmd)
    - [repository-structure.md](#repository-structuremd)
  - [roles/](#roles-1)
    - [common/](#common)
    - [os-hardening/](#os-hardening)
    - [ssh-hardening/](#ssh-hardening)
    - [auditd/](#auditd)
    - [logging/](#logging)
    - [firewall/](#firewall)
    - [selinux/](#selinux)
    - [container-runtime-hardening/](#container-runtime-hardening)
    - [kubernetes-node-hardening/](#kubernetes-node-hardening)
    - [gpu-hardening/](#gpu-hardening)
    - [compliance/](#compliance)
    - [break-glass/](#break-glass)

---

# Структура репозитория Ansible Hardening

Данный документ описывает **структуру репозитория как архитектурное решение**, а не как перечень файлов.

Он объясняет:  
– зачем существует каждый слой  
– где происходит enforcement, а где декларация  
– как репозиторий поддерживает DevSecOps-модель Sovereign AI  

Документ опирается на `docs/architecture.md` и используется как навигационная карта для `docs/README.md`.

---

# Архитектурная логика структуры

Репозиторий построен по принципу **разделения ответственности и слоёв доверия**.

Ключевые идеи структуры:  
– конфигурация ≠ безопасность  
– декларация ≠ enforcement  
– документация = часть security  
– CI = обязательный участник lifecycle  

Структура отражает путь:
**политика → контроль → применение → проверка → доказательство**.

---

# Корень репозитория

Корень содержит только то, что относится к:  
– управлению Ansible как платформой  
– качеству и воспроизводимости  
– интеграции с CI  

Здесь нет hardening-логики — только управление ею.

DevSecOps-смысл:  
– единая точка входа  
– минимизация случайных изменений  
– стандартизация запуска и проверок  

## inventories/

Слой описания **окружений и ролей узлов**.

Задачи:  
– разделение dev / stage / prod  
– отсутствие логики hardening  
– только данные, без поведения  

DevSecOps-смысл:  
– среда не влияет на security-модель  
– различия изолированы и явны  
– минимизация environment-specific drift  

## playbooks/

Слой **исполняемых сценариев**.

Задачи:  
– формализовать потоки применения  
– зафиксировать порядок и зависимости  
– исключить «ручные комбинации ролей»  

DevSecOps-смысл:  
– сценарии вместо ad-hoc запусков  
– воспроизводимость действий  
– контроль blast-radius  

## roles/

Основной слой **security-enforcement**.

Задачи:  
– реализовать конкретные контроли  
– изолировать области ответственности  
– обеспечить повторяемость и идемпотентность  

Каждая роль:  
– закрывает конкретный класс угроз  
– соотносится с hardening-baseline  
– участвует в compliance  

DevSecOps-смысл:  
– безопасность как код  
– переиспользуемые контроли  
– проверяемость и аудит  

## collections/

Слой расширения Ansible.

Задачи:  
– изоляция внешних зависимостей  
– контроль supply chain  
– воспроизводимость окружения  

DevSecOps-смысл:  
– защита от неявных зависимостей  
– детерминированные сборки  

## policies/

Слой **policy-as-code**.

Задачи:  
– запрет небезопасных состояний  
– формализация обязательных требований  
– автоматическая валидация  

DevSecOps-смысл:  
– безопасность до выполнения  
– предотвращение ошибок, а не реакция  
– enforcement без человека  

## ci/

Слой **доказательства безопасности**.

Задачи:  
– автоматическая проверка  
– выявление нарушений  
– генерация отчётов  

DevSecOps-смысл:  
– CI как security-gate  
– отказ от доверия ручным действиям  
– соответствие как результат, а не декларация  

## scripts/

Слой вспомогательных утилит.

Задачи:  
– стандартизировать запуск  
– исключить ошибочные команды  
– упростить bootstrap и валидацию  

DevSecOps-смысл:  
– снижение человеческого фактора  
– одинаковое поведение локально и в CI  

## docs/

Слой **архитектурного знания**.

Задачи:  
– зафиксировать модель угроз  
– описать security-архитектуру  
– связать контроли и compliance  

DevSecOps-смысл:  
– документация как часть security  
– воспроизводимость понимания  
– аудит архитектуры, а не только кода  

---

Следующий раздел документа подробно описывает назначение **каждой директории и файла** репозитория.

---

# Назначение директорий и файлов

## README.md
Главная точка входа репозитория.  
Содержит позиционирование, scope, non-goals и ссылки на docs/.  
DevSecOps-смысл: быстрое понимание архитектуры и политики безопасности.

## ansible.cfg
Конфигурационный файл Ansible для репозитория.  
Определяет поведение playbooks, путь к ролям и linting.  
DevSecOps-смысл: единообразие запуска и контроль исполнения.

## requirements.yml
Определяет внешние Ansible-collections и зависимости.  
DevSecOps-смысл: воспроизводимость окружения и контроль supply chain.

## .ansible-lint
Настройки для ansible-lint.  
DevSecOps-смысл: enforce стандарты качества и безопасность ролей.

## .yamllint
Конфигурация yaml-lint.  
DevSecOps-смысл: гарантировать корректный синтаксис и предотвращение ошибок.

## .gitignore
Исключает временные и чувствительные файлы из git.  
DevSecOps-смысл: предотвращение утечек секретов и мусора в репозиторий.

---

## inventories/
Содержит описание всех окружений: dev, stage, prod.  
Каждый подкаталог содержит:
- hosts.yaml — список узлов  
- group_vars/all.yaml — общие переменные  
- host_vars/.gitkeep — индивидуальные переменные узлов  

DevSecOps-смысл:
- изоляция окружений  
- отсутствие вручную управляемых конфигураций  
- минимизация drift через Ansible

## playbooks/
Содержит Ansible playbooks для управления жизненным циклом узлов и платформы.  

### site.yaml
Главный playbook, orchestrates все остальные сценарии.  
DevSecOps-смысл: единый точка запуска для полного hardening.

### bootstrap.yaml
Инициализация нового узла, установка зависимостей, подготовка среды.  
DevSecOps-смысл: гарантированная повторяемость Day-0.

### hardening.yaml
Применение OS и runtime hardening к узлу.  
DevSecOps-смысл: enforcement security baseline без side-effects.

### kubernetes.yaml
Настройка и hardening Kubernetes-ноды.  
DevSecOps-смысл: контроль kubelet и node-level security.

### ai-nodes.yaml
Hardening AI/GPU узлов.  
DevSecOps-смысл: изоляция, runtime ограничения, предотвращение утечек данных.

### break-glass.yaml
Playbook для безопасного экстренного доступа.  
DevSecOps-смысл: enforce временного доступа с полной логируемостью и отзывом.

---

## collections/
Хранит локальные Ansible collections или заглушки для CI/CD.  

### ansible_collections/.gitkeep
Обеспечивает сохранение пустой директории в Git.  
DevSecOps-смысл: контроль структуры репозитория и reproducibility.

---

## policies/
Слой **policy-as-code** для проверки конфигураций.

### ansible/
Содержит OPA/rego правила для enforcement.

- mandatory-hardening.rego — обязательные security-контроли  
- forbidden-configs.rego — запрещённые конфигурации  

### README.md
Описание назначения и принципов работы policy-as-code.  
DevSecOps-смысл: прозрачное, формализованное управление безопасностью.

---

## ci/
Содержит конфигурации CI для проверки Ansible-кода.

### ansible-lint.yml
Запуск ansible-lint как pipeline шаг.  
DevSecOps-смысл: автоматическое соблюдение стандартов.

### ansible-check.yml
Проверка playbooks на идемпотентность и потенциальные drift.  
DevSecOps-смысл: доказательство, что изменения безопасны.

### compliance-report.yml
Генерация отчётов соответствия baseline и стандартам.  
DevSecOps-смысл: CI как первичный инструмент audit-ready compliance.

---

## scripts/
Вспомогательные утилиты для запуска и валидации.

### bootstrap.sh
Подготовка узла перед применением Ansible.  

### run-playbook.sh
Унифицированный запуск playbooks с параметрами окружения.  

### verify.sh
Проверка состояния узла после hardening.  
DevSecOps-смысл: минимизация ручного вмешательства и ошибок.

### architecture_bootstrap.sh
Скрипт создания структуры проекта.

---

## docs/
Содержит документацию, фиксирующую архитектуру, угрозы, контролы и compliance.

### architecture.md
Описывает место Ansible-hardening в платформе Sovereign AI, trust boundaries, control/data plane, enforcement vs декларацию и Day-0/1/2 модель.  
DevSecOps-смысл: концептуальная карта, точка входа для всех security решений.

### threat-model.md
Документирует модели атакующих, AI-специфичные угрозы, lateral movement и supply chain атаки.  
DevSecOps-смысл: обоснование контролей и приоритизация mitigations.

### hardening-baseline.md
Определяет “hardened host”, OS и runtime controls, immutable зоны и drift требования.  
DevSecOps-смысл: базовый слой безопасности для всех узлов.

### kubernetes-security.md
Расширяет baseline на Kubernetes-ноды, kubelet hardening, node-level controls, взаимодействие с admission, seccomp и AppArmor.  
DevSecOps-смысл: защита control и data plane Kubernetes.

### ai-node-security.md
Описывает GPU isolation, runtime ограничения AI workloads, multi-tenant threats и data exfiltration prevention.  
DevSecOps-смысл: безопасность вычислений и данных в AI-среде.

### break-glass.md
Фиксирует политику экстренного доступа, логирование, отзыв прав и post-incident review.  
DevSecOps-смысл: controlled exception с полной auditability.

### compliance-mapping.md
Маппинг security controls на CIS/NIST/ISO, автоматизация, CI-проверки и внешние аудиты.  
DevSecOps-смысл: доказательство соответствия стандартам и threat-model.

### repository-structure.md
Документирует назначение директорий и файлов, слои enforcement, policy, docs и правила расширения ролей.  
DevSecOps-смысл: навигация, воспроизводимость и минимизация drift.

---

## roles/
Основной слой **enforcement**, где реализуются все контролы безопасности.

### common/
Базовая роль с общими настройками и вспомогательными задачами.  
- defaults/main.yaml — общие переменные  
- handlers/main.yaml — общие handlers  
- tasks/main.yaml — базовые задачи  
- templates/.gitkeep / files/.gitkeep — пустые каталоги для структуры  

DevSecOps-смысл: минимизация повторений и единая точка расширения для всех ролей.

### os-hardening/
Роль для hardening ОС.  
- defaults/main.yaml — общие переменные  
- tasks/kernel.yaml — контроль ядра  
- tasks/sysctl.yaml — sysctl параметры  
- tasks/filesystem.yaml — настройка FS  
- templates/sysctl.conf.j2 — шаблон sysctl  
- handlers/main.yaml — обработчики  

DevSecOps-смысл: enforce безопасную ОС как базу для всех остальных слоев.

### ssh-hardening/
Контроль SSH.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — настройка sshd  
- templates/sshd_config.j2 — шаблон конфигурации  
- handlers/main.yaml — перезапуск сервиса при изменениях  

DevSecOps-смысл: предотвращение удалённых атак и принудительное соблюдение политики доступа.

### auditd/
Настройка auditd.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — правила аудита  
- templates/audit.rules.j2 — шаблон правил  
- handlers/main.yaml — reload auditd  

DevSecOps-смысл: обязательный аудит всех действий на хосте, traceability.

### logging/
Управление централизованной логгинг-системой.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — конфигурация rsyslog  
- templates/rsyslog.conf.j2 — шаблон конфигурации  
- handlers/main.yaml — перезапуск rsyslog  

DevSecOps-смысл: защита логов и их централизованная доступность.

### firewall/
Управление iptables/nftables.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — правила firewall  

DevSecOps-смысл: контроль сетевого трафика и минимизация attack surface.

### selinux/
Настройка SELinux.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — enforce policy  

DevSecOps-смысл: mandatory access control для OS и приложений.

### container-runtime-hardening/
Hardening контейнерного рантайма.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — конфигурация daemon.json  
- templates/daemon.json.j2 — шаблон конфигурации  
- handlers/main.yaml — перезапуск runtime  

DevSecOps-смысл: безопасный runtime для AI workloads.

### kubernetes-node-hardening/
Hardening Kubernetes-ноды.  
- defaults/main.yaml — общие переменные  
- tasks/kubelet.yaml — kubelet configuration  
- tasks/cni.yaml — CNI security  
- tasks/main.yaml — orchestrates kubelet и CNI, обеспечивает идемпотентное применение всех node-level security controls  
- templates/kubelet-config.yaml.j2 — шаблон kubelet  
- handlers/main.yaml — reload services  

DevSecOps-смысл: node-level security, контроль data/control plane.

### gpu-hardening/
Hardening GPU-узлов.  
- defaults/main.yaml — общие переменные  
- tasks/main.yaml — runtime ограничения  
- handlers/main.yaml — при необходимости  
- files/.gitkeep — placeholder  

DevSecOps-смысл: безопасность AI workloads, isolation, multi-tenant protection.

### compliance/
Автоматизация соответствия стандартам.  
- tasks/cis.yaml — CIS controls  
- tasks/nist.yaml — NIST controls  
- tasks/main.yaml — orchestrates CIS и NIST tasks, централизованное compliance enforcement
- reports/.gitkeep — генерация отчётов  
- defaults/main.yaml — переменные  

DevSecOps-смысл: compliance как first-class citizen, audit-ready.

### break-glass/
Реализация экстренного доступа.  
- tasks/main.yaml — выдача временных прав  
- templates/sudoers.j2 — шаблон sudoers  
- defaults/main.yaml — настройки временных окон  

DevSecOps-смысл: controlled exception, full audit, enforce policy.
