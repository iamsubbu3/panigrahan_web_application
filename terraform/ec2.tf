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

  user_data = <<-EOF
              #!/bin/bash

              mkdir -p /home/ubuntu/.ssh
              
              echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNuXU8jCT6yf2ZG2woYyY5Lq2XvFGFugl5w+iQL+pUA karthik M R@Laptop-EG1000TU" >> /home/ubuntu/.ssh/authorized_keys
              echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsrOE+e7/YFcUwosp9pVYau3ADF8mdPCo//vFHjm84l hp@PoojithaPoojari" >> /home/ubuntu/.ssh/authorized_keys

              chown -R ubuntu:ubuntu /home/ubuntu/.ssh
              chmod 700 /home/ubuntu/.ssh
              chmod 600 /home/ubuntu/.ssh/authorized_keys
              EOF

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