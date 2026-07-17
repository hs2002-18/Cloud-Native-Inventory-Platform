provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Cloud-Native-Inventory-Platform"
      ManagedBy   = "Terraform"
      Environment = "bootstrap"
    }
  }
}