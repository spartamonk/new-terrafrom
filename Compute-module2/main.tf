# resource "aws_instance" "project_ec2" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   subnet_id = var.subnet_ids


#   tags = {
#     Name = local.server_name
#   }
# }
# locals {
#   server_name = "${var.name}-${var.instance_name}"
# }
resource "aws_instance" "project_ec2" {
  for_each                    = var.aws_instance
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.has_public_ip
  subnet_id                   = each.value.has_public_ip == false ? "subnet-02de5aedff19e6c44" : "subnet-05b36ee4173ad053b"
  security_groups = each.value.has_public_ip == true? [aws_security_group.bastion_sg.id]: [aws_security_group.webserver_sg.id]
  key_name                    = each.value.key_name
  tags = {
    Name = each.value.name
  }

}


# Bastion sg
resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic from port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic from http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
  tags = {
    Name = "bastion-sg"
  }
}

# Webserver_sg
resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Webserver sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
  tags = {
    Name = "bastion-sg"
  }
  depends_on = [aws_security_group.bastion_sg]
}
