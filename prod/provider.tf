provider "aws" {
  region  = "eu-west-1"
  profile = "personal"
  version = "~> 2.13.0"
}

provider "template" {
  version = "~> 2.1.2"
}

//
//provider "cloudflare" {
//  email = "jdarley@gmail.com"
//  token = "1263a246decbdcba1bca6a22425ba0a148192"
//}
