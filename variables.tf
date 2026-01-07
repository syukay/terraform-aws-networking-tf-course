# variable "vpc_cidr" {
#   type = string

#   validation {
#     condition     = can(cidrnetmask(var.vpc_cidr))
#     error_message = "The variable vpc_cidr must contain a valid CIDR block."
#   }
# }

variable "vpc_name" {
  type = string
}

variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block              = string
    public                  = optional(bool, false)
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))

  validation {
    condition     = alltrue([for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))])
    error_message = "All cidr_block entries in subnet_config must contain valid CIDR blocks."
  }
} 