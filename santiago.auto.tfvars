virginia_cidr = "10.10.0.0/16"
# subnet_private = "10.10.1.0/24"
# subnet_public = "10.10.0.0/24" 
subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "Env"     = "pruebas"
  "owner"   = "santiago coronado"
  "cloud"   = "aws"
  "IAC"     = "terraform"
  "PROJECT" = "crocs"
}

sg_ingress_cidr = "0.0.0.0/0"


ec2_spacs = {
  "ami"           = "ami-071226ecf16aa7d96"
  "instance_type" = "t2.micro"
}
enable-monitoreo = 0

list_port_ingres = [443, 80, 22]
