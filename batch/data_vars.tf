# Define an Amazon Linux AMI.
data "aws_ami" "batch_ami" {
  most_recent = true

  owners = ["031852407939"]

  filter {
    name   = "name"
    values = ["ami-gb-batch-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
