variable "vpc_id" {
  type = string
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "default_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.default.id
}
output "public_subnet_id" {
  value = aws_subnet.public.id
}
