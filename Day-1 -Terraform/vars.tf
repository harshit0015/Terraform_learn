# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "us-east-1"
}
variable "AmiLinux" {
  type = map(any)
  default = {
    us-east-1 = "ami-0d5eff06f840b45e9" # Virginia
  }
  description = "have only added one region"
}
