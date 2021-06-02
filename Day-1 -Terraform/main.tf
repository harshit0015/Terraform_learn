resource "aws_instance" "app_server" {
  ami                  = lookup(var.AmiLinux, var.region)
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile-2.name #change test_profile-2
  tags = {
    Name = "devops-my-2" #changes devops-my-2
  }
  # key_name        = "bucket-key1" #changes comment 
  # security_groups = ["${aws_security_group.test_sg.name}"]  #changes  comment


}

resource "aws_s3_bucket" "test" {
  bucket = "harshit0015-bucket-2" #changes bucket name
}


output "instance_ip" {
  value = aws_instance.app_server.public_ip
}