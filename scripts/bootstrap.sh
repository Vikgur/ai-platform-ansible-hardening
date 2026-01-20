#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:?env required}"

ansible-galaxy collection install -r requirements.yml --force

ansible-playbook \
  -i inventories/${ENVIRONMENT} \
  playbooks/bootstrap.yaml
