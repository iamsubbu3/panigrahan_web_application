################################################################################
# 1. TERRAFORM STATE STORAGE
# Creates the S3 bucket to store the remote terraform.tfstate file.
################################################################################

resource "aws_s3_bucket" "s3" {
  bucket = var.backup_and_logs_s3_bucket_name

  # Allows the bucket to be deleted even if it contains state files
  force_destroy = true

  tags = {
    Name        = var.backup_and_logs_s3_tag_name
    Environment = var.tfstate_backup_s3_environment_name
  }
}

################################################################################
# 2. BUCKET SECURITY & SAFETY
# Enables versioning so you can recover old state files if the current one breaks.
################################################################################

/* VERSIONING */

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

/* BLOCK PUBLIC ACCESS */

resource "aws_s3_bucket_public_access_block" "s3_block" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/* SERVER SIDE ENCRYPTION */

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

/* LIFECYCLE POLICY */

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
  bucket = aws_s3_bucket.s3.id

  ##################################################
  # PRODUCTION LOGS
  ##################################################

  rule {
    id     = "app-log-cleanup"
    status = "Enabled"

    filter {
      prefix = "logs/frontend/"
    }

    expiration {
      days = 30
    }
  }

  rule {
    id     = "backend-log-cleanup"
    status = "Enabled"

    filter {
      prefix = "logs/backend/"
    }

    expiration {
      days = 30
    }
  }

  rule {
    id     = "mysql-log-cleanup"
    status = "Enabled"

    filter {
      prefix = "logs/mysql/"
    }

    expiration {
      days = 30
    }
  }

  rule {
    id     = "jenkins-build-log-cleanup"
    status = "Enabled"

    filter {
      prefix = "logs/jenkins-builds/"
    }

    expiration {
      days = 30
    }
  }

  ##################################################
  # JENKINS BACKUPS
  ##################################################

  rule {
    id     = "jenkins-backup-cleanup"
    status = "Enabled"

    filter {
      prefix = "jenkins-backups/"
    }

    expiration {
      days = 30
    }
  }
}