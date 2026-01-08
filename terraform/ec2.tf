############################
# AMI Lookup
############################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

############################
# Security Group
############################

resource "aws_security_group" "sonarqube" {
  name        = "${var.environment}-sg"
  description = "Security group for SonarQube EC2"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "SonarQube Web"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "${var.environment}-sg" }
  )
}

############################
# EC2 Instance
############################

resource "aws_instance" "sonarqube" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.large"
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.sonarqube.id]
  iam_instance_profile   = aws_iam_instance_profile.sonarqube.name
  key_name               = var.environment

  root_block_device {
    volume_type = "gp3"
    volume_size = 50
    delete_on_termination = true
  }

  tags = merge(
    var.tags,
    { Name = "${var.environment}-ec2" }
  )
}
