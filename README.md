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
| [azurerm_key_vault_secret.disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/managed_disk) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kv](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.miroles](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.subidcontributer](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.subiduseraccessadmin](https://registry.terraform.io/providers/hashicorp/azurerm/2.61.0/docs/resources/role_assignment) | resource |
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
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment to deploy the resource. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
