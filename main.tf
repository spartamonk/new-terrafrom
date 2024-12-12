module "network" {
  source = "./Network-module"
}
module "compute" {
  source = "./Compute-module2"
  vpc_id = module.network.vpc_id
}
# output "igw_id" {
#   value = module.network.igw_id
# }

# locals {
#   public_ip = [for each in module.network.subnet_info: ]
# }
# output "subnets" {
#   value = module.network.subnet_info
# }