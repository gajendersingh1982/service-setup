# Define an Amazon Linux AMI.
data "aws_ami" "gateway_ami" {
  most_recent = true

  owners = [
    "137112412989",
    "591542846629",
    "801119661308",
    "102837901569",
    "013907871322",
    "206029621532",
    "286198878708",
    "443319210888",
    "099720109477"
    ]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
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

module "gateway_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  
  # Essential [required for Infra Governance]
  name                    = format("%s-%s-%s-%s-mail-train", var.prefix, var.region_name, var.stage, var.service)
  instance_count          = "1"

  ami                     = data.aws_ami.gateway_ami.id
  instance_type           = var.instance_type_gateway
  key_name                = var.key_name
  monitoring              = false

  vpc_security_group_ids  = [module.gateway_sg.this_security_group_id]
  subnet_ids              = data.terraform_remote_state.infra.outputs.public_subnets

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 30
    }
  ]
  
  tags                    = var.tags
}

# EIP for Batch server
resource "aws_eip" "eip_gateway" {
  vpc = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_eip_association" "eip_assoc_gateway" {
  instance_id = module.gateway_ec2.id[0]
  allocation_id = aws_eip.eip_gateway.id
}