

resource "aws_instance" "public-instance" {
  ami           = "ami-830c94e3"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public_instance.id]
  key_name        = "network-key"

  tags = {
    Name = "devops-my-3-public"
  }
}

# resource "aws_instance" "private-instance" {
#   ami           = "ami-830c94e3"
#   instance_type   = "t2.micro"
#   subnet_id       = aws_subnet.private-subnet.id
#   security_groups = [aws_security_group.private_instance.id]
#   key_name        = "bucket-key1"

#   tags = {
#     Name = "private-instance-private"
#   }
# }
resource "aws_key_pair" "ssh-key" {
  key_name   = "network-key"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCun99ZCxbAmxQlaGq7cKOSdLMasQmeiD9ipUW6+5RLh/Q5Cim3dmVRupDoUG22uCDnRsKBC9Ovy66RUY2XtR1MzJhNo46xzVBPus7rhKp7H/g55joiNW/UdpxfdL43xWtktTwywf/MeiTk/bXpvXN7vw5toKM3peq88C52EYpBkcKG11MVxjKyhuQ5hCwduxPQ/vqWC9WSN+g585LDbzHuXBqac0km7R01o2ocASxammHZ/W0D1satWUZ6fVjClnkhC8EPdZNj1jOeDTWJUizRe1nLUVf79/Prd33/6AdHJNmYy0RqNQvpORLnZlamwAvMUwzspeajc80cAbwVHrgnoU33MCG6EJwUEY5olQP71KzNi+7+eggBl+OhcndX/KHblCRV5/6i5GV284o9g5OTcr+ZsshKRXmvtDmMefKV1RRG5/j8O1kiKjqxRh/VK3FoDajOyquQ9YuFzrk21FyRnrfEaDvUj5ycdyBEJavZm3iY26/7VHR4D4xxoY+lQ2k= knoldus@knoldus-Vostro-3559"
}
