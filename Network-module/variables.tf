variable "cidr_vpc" {
  description = "cidr block for vpc"
  type        = string
  default     = "10.0.0.0/16"
}
variable "name_vpc" {
  description = "Name of the vpc"
  type        = string
  default     = "project_vpc"
}
variable "subnets" {
  type = map(object({
    name              = string
    cidr_block        = number
    availability_zone = number
    is_public_subnet  = bool
  }))
  default = {
    "pub-subnet1" = {
      name              = "pub-subnet1"
      cidr_block        = 0
      availability_zone = 0
      is_public_subnet  = true

    }
    "pub-subnet2" = {
      name              = "pub-subnet2"
      cidr_block        = 1
      availability_zone = 1
      is_public_subnet  = true


    }
    "pri-subnet1" = {
      name              = "pri-subnet1"
      cidr_block        = 2
      availability_zone = 2
      is_public_subnet  = false

    }
    "pri-subnet2" = {
      name              = "pri-subnet2"
      cidr_block        = 3
      availability_zone = 3
      is_public_subnet  = false

    }
  }


}
# variable "tags" {
#   type = map(string)
#   default = {
#     Owner=JJTech-model-batch
#     IAC-managed=true
#   }

# }

