
resource "aws_iam_role_policy" "test_policy" {
  name = "test-policy"
  role = aws_iam_role.ec2_s3_access_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : [
          "arn:aws:s3:::test",
          "arn:aws:s3:::test/*"
        ]
      },
    ]
  })
}
resource "aws_iam_instance_profile" "test_profile-2" { #change test_profile-2
  name = "test_profile-2"   #change test_profile-2
  role = aws_iam_role.ec2_s3_access_role.name
}

resource "aws_iam_role" "ec2_s3_access_role" {
  name = "s3-role-1" #change s3-role-1

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        },
        
      ]
  })
  tags = {
    tag-key = "tag-value"
  }
}
