variable "virginia_cidr" {
  description = "cidr de virginia"
  type        = string
  sensitive   = false
}

# variable "subnet_public" {
#   description = "cidr public subnet"
#   type = string

# }

# variable "subnet_private" {
#   description = "subnet privade"
#   type = string
# }

variable "subnets" {
  description = "listas de subnets"
  type        = list(string)
}

variable "tags" {
  description = "tags del proyecto"
  type        = map(string)
}


variable "sg_ingress_cidr" {
  description = "cidr for ingress traffic"
  type = string
}

variable "ec2_spacs" {
  description = "parametros de la instancia"
  type = map(string)
}

variable "enable-monitoreo" {
  type = number
  description = "Habilita el despliegue de un server de monitoreo"
}

variable "list_port_ingres" {
  type = list(number)
  description = "listado de puertos para ingreso en security groups"
}