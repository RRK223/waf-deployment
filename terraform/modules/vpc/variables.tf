# variable "vpc_name" {
#   type        = string
#   description = "VPC Name"
# }

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod-sonarqube"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project     = "sonarqube"
    Environment = "prod-sonarqube"
    ManagedBy   = "terraform"
  }
}