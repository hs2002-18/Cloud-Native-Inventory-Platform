provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Cloud-Native-Inventory-Platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}