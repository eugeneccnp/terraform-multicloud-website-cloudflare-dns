# vultr-main.tf | Define Vultr Provider, Security Groups, Computer Instance

# Initialize the Vultr Provider
provider "vultr" {
  api_key = var.vultr_api_key
}


# Define bootstrap file
data "template_file" "vultr_user_data" {
  template = file("vultr-cloud-config.yaml")
  vars = {
    s3bucket   = var.s3bucket
    vultr_logo = var.vultr_logo
  }
}

# Create Vultr Instance for Web Server
resource "vultr_instance" "my_instance" {
  plan              = var.one_cpu_one_gb_ram
  region            = var.vultr_toronto
  os_id             = var.ubuntu_version
  user_data         = data.template_file.vultr_user_data.rendered
  label             = "${var.app_name}-${var.app_environment}-instance"
  enable_ipv6       = true
  backups           = "disabled"
  activation_email  = false
  ddos_protection   = false
  tags              = ["vultr_demo"]
  firewall_group_id = vultr_firewall_group.fwg.id
}

# Define firewall group
resource "vultr_firewall_group" "fwg" {
  description = "${var.app_name}-${var.app_environment}-fwg"
}

# Allow http
resource "vultr_firewall_rule" "http" {
  firewall_group_id = vultr_firewall_group.fwg.id
  protocol          = "tcp"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "80"
  ip_type           = "v4"
}

# Allow https
resource "vultr_firewall_rule" "https" {
  firewall_group_id = vultr_firewall_group.fwg.id
  protocol          = "tcp"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "443"
  ip_type           = "v4"
}

output "external-ip-vultr-web-server" {
  value = vultr_instance.my_instance.main_ip
}
