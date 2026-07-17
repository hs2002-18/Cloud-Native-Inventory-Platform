variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "state_bucket_name" {
  description = "Terraform State Bucket Name"
  type        = string
}

variable "lock_table_name" {
  description = "Terraform Lock Table"
  type        = string
}