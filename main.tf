resource "aws_security_group" "web_sg" {

  name = "terraform-web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "devops_server" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = <<-EOF
  #!/bin/bash

  apt update -y

  # Install Git
  apt install -y git

  # Install Docker
  apt install -y docker.io
  systemctl enable docker
  systemctl start docker

  # Add Ubuntu user to Docker group
  usermod -aG docker ubuntu

  # Install Java 21
  apt install -y fontconfig openjdk-21-jre

  # Add Jenkins repository
  mkdir -p /etc/apt/keyrings

  wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

  echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

  apt update -y

  # Install Jenkins
  apt install -y jenkins

  # Add Jenkins to Docker group
  usermod -aG docker jenkins

  # Enable Jenkins
  systemctl enable jenkins

  # Restart Jenkins to load Docker group permission
  systemctl restart jenkins

EOF

  tags = {
    Name = "DevOps-Server"
  }
}

resource "aws_eip" "devops_eip" {
  instance = aws_instance.devops_server.id

  domain = "vpc"

  tags = {
    Name = "DevOps-Server-EIP"
  }
}
