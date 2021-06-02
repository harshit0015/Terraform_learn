resource "aws_s3_bucket" "bucketbox123" {
  bucket = "harshit0015-bucket-1"
  acl    = "private"

  tags = {
    Name        = "harshit0015-bucket-1"
    Environment = "Prod"
  }
}
