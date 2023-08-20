# common-variables.tf | shared variables

# Define application name
variable "app_name" {
  type = string
  description = "Application name"
  default = "eugeneccnp"
}

# Define application environment
variable "app_environment" {
  type = string
  description = "Application environment"
  default = "demo"
}

# Disable Firewall public access
variable "ssh_source" {
  type        = string
  description = "Disable Firewall public access"
  default     = "0.0.0.0/0"
}

# AWS s3 bucket
variable "s3bucket" {
  type        = string
  description = "AWS s3bucket"
}
