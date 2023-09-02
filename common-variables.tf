# common-variables.tf | shared variables

# Define application name
variable "app_name" {
  type        = string
  description = "Application name"
  default     = "eugeneccnp"
}

# Define application environment
variable "app_environment" {
  type        = string
  description = "Application environment"
  default     = "demo"
}

# Disable Firewall public access
variable "ssh_source" {
  type        = string
  description = "Disable Firewall public access"
  default     = "0.0.0.0/0"
}

# AWS s3 bucket pointing to my resume
variable "s3bucket" {
  type        = string
  description = "AWS s3bucket"
}

# aws logo
variable "aws_logo" {
  type        = string
  description = "hosted on AWS logo used in resume demo"
}

# azure logo
variable "azure_logo" {
  type        = string
  description = "hosted on azure logo used in resume demo"
}

# gcp logo
variable "gcp_logo" {
  type        = string
  description = "hosted on gcp logo used in resume demo"
}

# vultr logo
variable "vultr_logo" {
  type        = string
  description = "hosted on Vultr logo used in resume demo"
}