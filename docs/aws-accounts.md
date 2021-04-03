# AWS Accounts

AWS accounts are managed with Control Tower.

| Account ID     | AWS Short Name                      | Root Credential                     | Description                  | Who Are Admins?                                                | Root MFA? | SSO? |
| -------------- | ----------------------------------- | ----------------------------------- | ---------------------------- | -------------------------------------------------------------- | --------- | ---- |
| `774716672904` | organization-root.artichokeruby.net | AWS – Artichoke [organization root] | Organization root            | aws-root+organization-root@artichokeruby.org, [@lopopolo]      | ✅        | ✅   |
| `322319414017` | Audit                               | AWS – Artichoke [audit]             | View access to security logs | aws-root+organization-root@artichokeruby.org, [@lopopolo]      | ✅        | ✅   |
| `530315796181` | Log archive                         | AWS – Artichoke [log archive]       | Security logs                | aws-root+organization-root@artichokeruby.org, [@lopopolo]      | ✅        | ✅   |
| `447522982029` | forge-project-infrastructure        | AWS – Artichoke [project infra]     | Forge AWS infrastructure     | aws-root+project-infrastructure@artichokeruby.org, [@lopopolo] | ✅        | ✅   |

[@lopopolo]: https://github.com/lopopolo
