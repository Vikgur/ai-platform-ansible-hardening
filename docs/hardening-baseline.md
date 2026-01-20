# Оглавление

- [Hardening Baseline для Sovereign AI](#hardening-baseline-для-sovereign-ai)
- [Формальное определение Hardened Host](#формальное-определение-hardened-host)
- [Базовые OS-контроли](#базовые-os-контроли)
  - [Kernel](#kernel)
  - [Sysctl](#sysctl)
  - [Filesystem](#filesystem)
  - [Users и доступ](#users-и-доступ)
  - [Network](#network)
- [Container Runtime Baseline](#container-runtime-baseline)
- [Immutable и Mutable зоны](#immutable-и-mutable-зоны)
- [Drift и контроль изменений](#drift-и-контроль-изменений)
- [Реализация и соответствие](#реализация-и-соответствие)
- [Использование baseline](#использование-baseline)

---

# Hardening Baseline для Sovereign AI

Данный документ формально определяет, что в рамках платформы Sovereign AI считается **hardened host**.

Он описывает **минимально допу`стимый security-baseline**, обязательный для всех узлов до запуска Kubernetes, AI-нагрузок и любых production-workloads.

Документ является базовым слоем безопасности и используется:  
– как эталон для Ansible-ролей  
– как источник для `docs/compliance-mapping.md`  
– как фундамент для `docs/architecture.md`  

---

# Формальное определение Hardened Host

Узел считается hardened только при одновременном выполнении всех условий:

– состояние узла полностью воспроизводимо  
– конфигурация управляется только Ansible  
– ручные изменения отсутствуют  
– доступ минимален и контролируем  
– аудит включён и неизменяем  
– сетевые политики явно ограничены  
– конфигурационный дрейф обнаружим  

Частичное соответствие не допускается.

---

# Базовые OS-контроли

## Kernel

– отключены неиспользуемые модули  
– запрещена загрузка произвольных модулей  
– усилены параметры защиты памяти  
– включена защита от privilege escalation  

## Sysctl

– ограничение сетевых поверхностей атаки  
– защита от spoofing и flooding  
– контроль IPC и namespaces  
– усиление kernel hardening параметров  

## Filesystem

– разделение mutable и immutable зон  
– noexec, nodev, nosuid где применимо  
– защита системных каталогов  
– контроль прав доступа  

## Users и доступ

– отсутствие shared-аккаунтов  
– строгий sudo  
– ограниченный SSH-доступ  
– break-glass только по политике  

## Network

– deny-by-default  
– минимально необходимые порты  
– контроль исходящих соединений  
– явное разделение плоскостей трафика  

---

# Container Runtime Baseline

Для всех узлов с контейнерной нагрузкой:

– запрещён privileged режим по умолчанию  
– ограничен доступ к host namespaces  
– включены seccomp и capabilities drop  
– контроль образов и runtime конфигурации  

Runtime считается частью attack surface хоста.

---

# Immutable и Mutable зоны

Архитектура хоста разделена на зоны:

Immutable:  
– системные бинарники  
– конфигурации hardening  
– security-политики  

Mutable:  
– runtime данные  
– логи  
– временные файлы  

Любое изменение immutable-зоны считается инцидентом.

---

# Drift и контроль изменений

Требования к drift:

– дрейф считается нарушением безопасности  
– обнаружение дрейфа автоматизировано  
– исправление происходит через Ansible  
– ручное исправление запрещено  

Drift-management не заменяет hardening, а дополняет его.

---

# Реализация и соответствие

Данный baseline реализуется ролями:

– os-hardening  
– ssh-hardening  
– auditd  
– firewall  
– logging  

Каждый контроль:  
– исполняем  
– проверяем  
– трассируем  

---

# Использование baseline

Baseline применяется:

– при bootstrap новых узлов  
– при повторном hardening  
– при аудитах и проверках  
– как вход для `docs/compliance-mapping.md`  

Отступления от baseline допустимы только через формализованные исключения.
