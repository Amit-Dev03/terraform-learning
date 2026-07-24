#key-pair (login)
resource aws_key_pair my_key{
	key_name = "terra-key-from-ubuntu-mypc-${terraform.workspace}"
    public_key = file("~/keys/terra-key-from-ubuntu-mypc.pub")  #this is the public key of the key pair which is generated in my local machine
    tags = {
        Name = "terra-key-for-${terraform.workspace}"
    }
}

#vpc setup & security groups
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource aws_security_group my_sg{
  name = "automate-tf-sg-${terraform.workspace}"
  description = "This will add a tf generated sg"

  vpc_id = aws_default_vpc.default.id #this is known as interpolation i.e to inherit or extract the values from a tf block

  tags = {
    Name = "tf-sg-${terraform.workspace}"
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
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.name]

  instance_type = "t3.small"
  ami = "ami-01a00762f46d584a1" #ubuntu ami id

  root_block_device{
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "ec2-${terraform.workspace}"
    Environment = "${terraform.workspace}"
  }
}
