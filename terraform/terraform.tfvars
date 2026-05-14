################################################################################
# 1. GLOBAL SETTINGS
################################################################################
aws_region = "us-east-1"

################################################################################
# 2. VPC & NETWORKING
################################################################################
vpc_cidr_block   = "10.0.0.0/16"
instance_tenancy = "default"
vpc_name         = "panigrahan-vpc"

# --- Public Subnets ---
public_subnet_1_cidr_block = "10.0.1.0/24"
public_subnet_1_name       = "panigrahan-public-subnet-1"
map_public_ip_on_launch_1  = true
public_subnet_1_avail_zone = "us-east-1a"

# --- Gateway & Routing ---
igw_name             = "panigrahan-igw"
public_rt_cidr_block = "0.0.0.0/0"
public_rt_name       = "panigrahan-public-rt"

################################################################################
# 3. SECURITY GROUPS
################################################################################
sg_name         = "panigrahan-sg"
# my_ip           = ["49.206.131.43/32", "157.50.80.166/32", "223.185.128.1/32"]

# Instance 1
public_instance_ami_1              = "ami-05cf1e9f73fbad2e2"
public_instance_type_1             = "t3.large"
public_instance_key_pair_1         = "panigrahan-iamsubbu-keypair"
public_instance_associate_ip_add_1 = true
public_instance_volume_size_1      = 20
public_instance_volume_type_1      = "gp3"
public_instance_name_1             = "Panigrahan-Server"

################################################################################
# 6. S3 BACKEND / STATE STORAGE
################################################################################
tfstate_backup_s3_bucket_name      = "panigrahan-tf-state-bucket"
tfstate_backup_s3_tag_name         = "panigrahan-tf-state-bucket"
tfstate_backup_s3_environment_name = "Dev"