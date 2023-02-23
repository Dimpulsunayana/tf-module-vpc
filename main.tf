resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-vpc" }
    )
}

resource "aws_subnet" "public_subnet" {
  count      = length(var.public_cidr_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr_subnets[count.index]

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-subnet-${count.index +1}" }
  )
}

resource "aws_subnet" "private_subnet" {
  count      = length(var.private_cidr_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr_subnets[count.index]

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-subnet-${count.index +1}" }
  )
}

resource "aws_vpc_peering_connection" "peer" {
  #peer_owner_id = "370342179741" or we can use like below
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-peering" }
  )
}

#resource "aws_route" "default" {
#  route_table_id            = aws_vpc.main.default_route_table_id
#  destination_cidr_block    = "172.31.0.0/16"
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
#}
#
#resource "aws_route" "default-vpc" {
#  route_table_id            = data.aws_vpc.default_vpc.main_route_table_id
#  destination_cidr_block    = var.cidr_block
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
#}
#
#resource "aws_route" "igw_route" {
#  route_table_id            = aws_vpc.main.default_route_table_id
#  destination_cidr_block    = "0.0.0.0/0"
#  gateway_id                = aws_internet_gateway.igw.id
#}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    local.common_tags,
    { Name = "${var.env}-igw" }
  )
}

#create ec2

#data "aws_ami" "example" {
#  most_recent = true
#  name_regex  = "Centos-8-DevOps-Practice"
#  owners      = ["973714476881"]
#}
#
#resource "aws_instance" "web" {
#  ami           = data.aws_ami.example.id
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [aws_security_group.allow_tls.id]
#  subnet_id   = aws_subnet.public_subnet.*.id[0]
#
#  tags = {
#    Name = "test-centos8"
#  }
#}
#
#resource "aws_security_group" "allow_tls" {
#  name        = "allow_tls"
#  description = "Allow TLS inbound traffic"
#  vpc_id      = aws_vpc.main.id
#
#  ingress {
#    description      = "TLS from VPC"
#    from_port        = 22
#    to_port          = 22
#    protocol         = "tcp"
#    cidr_blocks      = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port        = 0
#    to_port          = 0
#    protocol         = "-1"
#    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
#  }
#
#  tags = {
#    Name = "allow_tls"
#  }
#}


