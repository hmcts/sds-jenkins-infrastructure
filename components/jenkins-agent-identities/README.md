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

## Additional roles using Azure Role Based Access Control Administrator

In Azure, an RBAC Administrator is a role that governs what roles an identity can assign.

For example, you can grant an identity RBAC Administrator with Storage Account Contributor.

That means the identity can only grant that role specifically over any resources it is an RBAC Administrator of.

In the case of Jenkins, the identity used by the agents can grant Storage Account Contributor access to any resource it creates but it cannot grant Owner.

To define the roles Jenkins can assign, add its name to `additional_roles` in the tfvars file.

```
additional_roles = ["Storage Account Contributor", "Storage Account Data Contributor"]
```