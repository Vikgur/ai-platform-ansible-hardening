package ansible.forbidden

deny[msg] {
  input.task.file == "/etc/shadow"
  input.task.state != "managed"
  msg = "Direct modification of /etc/shadow is forbidden"
}

deny[msg] {
  input.task.role == "firewall"
  input.task.allow_all == true
  msg = "Firewall cannot have default allow"
}

deny[msg] {
  input.task.role == "ssh-hardening"
  input.task.password_authentication == "yes"
  msg = "Password authentication for SSH is forbidden"
}
