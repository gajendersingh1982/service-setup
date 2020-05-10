#Role for EC2
resource "aws_iam_role" "ec2_role_admin" {
  name = format("%s-%s-%s-%s-admin-role", var.prefix, var.region_name, var.stage, var.service)

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
resource "aws_iam_instance_profile" "ec2_instance_profile_admin" {
  name = format("%s-%s-%s-%s-admin-profile", var.prefix, var.region_name, var.stage, var.service)
  role =  aws_iam_role.ec2_role_admin.name
}

/*
###Custom Policies can be defined as per requirement
resource "aws_iam_role_policy" "ec2_policy_admin" {
  name = format("%s-%s-%s-%s-admin-policy", var.prefix, var.region_name, var.stage, var.service)
  role = aws_iam_role.ec2_role_admin.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:List*",
            "Resource": "*"
        }
    ]
}
EOF
}
*/
