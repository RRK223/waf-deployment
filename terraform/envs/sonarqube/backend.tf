terraform {
    backend "s3" {
        bucket = "adex-terraform-states"
        key = "sonarqube/terraform.tfstate"
        region = var.aws_region
    }
}