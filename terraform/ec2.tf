################################################################################
# 1. PUBLIC INSTANCE 1 (e.g., Ansible/Jenkins Jump Server )
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

# ################################################################################
# # 2. PRIVATE INSTANCE 1
# # Located in Private Subnet 1
# ################################################################################

# resource "aws_instance" "private_instance-1" {
#   ami                         = var.private_instance_ami_1
#   instance_type               = var.private_instance_type_1
#   vpc_security_group_ids      = [aws_security_group.sg.id]
#   subnet_id                   = aws_subnet.private-subnet-1.id
#   key_name                    = var.private_instance_key_pair_1

#   root_block_device {
#     volume_size = var.private_instance_volume_size_1
#     volume_type = var.private_instance_volume_type_1
#   }

#   tags = {
#     Name = var.private_instance_name_1
#   }
# }

# ################################################################################
# # 3. PRIVATE INSTANCE 2
# # Located in Private Subnet 2
# ################################################################################

# resource "aws_instance" "private_instance-2" {
#   ami                         = var.private_instance_ami_2
#   instance_type               = var.private_instance_type_2
#   vpc_security_group_ids      = [aws_security_group.sg.id]
#   subnet_id                   = aws_subnet.private-subnet-2.id
#   key_name                    = var.private_instance_key_pair_2

#   root_block_device {
#     volume_size = var.private_instance_volume_size_2
#     volume_type = var.var.private_instance_volume_type_2 
#   }

#   tags = {
#     Name = var.private_instance_name_2
#   }
# }