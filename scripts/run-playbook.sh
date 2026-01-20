#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:?env required}"
PLAYBOOK="${2:?playbook required}"

ansible-playbook \
  -i inventories/${ENVIRONMENT} \
  playbooks/${PLAYBOOK}
