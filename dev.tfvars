# ========================================
# Environment
# ========================================
environment  = "dev"
aws_region   = "us-east-1"
project_name = "strapi-app"

# ========================================
# Networking
# ========================================
vpc_cidr             = "10.0.0.0/16"

public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.3.0/24"
private_subnet_cidr  = "10.0.2.0/24"

availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

# ========================================
# EC2
# ========================================
instance_type = "t3.small"
key_name      = "deekshnew"

# ========================================
# Strapi Secrets (DEV)
# ========================================
strapi_app_keys            = "SUPrWyXf0BH57lkEVzZRLG3CsaJebgQx"
strapi_api_token_salt      = "ducxU0Xg9C3Gt7SQAeBz4IOkyKVfjJFp"
strapi_admin_jwt_secret    = "iYc6hra9uTmDZzn8LWSQENePRskv1Fx2"
strapi_transfer_token_salt = "ylRN64TjCUD1fxMQ2HgrBhe9c3SqAoLO"
strapi_jwt_secret          = "BqdJQ3CxjiZwrS6aIvzucL7m2lAXYEOn"

# ========================================
# Common Tags
# ========================================
common_tags = {
  Project     = "strapi-app"
  Environment = "dev"
  Owner       = "devops"
}
