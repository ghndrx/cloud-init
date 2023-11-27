
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami           = "ami-06aa3f7caf3a30282"  # Ubuntu 20.04 LTS
    instance_type = "t2.micro"
    associate_public_ip_address = true
    security_groups = [aws_security_group.example_sg]
    root_block_device {
        volume_size = 50
        volume_type = "gp2"
    }

    user_data = base64encode(file("${path.module}/ubuntu-init.yaml"))

    tags = {
        Name = "cloud-init-example"
    }
}

resource "aws_security_group" "example_sg" {
    name        = "example_sg"
    description = "Example security group"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

