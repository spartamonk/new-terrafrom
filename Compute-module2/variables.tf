# variable "ami" {
#     type = string
#     description = "ami id"
#     default = "ami-0984f4b9e98be44bf"
# }
# variable "instance_type" {
#     type = string
#     description = "instance type"
#     default = "t2.micro"
# }
# variable "name" {
#     type = string
#     description = "instance name"
#     default = "pro_ec2"
# }
# variable "subnet_ids" {
#     type = string
#     description = "subnet id"

# }
# variable "instance_name" {
#     type = string
#     description = "instance name"

# }
variable "aws_instance" {
  type = map(object({
    name          = string
    ami           = string
    instance_type = string
    has_public_ip = bool
    key_name      = string
    #subnet_ids = string
  }))
  default = {
    "instance-1" = {
      name          = "bastion-host"
      ami           = "ami-0166fe664262f664c"
      instance_type = "t2.micro"
      has_public_ip = true
      key_name      = "jenkins"
    }
    "instance-2" = {
      name          = "web-server"
      ami           = "ami-0166fe664262f664c"
      instance_type = "t2.micro"
      has_public_ip = false
      key_name      = ""
    }
  }
}

variable "bastion_sg" {
  type = map(object({
    description = string
    port        = number
    name        = string
  }))
  default = {
    "ssh" = {
      description = "Allow ssh from internet"
      port        = 22
      name        = "bastion host"
    }
    "http" = {
      port        = 80
      description = "Allow http from internet"
      name        = "bastion host"
    }
  }
}

variable "vpc_id" {
  type = string
}


