resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC VIRGINIA-${local.sufix}"
  }
}

resource "aws_subnet" "subnet_virginia_public" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "SUBNET VIRGINIA PUB-${local.sufix}"
  }

}

resource "aws_subnet" "subnet_virginia_private" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "SUBNET VIRGINIA PRIV-${local.sufix}"
  }

}


resource "aws_internet_gateway" "gw_virginia" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_virginia.id
  }
  tags = {
    Name = "public custom route table-${local.sufix}"
  }
}


resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.subnet_virginia_public.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance security group-${local.sufix}"
  description = "allow ssh inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    for_each = var.list_port_ingres
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    name = "allow_tls"
  }
}

module "name_bucket" {
  source      = "./modules/S3"
  name_bucket = "crocs05bucket"
}

output "s3_arm" {
  value = module.name_bucket.s3_arn
}


module "terraform_state_backend" {
  version    = "1.5.0"
  source     = "cloudposse/tfstate-backend/aws"
  namespace  = "crocs"
  stage      = "PRD"
  name       = "terraform"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}


