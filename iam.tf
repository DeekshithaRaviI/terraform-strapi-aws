# ========================================
# IAM Role for EC2 Instance
# ========================================

resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ec2-role-${var.environment}"
      Environment = var.environment
    }
  )
}

# ========================================
# Attach SSM Managed Policy
# ========================================

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ========================================
# IAM Instance Profile
# ========================================

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile-${var.environment}"
  role = aws_iam_role.ec2_role.name

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ec2-profile-${var.environment}"
      Environment = var.environment
    }
  )
}
