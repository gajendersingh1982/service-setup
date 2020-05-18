#Role for EC2
resource "aws_iam_role" "ec2_role_batch" {
  name = format("%s-%s-%s-%s-batch-role-001", var.prefix, var.region_name, var.stage, var.service)

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Effect": "Allow",
    "Principal": {
        "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole",
    "Sid": ""
    }
]
}
EOF
}

#Instance profile
resource "aws_iam_instance_profile" "ec2_instance_profile_batch" {
  name = format("%s-%s-%s-%s-batch-profile-001", var.prefix, var.region_name, var.stage, var.service)
  role =  aws_iam_role.ec2_role_batch.name
}

###Custom Policies can be defined as per requirement
resource "aws_iam_role_policy" "ec2_policy_batch" {
  name = format("%s-%s-%s-%s-batch-policy-001", var.prefix, var.region_name, var.stage, var.service)
  role = aws_iam_role.ec2_role_batch.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EC2ForPacker",
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        }
    ]
}
EOF
}
