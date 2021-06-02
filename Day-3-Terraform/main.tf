provider "aws" {
  region  = "us-east-2"
}

module "aws"{
 source= "./aws"

}

module "bucket"{
source= "./bucket"
}

module "iam"{
source= "./iam"
}


module "vpc"{
source= "./vpc"
}
