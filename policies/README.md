Policies directory holds Rego rules for enforcing mandatory hardening and forbidding unsafe configurations.  

- mandatory-hardening.rego: ensures all essential security tasks are applied.  
- forbidden-configs.rego: blocks unsafe configurations from being deployed.  

These policies are integrated into CI to fail PRs that violate security rules.
