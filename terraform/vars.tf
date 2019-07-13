variable "creator" {
  description = "Name of creator"
}

variable "email" {
  description = "Email of creator"
}

variable "aws_region" {
  description = "Region to Create VPC"
  default = "us-east-1"
}

variable "cluster_name" {
  description = "Name of ECS Cluster"
}

variable "project_name" {
  description = "Project Name"
}

variable "ami_image_id" {
  description = "AMI ID for ASG"
  default = "ami-0d09143c6fc181fe3"
}

variable "instance_type" {
  description = "Instance Type to use in ASG"
  default = "t2.medium"
}

variable "availability_zones" {
  description = "Availability Zones to Deploy"
  type = list(string)
  default = ["us-east-1a"]
}

variable "desired_size" {
  description = "Desired Size"
  default = 1
}

variable "min_size" {
  description = "Minimum Size"
  default = 1
}

variable "max_size" {
  description = "Maximum Size"
  default = 2
}


variable "security_group_ids" {
  description = "Security GroupIds for launch instance"
  type = list(string)
}

variable "subnet_id" {
  description = "Subnet Ids for launch instance"
}

variable "keypair" {
  description = "AWS Keypair to attach to ASG Instances"
}
