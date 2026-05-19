################################################################################
# 1. GLOBAL & PROVIDER SETTINGS
################################################################################

variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

################################################################################
# 2. VPC & CORE NETWORKING
################################################################################

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "VPC instance tenancy"
  type        = string
}

variable "vpc_name" {
  description = "Tag name for the VPC"
  type        = string
}

# --- Public Subnets ---

variable "public_subnet_1_cidr_block" {
  type = string
}

variable "public_subnet_1_name" {
  type = string
}

variable "map_public_ip_on_launch_1" {
  type = bool
}

variable "public_subnet_1_avail_zone" {
  type = string
}

################################################################################
# 3. GATEWAYS & ROUTING
################################################################################

variable "igw_name" {
  type = string
}

variable "public_rt_cidr_block" {
  type = string
}

variable "public_rt_name" {
  type = string
}

################################################################################
# 4. SECURITY GROUPS
################################################################################

variable "sg_name" {
  type = string
}

variable "my_ip" {
  description = "Local IP for SSH admin access"
  type        = string
}

################################################################################
# 5. EC2 INSTANCES (Jenkins)
################################################################################

# --- Public Instance 1 ---
variable "public_instance_ami_1" {
  type = string
}

variable "public_instance_type_1" {
  type = string
}

variable "public_instance_key_pair_1" {
  type = string
}

variable "public_instance_associate_ip_add_1" {
  type = bool
}

variable "public_instance_volume_size_1" {
  type = number
}

variable "public_instance_volume_type_1" {
  type = string
}

variable "public_instance_name_1" {
  type = string
}

################################################################################
# 7. S3 BACKEND STORAGE
################################################################################

variable "backup_and_logs_s3_bucket_name" {
  type = string
}

variable "backup_and_logs_s3_tag_name" {
  type = string
}

variable "tfstate_backup_s3_environment_name" {
  type = string
}