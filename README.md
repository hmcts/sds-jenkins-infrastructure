# Jenkins Infrastructure Code for SDS platform

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 0.15.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.cosmosdb](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.sqlapidb](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_key_vault_secret.db](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/managed_disk) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.miroles](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.subidrole](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.usermi](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/data-sources/key_vault) | data source |
| [azurerm_subscription.subid](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_keyvault"></a> [azure\_keyvault](#input\_azure\_keyvault) | Name of the Azure KeyVault to store cosmosdb keys & disk details. | `any` | n/a | yes |
| <a name="input_azure_keyvault_rg"></a> [azure\_keyvault\_rg](#input\_azure\_keyvault\_rg) | Name of the Azure KeyVault resource group. | `string` | `"sds-platform-sbox-rg"` | no |
| <a name="input_builtFrom"></a> [builtFrom](#input\_builtFrom) | Name of the GitHub repository this application is being built from. | `string` | n/a | yes |
| <a name="input_database"></a> [database](#input\_database) | Name of the cosmos database. | `string` | `"jenkins"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_max_throughput"></a> [max\_throughput](#input\_max\_throughput) | The Maximum throughput of SQL database (RU/s). | `string` | `"4000"` | no |
| <a name="input_mi_roles"></a> [mi\_roles](#input\_mi\_roles) | Roles assigned to managed identity | `list` | <pre>[<br>  "Contributor",<br>  "User Access Administrator"<br>]</pre> | no |
| <a name="input_parition_key"></a> [parition\_key](#input\_parition\_key) | Partition Keys for corresponding databases. | `map(any)` | <pre>{<br>  "cve-reports": "/build/git_url",<br>  "performance-metrics": "/_partitionKey",<br>  "pipeline-metrics": "/_partitionKey"<br>}</pre> | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Name of the Subscription. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmos_db_url"></a> [cosmos\_db\_url](#output\_cosmos\_db\_url) | n/a |
| <a name="output_cosmosdb_endpoint"></a> [cosmosdb\_endpoint](#output\_cosmosdb\_endpoint) | n/a |
| <a name="output_cosmosdb_primary_master_key"></a> [cosmosdb\_primary\_master\_key](#output\_cosmosdb\_primary\_master\_key) | n/a |
