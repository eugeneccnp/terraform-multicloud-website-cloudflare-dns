# vultr-variables.tf | Variables for the Vultr module

#VultrAWS authentication variables
variable "vultr_api_key" {
  type        = string
  description = "Vultr API Key"
}

variable "vultr_toronto" {
  description = "Vultr Toronto Region"
  default     = "yto"
}

variable "ubuntu_version" {
  description = "Ubuntu 22.04 LTS x64"
  default     = 1743
}

variable "one_cpu_one_gb_ram" {
  description = "1024 MB RAM,25 GB SSD,1024 BW, Monthly Cost $5"
  default     = "vc2-1c-1gb"
}
