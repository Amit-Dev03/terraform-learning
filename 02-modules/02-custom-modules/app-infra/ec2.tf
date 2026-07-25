#key-pair (login)
resource aws_key_pair my_key{
	key_name = "${var.env}-infra-app-key"
    public_key = file("~/keys/terra-key-from-ubuntu-mypc.pub")  #this is the public key of the key pair which is generated in my local machine
   
    tags = {
        Name = "${var.env}-infra-app-key"
        Environment = var.env
    }
}

#vpc setup & security groups
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
    Environment = var.env
  }
}

resource aws_security_group my_sg{
  name = "tf-sg-${var.env}"
  description = "This will add a tf generated sg"

  vpc_id = aws_default_vpc.default.id #this is known as interpolation i.e to inherit or extract the values from a tf block

  tags = {
    Name = "tf-sg-${var.env}"
    Environment = var.env
  }
}

#inbound rules -> ingress
resource "aws_vpc_security_group_ingress_rule" "allow_my_sg_ssh"{
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

#outbound rules -> egress
resource "aws_vpc_security_group_egress_rule" "allow_my_sg_http"{
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

#ec2 related code

resource "aws_instance" "my_ec2_instance"{
    count = var.instance_count

  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.name]

  instance_type = var.instance_type
  ami = var.ami_id

  root_block_device{
    volume_size = var.env == "prod" ? 10 : 20   
    volume_type = "gp3"
  }

  tags = {
    Name = "ec2-${var.env}"
    Environment = var.env
  }
}
