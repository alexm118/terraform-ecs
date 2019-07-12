provider "aws" {
  region  = "${var.aws_region}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
  tags = {
      Name = "${var.cluster_name}-Cluster"
      Creator = "${var.creator}"
      Email = "${var.email}"
  }
}

data "template_file" "user_data" {
  template = <<-EOT
    echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config
  EOT
}


resource "aws_launch_template" "launch_template" {
  name = "${var.project_name}-launch-template"
  image_id = "${var.ami_image_id}"
  instance_type = "${var.instance_type}"

  network_interfaces {
    security_groups = "${var.security_group_ids}"
    subnet_id = "${var.subnet_id}"
  }

  user_data = "${base64encode(data.template_file.user_data.rendered)}"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-Launch-Template"
      Creator = "${var.creator}"
      Email = "${var.email}"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.project_name}-ASG"
  availability_zones = "${var.availability_zones}"
  desired_capacity = "${var.desired_size}"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"

  launch_template {
      id = "${aws_launch_template.launch_template.id}"
      version = "$Latest"
  }

  tags = [
      {
        key   =   "Name"
        value =   "${var.project_name}-ASG"
        propagate_at_launch = true
      },
      {
        key   =   "Creator"
        value =   "${var.creator}"
        propagate_at_launch = true
      },
      {
        key   =   "Email"
        value = "${var.email}"
        propagate_at_launch = true
      }
    ]
}

