# ################################################################################
# # 1. TERRAFORM STATE STORAGE
# # Creates the S3 bucket to store the remote terraform.tfstate file.
# ################################################################################

# resource "aws_s3_bucket" "s3" {
#   bucket = var.tfstate_backup_s3_bucket_name

#   # Allows the bucket to be deleted even if it contains state files
#   force_destroy = true 

#   tags = {
#     Name        = var.tfstate_backup_s3_tag_name
#     Environment = var.tfstate_backup_s3_environment_name
#   }
# }

# ################################################################################
# # 2. BUCKET SECURITY & SAFETY
# # Enables versioning so you can recover old state files if the current one breaks.
# ################################################################################

# resource "aws_s3_bucket_versioning" "s3_versioning" {
#   bucket = aws_s3_bucket.s3.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }