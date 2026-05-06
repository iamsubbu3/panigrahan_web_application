################################################################################
# 1. TERRAFORM SETTINGS
# Defines the required version and providers for this project.
################################################################################

terraform {
  # Ensures you are using a compatible version of the Terraform CLI
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

################################################################################
# 2. PROVIDER CONFIGURATION
# Configures how the AWS provider connects to your account.
################################################################################

provider "aws" {
  region = var.aws_region
}