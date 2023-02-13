variable "vpc_id" {
  type = string
}


resource "aws_security_group" "http_access" {
  name        = "http_access"
  description = "Allow HTTP access"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.http_access.id
}

