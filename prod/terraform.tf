terraform {
  backend "s3" {
    bucket         = "whippetlabs-terraform-state"
    key            = "infrastructure"
    region         = "eu-west-1"
    encrypt        = true
    profile        = "personal"
    dynamodb_table = "whippetlabs-terraform"
  }
}
