# Jenkins Agent Managed Identities

This component manages one Jenkins VM-agent managed identity per SDS environment, plus the RBAC required by the new agent templates.

## Roles assigned
- `Contributor` on the target environment subscription
- `Azure Kubernetes Service Cluster Admin Role` on the target environment subscription
- `Private DNS Zone Contributor` on the shared private DNS resource group
- `Cosmos DB Built-in Data Contributor` on the pipeline metrics account
- Membership of `DTS Directory Readers` for AzureAD lookups during Terraform runs

`User Access Administrator` is intentionally not included so the impact can be tested separately.

## Environment tfvars
`environments/jenkins-agent-identities/` contains one tfvars file per SDS environment:
- `sbox`, `dev`, `stg`, `ithc`, `test`, `demo`, `ptlsbox`, `ptl`, `prod`
