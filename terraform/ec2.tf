################################################################################
# 1. PUBLIC INSTANCE 1 (Jenkins)
# Located in Public Subnet 1
################################################################################

resource "aws_instance" "public_instance-1" {
  ami                         = var.public_instance_ami_1
  instance_type               = var.public_instance_type_1
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  key_name                    = var.public_instance_key_pair_1
  associate_public_ip_address = var.public_instance_associate_ip_add_1

  # --- Storage Configuration ---
  root_block_device {
    volume_size = var.public_instance_volume_size_1
    volume_type = var.public_instance_volume_type_1 
  }

  tags = {
    Name = var.public_instance_name_1
  }
}