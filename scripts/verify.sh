#!/usr/bin/env bash
set -euo pipefail

ansible-lint
yamllint .
ansible-playbook \
  -i inventories/dev \
  playbooks/site.yaml \
  --check
