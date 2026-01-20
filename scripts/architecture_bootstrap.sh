#!/usr/bin/env bash
set -euo pipefail

# --- directories ---
dirs=(
inventories/{dev,stage,prod}/{group_vars,host_vars}
playbooks
collections/ansible_collections
policies/ansible
ci
scripts
docs

roles/common/{defaults,tasks,handlers,templates,files}
roles/os-hardening/{defaults,tasks,handlers,templates}
roles/os-hardening/tasks
roles/ssh-hardening/{defaults,tasks,handlers,templates}
roles/auditd/{defaults,tasks,handlers,templates}
roles/logging/{defaults,tasks,handlers,templates}
roles/firewall/{defaults,tasks}
roles/selinux/{defaults,tasks}
roles/container-runtime-hardening/{defaults,tasks,handlers,templates}
roles/kubernetes-node-hardening/{defaults,tasks,templates}
roles/gpu-hardening/{defaults,tasks,files}
roles/compliance/{defaults,tasks,reports}
roles/break-glass/{defaults,tasks,templates}
)

mkdir -p "${dirs[@]}"

# --- files ---
files=(
README.md
ansible.cfg
requirements.yml
.ansible-lint
.yamllint
.gitignore

inventories/dev/hosts.yaml
inventories/stage/hosts.yaml
inventories/prod/hosts.yaml
inventories/{dev,stage,prod}/group_vars/all.yaml

playbooks/{site.yaml,bootstrap.yaml,hardening.yaml,kubernetes.yaml,ai-nodes.yaml,break-glass.yaml}

roles/common/{defaults/main.yaml,tasks/main.yaml,handlers/main.yaml}
roles/os-hardening/{defaults/main.yaml,handlers/main.yaml}
roles/os-hardening/tasks/{main.yaml,kernel.yaml,sysctl.yaml,filesystem.yaml}
roles/os-hardening/templates/sysctl.conf.j2

roles/ssh-hardening/{defaults/main.yaml,tasks/main.yaml,handlers/main.yaml}
roles/ssh-hardening/templates/sshd_config.j2

roles/auditd/{defaults/main.yaml,handlers/main.yaml,tasks/main.yaml}
roles/auditd/templates/audit.rules.j2

roles/logging/{defaults/main.yaml,handlers/main.yaml,tasks/main.yaml}
roles/logging/templates/rsyslog.conf.j2

roles/firewall/{defaults/main.yaml,tasks/main.yaml}
roles/selinux/{defaults/main.yaml,tasks/main.yaml}

roles/container-runtime-hardening/{defaults/main.yaml,handlers/main.yaml,tasks/main.yaml}
roles/container-runtime-hardening/templates/daemon.json.j2

roles/kubernetes-node-hardening/defaults/main.yaml
roles/kubernetes-node-hardening/tasks/{main.yaml,kubelet.yaml,cni.yaml}
roles/kubernetes-node-hardening/templates/kubelet-config.yaml.j2

roles/gpu-hardening/{defaults/main.yaml,tasks/main.yaml}

roles/compliance/defaults/main.yaml
roles/compliance/tasks/{main.yaml,cis.yaml,nist.yaml}

roles/break-glass/{defaults/main.yaml,tasks/main.yaml}
roles/break-glass/templates/sudoers.j2

policies/ansible/{mandatory-hardening.rego,forbidden-configs.rego}
policies/README.md

ci/{ansible-lint.yml,ansible-check.yml,compliance-report.yml}

scripts/{bootstrap.sh,run-playbook.sh,verify.sh}

docs/{architecture.md,threat-model.md,hardening-baseline.md,kubernetes-security.md,ai-node-security.md,break-glass.md,compliance-mapping.md,repository-structure.md}
)

touch "${files[@]}"

# --- gitkeep ---
gitkeep_dirs=(
inventories/{dev,stage,prod}/host_vars
roles/common/{templates,files}
roles/gpu-hardening/files
roles/compliance/reports
collections/ansible_collections
)

for d in "${gitkeep_dirs[@]}"; do
  touch "$d/.gitkeep"
done

echo "Ansible hardening architecture bootstrap completed."
