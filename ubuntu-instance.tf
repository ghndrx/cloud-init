
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami           = "ami-0c94855ba95c71c99"  # Ubuntu 20.04 LTS
    instance_type = "t2.micro"
    associate_public_ip_address = true

    root_block_device {
        volume_size = 50
        volume_type = "gp2"
    }

    user_data = file("${path.module}/ubuntu-init.yaml")

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

resource "aws_security_group" "example_sg" {
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    }
}