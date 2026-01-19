# ========================================
# Environment
# ========================================
environment  = "prod"
aws_region   = "us-east-1"
project_name = "strapi-app"

# ========================================
# Networking
# ========================================
vpc_cidr             = "10.1.0.0/16"

public_subnet_1_cidr = "10.1.1.0/24"
public_subnet_2_cidr = "10.1.3.0/24"
private_subnet_cidr  = "10.1.2.0/24"

availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

# ========================================
# EC2
# ========================================
instance_type = "t3.medium"
key_name      = "deekshnew"

# ========================================
# Strapi Secrets (PROD)
# ========================================
strapi_app_keys            = "vdKYkAaMQEtBNRSoOzV0PC5hWiy6Gbgm"
strapi_api_token_salt      = "ROJAWFHXh7LdDtoZ0mil3jaq81GrUgkI"
strapi_admin_jwt_secret    = "NRz5Y8BJwktul2jHMUCKmTWZFVb7h6xs"
strapi_transfer_token_salt = "AJrkdt34coZCuiS25hbsvMaX0yPfx6e7"
strapi_jwt_secret          = "5pGdLi2qTPaCN80s9txlcfuVyInAjUoS"

# ========================================
# Common Tags
# ========================================
common_tags = {
  Project     = "strapi-app"
  Environment = "prod"
  Owner       = "devops"
}
