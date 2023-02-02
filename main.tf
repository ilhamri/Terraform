resource "aws_instance" "jenkins_server" {
  ami = var.jenkins_ami
  instance_type = var.jenkins_instance_type
  vpc_security_group_ids = ["sg-0264e51a4aa6e4d5e"]

  key_name = "week20"

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  yum upgrade -y
  amazon-linux-extras install java-openjdk11 -y
  yum install jenkins -y
  systemctl enable jenkins
  systemctl start jenkins
  EOF
}

resource "aws_security_group" "jenkins_security_group3" {
name = "jenkins_security_group3"
description = "Allow SSH and HTTP traffic"

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_s3_bucket" "jenkins_artifacts20562345" {
bucket = "jenkins-artifacts20562345"
acl = "private"
}
