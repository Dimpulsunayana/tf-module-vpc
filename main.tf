resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-vpc" }
    )
}

resource "aws_subnet" "main" {
  count      = length(var.cidr_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_subnets[count.index]

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-subnet-${count.index +1}" }
  )
}

resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = "370342179741"
  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    { Name = "${var.env}-peering" }
  )
}
