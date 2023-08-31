# cloudflare-dns.tf | Define cloudflare provider and create DNS records
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.13.0"
    }
    vultr = {
      source = "vultr/vultr"
      version = "2.15.1"
    }
  }
}
# Define Cloudflare provider
provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

# Create www record for Amazon Web Services
resource "cloudflare_record" "aws-www" {
  zone_id    = var.cloudflare_zone_id
  name       = "www"
  value      = aws_eip.aws-web-eip.public_ip
  type       = "A"
  proxied    = true
  depends_on = [aws_eip.aws-web-eip]
}

# Create www record for Azure
resource "cloudflare_record" "azure-www" {
  zone_id    = var.cloudflare_zone_id
  name       = "www"
  value      = azurerm_public_ip.azure-web-ip.ip_address
  type       = "A"
  proxied    = true
  depends_on = [azurerm_public_ip.azure-web-ip]
}

# Create www record for Google Cloud
resource "cloudflare_record" "gcp-www" {
  zone_id    = var.cloudflare_zone_id
  name       = "www"
  value      = google_compute_address.gcp-web-ip.address
  type       = "A"
  proxied    = true
  depends_on = [google_compute_address.gcp-web-ip]
}

# Create www record for vultr
resource "cloudflare_record" "vultr-www" {
  zone_id          = var.cloudflare_zone_id
  name             = "www"
  value             = vultr_instance.my_instance.main_ip
  type               = "A"
  proxied         = true
}

# Create root record for Amazon Web Services
resource "cloudflare_record" "aws-root" {
  zone_id    = var.cloudflare_zone_id
  name       = "@"
  value      = aws_eip.aws-web-eip.public_ip
  type       = "A"
  proxied    = true
  depends_on = [aws_eip.aws-web-eip]
}

# Create root record for Azure
resource "cloudflare_record" "azure-root" {
  zone_id    = var.cloudflare_zone_id
  name       = "@"
  value      = azurerm_public_ip.azure-web-ip.ip_address
  type       = "A"
  proxied    = true
  depends_on = [azurerm_public_ip.azure-web-ip]
}

# Create root record for Google Cloud
resource "cloudflare_record" "gcp-root" {
  zone_id    = var.cloudflare_zone_id
  name       = "@"
  value      = google_compute_address.gcp-web-ip.address
  type       = "A"
  proxied    = true
  depends_on = [google_compute_address.gcp-web-ip]
}

# Create root record for vultr
resource "cloudflare_record" "vultr-root" {
  zone_id    = var.cloudflare_zone_id
  name       = "@"
  value      = vultr_instance.my_instance.main_ip
  type       = "A"
  proxied    = true
}

# Create cloudflare load balancer
resource "cloudflare_load_balancer" "demo_lb" {
  zone_id          = var.cloudflare_zone_id
  name             = cloudflare_record.aws-root.hostname
  fallback_pool_id = cloudflare_load_balancer_pool.demo_lb.id
  default_pool_ids = [cloudflare_load_balancer_pool.demo_lb.id]
  description      = "demo_lb load balancer"
  proxied          = true
  session_affinity = "cookie"
  steering_policy  = "least_outstanding_requests"
  session_affinity_attributes {
      zero_downtime_failover = "sticky"
  }
}

# Create cloudflare load balancer pool
resource "cloudflare_load_balancer_pool" "demo_lb" {
  account_id = var.cloudflare_account_id
  name = "demo-lb-pool"
  check_regions = ["ENAM"]
  monitor = cloudflare_load_balancer_monitor.demo_lb.id
  origins {
    name    = "aws"
    address = aws_eip.aws-web-eip.public_ip
    enabled = true

  }
  origins {
    name    = "azure"
    address = azurerm_public_ip.azure-web-ip.ip_address
    enabled = true

  }
  origins {
    name    = "gcp"
    address = google_compute_address.gcp-web-ip.address
    enabled = true

  }
    origins {
    name    = "vultr"
    address = vultr_instance.my_instance.main_ip
    enabled = true

  }
  description        = "demo load balancer pool"
  enabled            = true
  minimum_origins    = 1
  notification_email = var.cloudflare_notification_email
  origin_steering {
    policy = "random"
  }
}

# Create cloudflare load balancer monitor
resource "cloudflare_load_balancer_monitor" "demo_lb" {
  account_id     = var.cloudflare_account_id
  type           = "http"
  expected_codes = "200"
  method         = "GET"
  timeout        = 5
  path           = "/"
  port           = 80
  interval       = 60
  retries        = 2
  description    = "demo http load balancer"
  header {
    header = "Host"
    values = [cloudflare_record.aws-root.hostname]
  }
  allow_insecure   = false
  follow_redirects = false
}


# Output AWS
output "cloudflare-aws-www-record-id" {
  value = cloudflare_record.aws-www.id
}

output "cloudflare-aws-www-record-hostname" {
  value = cloudflare_record.aws-www.hostname
}

output "cloudflare-aws-root-record-id" {
  value = cloudflare_record.aws-root.id
}

output "cloudflare-aws-root-record-hostname" {
  value = cloudflare_record.aws-root.hostname
}

# Output Azure
output "cloudflare-azure-www-record-id" {
  value = cloudflare_record.azure-www.id
}

output "cloudflare-azure-www-record-hostname" {
  value = cloudflare_record.azure-www.hostname
}

output "cloudflare-azure-root-record-id" {
  value = cloudflare_record.azure-root.id
}

output "cloudflare-azure-root-record-hostname" {
  value = cloudflare_record.azure-root.hostname
}

# Output GCP
output "cloudflare-gcp-www-record-id" {
  value = cloudflare_record.gcp-www.id
}

output "cloudflare-gcp-www-record-hostname" {
  value = cloudflare_record.gcp-www.hostname
}

output "cloudflare-gcp-root-record-id" {
  value = cloudflare_record.gcp-root.id
}

output "cloudflare-gcp-root-record-hostname" {
  value = cloudflare_record.gcp-root.hostname
}

# Output Vultr
output "cloudflare-vultr-www-record-id" {
  value = cloudflare_record.vultr-www.id
}

output "cloudflare-vultr-www-record-hostname" {
  value = cloudflare_record.vultr-www.hostname
}

output "cloudflare-vultr-root-record-id" {
  value = cloudflare_record.vultr-root.id
}

output "cloudflare-vultr-root-record-hostname" {
  value = cloudflare_record.vultr-root.hostname
}