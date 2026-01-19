# ========================================
# Environment
# ========================================

variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "strapi-app"
}

# ========================================
# AWS Provider
# ========================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# ========================================
# Networking
# ========================================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability zone for subnet 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability zone for subnet 2"
  type        = string
}

# ========================================
# EC2 Configuration
# ========================================

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

# ========================================
# Strapi Secrets
# ========================================

variable "strapi_app_keys" {
  description = "Strapi APP_KEYS"
  type        = string
  sensitive   = true
}

variable "strapi_api_token_salt" {
  description = "Strapi API_TOKEN_SALT"
  type        = string
  sensitive   = true
}

variable "strapi_admin_jwt_secret" {
  description = "Strapi ADMIN_JWT_SECRET"
  type        = string
  sensitive   = true
}

variable "strapi_transfer_token_salt" {
  description = "Strapi TRANSFER_TOKEN_SALT"
  type        = string
  sensitive   = true
}

variable "strapi_jwt_secret" {
  description = "Strapi JWT_SECRET"
  type        = string
  sensitive   = true
}

# ========================================
# Tags
# ========================================

variable "common_tags" {
  description = "Common tags applied to all AWS resources"
  type        = map(string)
  default     = {}
}
