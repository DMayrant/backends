# this projects sets up two required providers AWS and Random providers

terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # this how you construct a backend in s3
  backend "s3" {
    bucket = "terraform-bucket4567" #copy and past bucket name
    key    = "04-backends/state.tfstate"          # you made a directory(04-backends) with file inside (state.tfstate) 
    region = "us-east-1"                          # You current region

  }
}


provider "aws" {
  region = "us-east-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-${random_id.bucket_suffix.hex}"

}
output "bucket_name" {
  value = aws_s3_bucket.example_bucket.id
}
