provider "aws" {
  region  = "eu-west-1"
  profile = "personal"
  version = "~> 2.13.0"
}

provider "template" {
  version = "~> 2.1.2"
}
