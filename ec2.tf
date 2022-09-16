resource "aws_instance" "Test-server1" {
  ami                         = var.instance-ami
  instance_type               = "t2.micro"
  key_name                    = "July-KP"
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Test-public-sub1.id

   tags = {
    "name" = "Test-server1"
  }
}

resource "aws_instance" "Test-server2" {
  ami                         = var.instance-ami
  instance_type               = "t2.micro"
  key_name                    = "July-KP"
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Test-public-sub2.id

   tags = {
    "name" = "Test-server2"
  }
}