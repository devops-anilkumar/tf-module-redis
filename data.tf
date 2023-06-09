# RETRIVES THE INFORMATION FROM THE REMOTE STATE FILE
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "state-terraformbucket"
    key = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}