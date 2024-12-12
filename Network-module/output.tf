locals {
  subnet_ids = [
    aws_subnet.subnet["pub-subnet2"].id, aws_subnet.subnet["pri-subnet1"].id
  ]
  subnets = {
    "pub-subnet2" = aws_subnet.subnet["pub-subnet2"].id
    "pri-subnet1" = aws_subnet.subnet["pri-subnet1"].id
  }
}
output "subnet_info" {
  value = aws_subnet.subnet
}


output "subnet" {
  value = local.subnet_ids
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "igw_id" {
  value = aws_internet_gateway.project_igw
}