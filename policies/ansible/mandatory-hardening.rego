package ansible.mandatory

deny[msg] {
  input.task.roles[_] == "os-hardening"
  not input.task.sysctl
  msg = "OS hardening tasks must include sysctl configuration"
}

deny[msg] {
  input.task.roles[_] == "ssh-hardening"
  not input.task.sshd_config
  msg = "SSH hardening must deploy sshd_config template"
}

deny[msg] {
  input.task.roles[_] == "auditd"
  not input.task.audit_rules
  msg = "Audit rules must be deployed"
}
