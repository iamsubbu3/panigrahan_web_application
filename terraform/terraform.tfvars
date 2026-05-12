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

public_subnet_2_cidr_block = "10.0.2.0/24"
public_subnet_2_name       = "panigrahan-public-subnet-2"
map_public_ip_on_launch_2  = true
public_subnet_2_avail_zone = "us-east-1b"

public_subnet_3_cidr_block = "10.0.3.0/24"
public_subnet_3_name       = "panigrahan-public-subnet-3"
map_public_ip_on_launch_3  = true
public_subnet_3_avail_zone = "us-east-1c"

# --- Private Subnets ---
private_subnet_1_cidr_block = "10.0.4.0/24"
private_subnet_1_name       = "panigrahan-private-subnet-1"
private_subnet_1_avail_zone = "us-east-1a"

private_subnet_2_cidr_block = "10.0.5.0/24"
private_subnet_2_name       = "panigrahan-private-subnet-2"
private_subnet_2_avail_zone = "us-east-1b"

private_subnet_3_cidr_block = "10.0.6.0/24"
private_subnet_3_name       = "panigrahan-private-subnet-3"
private_subnet_3_avail_zone = "us-east-1c"

# --- Gateway & Routing ---
igw_name             = "panigrahan-igw"
eip_name             = "panigrahan-eip"
nat_gw_name          = "panigrahan-NAT-gw"
public_rt_cidr_block = "0.0.0.0/0"
public_rt_name       = "panigrahan-public-rt"
private_rt_cidr_block = "0.0.0.0/0"
private_rt_name      = "panigrahan-private-rt"

################################################################################
# 3. SECURITY GROUPS
################################################################################
sg_name         = "panigrahan-sg"
# my_ip           = ["49.206.131.43/32", "157.50.80.166/32", "223.185.128.1/32"]

################################################################################
# 4. EC2 INSTANCES (Jenkins)
################################################################################
# Instance 1
public_instance_ami_1              = "ami-05cf1e9f73fbad2e2"
public_instance_type_1             = "t2.medium"
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