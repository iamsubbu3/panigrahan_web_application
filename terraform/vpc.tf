################################################################################
# 1. CORE NETWORKING
# Defines the main VPC and its connection to the public internet.
################################################################################

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

################################################################################
# 2. SUBNET LAYERS
# Defines the public and private subnets across multiple availability zones.
################################################################################

# --- Public Subnets ---
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = var.map_public_ip_on_launch_1
  availability_zone       = var.public_subnet_1_avail_zone

  tags = {
    Name                     = var.public_subnet_1_name
  }
}


################################################################################
# 4. ROUTING
# Tables and associations that direct traffic flow for both layers.
################################################################################

# --- Public Route Table & Associations ---
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_rt_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

resource "aws_route_table_association" "associate_public_1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public_rt.id
}