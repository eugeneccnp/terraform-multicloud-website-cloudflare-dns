#Azure authentication variables
variable "azure_subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure_client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

# Linux VM Admin User
variable "azure_linux_admin_password" {
  type        = string
  description = "Linux VM Admin User"
}

# Linux VM Admin Password
variable "azure_linux_admin_user" {
  type        = string
  description = "Linux VM Admin Password"
}
