# ========================================
# Get Latest Amazon Linux 2023 AMI
# ========================================

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# ========================================
# EC2 Instance (Private Subnet)
# ========================================

resource "aws_instance" "strapi" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  # Key pair (used only if SSH is later enabled via bastion)
  key_name = var.key_name

  # IAM role for SSM / ECR / CloudWatch
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # User data to install Docker and run Strapi
  user_data = templatefile("${path.module}/user-data.sh", {
    strapi_app_keys            = var.strapi_app_keys
    strapi_api_token_salt      = var.strapi_api_token_salt
    strapi_admin_jwt_secret    = var.strapi_admin_jwt_secret
    strapi_transfer_token_salt = var.strapi_transfer_token_salt
    strapi_jwt_secret          = var.strapi_jwt_secret
    environment                = var.environment
  })

  # Re-run user_data when it changes
  user_data_replace_on_change = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ec2-${var.environment}"
      Environment = var.environment
    }
  )

  # Ensure NAT is available before EC2 boots
  depends_on = [aws_nat_gateway.main]
}
