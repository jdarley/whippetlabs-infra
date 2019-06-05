terraform {
  backend "s3" {
    bucket         = "whippetlabs-tf-state"
    key            = "infrastructure"
    region         = "eu-west-1"
    encrypt        = true
    profile        = "personal"
    dynamodb_table = "whippetlabs-tf-lock"
  }
}

