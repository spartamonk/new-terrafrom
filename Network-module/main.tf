# network module
#create vpc
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"

  #tags = var.tags
}
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}
output "name" {
  value = data.aws_availability_zones.available.names


}
#create subnet public and private

resource "aws_subnet" "subnet" {

  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.subnets
  cidr_block              = cidrsubnet(var.cidr_vpc, 8, each.value.cidr_block)
  map_public_ip_on_launch = each.value.is_public_subnet


  #cidr_block = each.value.cidr_block
  availability_zone = data.aws_availability_zones.available.names[each.value.availability_zone]
  #tags = merge(var.tags, { Name = "${each.value.name}" })
  tags = { Name = "${each.value.name}" }

}
output "subnet_ids" {
  value = aws_subnet.subnet[*]

  # }
  # locals {
  #   is_public_subnet = one({for key,obj in var.subnets : obj if obj.is_public_subnet==true})


}
# output "public_subnet_id" {
#     value = local.is_public_subnet.id

# }


resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.vpc.id
  count  = local.public_subnets ? 1 : 0

  #tags = var.tags

}
## route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-047db0d36700ce12d"
  }

}
resource "aws_route_table_association" "a" {
  subnet_id      = "subnet-05b36ee4173ad053b"
  route_table_id = aws_route_table.rt.id
}
# resource "aws_internet_gateway_attachment" "igw_attachment" {
#   internet_gateway_id = aws_internet_gateway.project_igw.id
#   vpc_id              = aws_vpc.vpc.id
# }
# output "subnet" {
#     value = aws_subnet.subnet

# }
locals {
  public_subnets = anytrue([for subnet in var.subnets : lookup(subnet, "is_public_subnet", false)])
  # public_subnets = { for name, subnet in var.subnets : name => subnet if subnet.is_public_subnet }
}
# output "public_subnets" {
#     value = local.public_subnets

# }

