################################################################################
# 1. SECURITY GROUP DEFINITION
# Acts as a virtual firewall for your EC2 instances and EKS environment.
################################################################################

resource "aws_security_group" "sg" {
  name        = "terraform-sg"
  description = "Security group for inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.sg_name
  }

  ################################################################################
  # 2. INBOUND RULES (INGRESS)
  ################################################################################

  # --- Administrative Access ---
  
   # SSH from your laptop
  ingress {
    description = "SSH from Admin IP / Mates IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = [var.my_ip]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS (EKS Management) from Jump Server only"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # --- Application Traffic ---

  ingress {
    description = "Standard HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins / Application traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SonarQube traffic"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL DB traffic"
    from_port   = 3307
    to_port     = 3307
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ################################################################################
  # 3. OUTBOUND RULES (EGRESS)
  ################################################################################

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}