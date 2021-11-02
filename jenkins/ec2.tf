
resource "aws_instance" "jenkinsSlaveLinux" {
  ami = "ami-02e136e904f3da870"
  tenancy = "default"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "stop"
  monitoring = false
  count = "1"
  subnet_id = "${aws_subnet.privatesubnet-B.0.id}"
  availability_zone = "${resource.aws_subnet.privatesubnet-B.0.availability_zone}"
  tags = {
    "Name" = "${var.tag}-jenkinsSlaveLinux-${count.index+1}"
  } 
  associate_public_ip_address = false
  disable_api_termination = false
  key_name = aws_key_pair.keypair.id
}

resource "aws_instance" "jenkinsSlaveWindows" {
  ami = "ami-0416f96ae3d1a3f29"
  tenancy = "default"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "stop"
  monitoring = false
  count = "1"
  availability_zone = "${resource.aws_subnet.privatesubnet-B.1.availability_zone}"
  subnet_id = "${aws_subnet.privatesubnet-B.1.id}"
  tags = {
    "Name" = "${var.tag}-jenkinsSlaveWindows-${count.index+1}"
  }  
  associate_public_ip_address = false
  disable_api_termination = false
  key_name = aws_key_pair.keypair.id
}

resource "aws_instance" "jenkinsMaster" {
  ami = "ami-02e136e904f3da870"
  tenancy = "default"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "stop"
  monitoring = false
  count = "1"
  subnet_id = "${aws_subnet.publicsubnet-A.0.id}"
  tags = {
    "Name" = "${var.tag}-jenkinsMaster-${count.index+1}"
  } 
  associate_public_ip_address = true
  disable_api_termination = false
  availability_zone = "${resource.aws_subnet.publicsubnet-A.0.availability_zone}"
  key_name = aws_key_pair.keypair.id
}
resource "aws_ebs_volume" "ebs-jenkinsSlaveLinux" {
  size = "10"
  availability_zone = "${resource.aws_instance.jenkinsSlaveLinux.0.availability_zone}"
  encrypted = true
  type = "standard"
  tags = {
    "Name" = "ebs-jenkinsSlaveLinux"
  }
}

resource "aws_ebs_volume" "ebs-jenkinsSlaveWindows" {
  size = "10"
  availability_zone = "${resource.aws_instance.jenkinsSlaveWindows.0.availability_zone}"
  encrypted = true
  type = "standard"
  tags = {
    "Name" = "ebs-jenkinsSlaveWindows"
  }
}
resource "aws_ebs_volume" "ebs-jenkinsMaster" {
  size = "10"
  availability_zone = "${resource.aws_instance.jenkinsMaster.0.availability_zone}"
  encrypted = true
  type = "standard"
  tags = {
    "Name" = "ebs-jenkinsMaster"
  }
}

resource "aws_volume_attachment" "this-linux-slave" {
  device_name = "/dev/sdg"
  volume_id = aws_ebs_volume.ebs-jenkinsSlaveLinux.id
  instance_id = aws_instance.jenkinsSlaveLinux.0.id
}

resource "aws_volume_attachment" "this-windows-slave" {
  device_name = "/dev/sdg"
  volume_id = aws_ebs_volume.ebs-jenkinsSlaveWindows.id
  instance_id = aws_instance.jenkinsSlaveWindows.0.id
}
resource "aws_volume_attachment" "this-master" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.ebs-jenkinsMaster.id
  instance_id = aws_instance.jenkinsMaster.0.id
}

resource "aws_key_pair" "keypair" {
  key_name = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7WLl6KHoHDueWWx2PF4xahIlEWH61NedWyxJYD7NTJacsJI/AczOyiWx3JIf90Wstnlx2rnXNhin+eIOkxsWmK8dbNzrAiPi7PjcTBRtXsJnl8/aMcEv4Fv4xuembRUeU+VAoQJZXhI+sFGP/UO5adQGJ1Zuj7WF7roFF6HHaMPMil+gHsWnY10dv7GvPhyqwf4Y0LjSukyXGeNOqXF0jNHGma/nXO/TE9QTCOMgztZkLw0BfiA9WQdzL88/B0wunnoy4r+hlgydLYd8lriJWYmMcqK1d2TJ4MU6q9WnIgMswXoaYVKxywVvRPSBfWEMlLmzBlfzvGieyMBxFgAuG+fHGkwnInnsbrEQJ3IzDuqjhVq1TMS6mGg+F5yDytoxDgwkg2M/MTOBnOCv6nDgO7XWUBiiJPHnWJzUbxy0StzkPFdkbNOHpz3U5ylYBbM2SlnlwCRb5Xwj3wN6Vu1wWsNiGwtaJ6RfVD6CIcrBdDFkPkZRY10uatk/xytLrDwE="
}