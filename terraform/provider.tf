provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ExcellaCo"
    workspaces {
      name = "terraform-ecs"
    }
  }
}