resource "aws_instance" "instance1" {
    ami = "ami-0b9064170e32bde34"
    instance_type = "t2.micro"
    key_name = "samplekey"
    security_groups = ["${aws_security_group.sg.name}"]
    
    tags = {
      Name = "instance1"
    }
}

resource "aws_security_group" "sg" {
  name = "test_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


