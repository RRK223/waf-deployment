#custom vpc
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { Name = "${var.environment}-vpc" }
  )
}


#az
data "aws_availability_zones" "available" {
  state = "available"
}

#public subnets
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-${count.index}"
      Tier = "public"
    }
  )
}

#private subnets
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 2, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-private-${count.index}"
      Tier = "private"
    }
  )
}

#internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    { Name = "${var.environment}-igw" }
  )
}

# Dont need jastai cha
#nat gateway
# resource "aws_eip" "nat" {
#   domain = "vpc"

#   tags = merge(
#     var.tags,
#     { Name = "${var.environment}-nat-eip" }
#   )
# }

# Dont need jastai cha
# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id

#   tags = merge(
#     var.tags,
#     { Name = "${var.environment}-nat" }
#   )
# }

#route (public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    { Name = "${var.environment}-public-rt" }
  )
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# Dont need jastai cha
#private
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.this.id
#   }

#   tags = merge(
#     var.tags,
#     { Name = "${var.environment}-private-rt" }
#   )
# }


# Dont need jastai cha
# resource "aws_route_table_association" "private" {
#   count          = 2
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }