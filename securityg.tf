resource "aws_security_group" "sg" {
  name        = "${var.bucket_name_backend} -sg"
  description = "Usado para expor services na internet"
  vpc_id      = aws_vpc.vpc_fiap.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}