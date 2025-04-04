variable "instancias" {
  type    = set(string)
  default = ["apache"]
}


resource "aws_instance" "ec2_virginia" {
  # count                  = length(var.instancias)
  for_each               = var.instancias
  ami                    = var.ec2_spacs["ami"]
  instance_type          = var.ec2_spacs["instance_type"]
  subnet_id              = aws_subnet.subnet_virginia_public.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("userdata.sh")
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}


resource "aws_instance" "ec2_virginia_monitoring" {
  count                  = var.enable-monitoreo == 1 ? 1 : 0
  ami                    = var.ec2_spacs["ami"]
  instance_type          = var.ec2_spacs["instance_type"]
  subnet_id              = aws_subnet.subnet_virginia_public.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("userdata.sh")
  tags = {
    "Name" = "monitoreo"
  }
}


resource "aws_ec2_instance_state" "apagado" {
  for_each    = var.instancias
  instance_id = aws_instance.ec2_virginia[each.value].id
  state       = "stopped"
}

