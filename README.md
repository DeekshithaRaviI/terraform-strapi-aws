# Terraform Strapi Deployment on AWS



### A production-ready Infrastructure as Code solution to deploy Strapi CMS on AWS with secure networking and multi-environment support.






## **📋 Task Requirements**



***Deploy a private EC2 instance in AWS VPC with:***

***- ✅ Public and private subnets***

***- ✅ NAT Gateway for outbound internet access***

***- ✅ Security groups for access control***

***- ✅ Key pair for EC2 login***

***- ✅ User data script to auto-install Docker and run Strapi***

***- ✅ Application Load Balancer in public subnet***

***- ✅ Multi-environment support (dev/prod) using tfvars***







## 🏗️ Architecture 



Network Layout:



Internet → ALB (Public Subnets) → EC2 Instance (Private Subnet) → NAT Gateway → Internet




Components:

VPC: 10.0.0.0/16 CIDR block

Public Subnets: Two subnets across different AZs for ALB

Private Subnet: Single subnet for EC2 instance

Internet Gateway: Public subnet internet connectivity

NAT Gateway: Outbound internet for private EC2

Application Load Balancer: Routes HTTP traffic to EC2

EC2 Instance: Amazon Linux 2023 with Docker + Strapi

Security Groups: ALB allows HTTP/HTTPS, EC2 allows port 1337 from ALB only







## 📁 Project Structure





***terraform-strapi/***

***├── provider.tf              # AWS provider configuration***

***├── variables.tf             # Variable definitions***

***├── vpc.tf                   # VPC, subnets, gateways, routes***

***├── security-groups.tf       # Security group rules***

***├── ec2.tf                   # EC2 instance configuration***

***├── alb.tf                   # Load balancer setup***

***├── iam.tf                   # IAM roles for EC2***

***├── user-data.sh             # Bootstrap script***

***├── outputs.tf               # Output values***

***├── dev.tfvars               # Development environment***

***└── prod.tfvars              # Production environment***

***```***







***## 🚀 Deployment***



***### Prerequisites***

***- Terraform v1.0+***

***- AWS CLI configured***

***- AWS key pair created in target region***



***### Deploy Infrastructure***



***```bash***

***# Initialize Terraform***

***terraform init***



***# Review plan***

***terraform plan -var-file=dev.tfvars***



***# Deploy***

***terraform apply -var-file=dev.tfvars***



***# Get application URL***

***terraform output alb\_url***

***```***



***### Switch Environments***



***```bash***

***# Deploy to production***

***terraform apply -var-file=prod.tfvars***



## ***⚙️ Configuration***



### ***Environment Variables***



***\*\*dev.tfvars\*\* - Development Environment***

***- Instance Type: t3.small***

***- Environment tag: dev***

***- Cost-optimized configuration***



***\*\*prod.tfvars\*\* - Production Environment***

***- Instance Type: t3.medium***

***- Environment tag: prod***

***- Production-ready settings***



### ***Strapi Secrets***



***Generate secure secrets for Strapi:***

***```bash***

***openssl rand -base64 32***





***Configure in your `.tfvars` file:***

***- `strapi\_app\_keys`***

***- `strapi\_api\_token\_salt`***

***- `strapi\_admin\_jwt\_secret`***

***- `strapi\_transfer\_token\_salt`***

***- `strapi\_jwt\_secret`***







## ***🌐 Access Application***



***\*\*Application URL:\*\* `http://<alb\_dns\_name>`***  

***\*\*Admin Panel:\*\* `http://<alb\_dns\_name>/admin`***



***Get the ALB DNS from outputs:***

***```bash***

***terraform output alb\_url***





## ***🔐 Security Implementation***



***\*\*Network Security:\*\****

***- EC2 instance in private subnet with no direct internet access***

***- Security groups follow least privilege principle***

***- ALB security group: allows HTTP (80) and HTTPS (443) from internet***

***- EC2 security group: allows port 1337 only from ALB security group***



***\*\*Access Control:\*\****

***- No SSH access configured (use AWS Systems Manager for instance access)***

***- IAM role attached to EC2 for Systems Manager and CloudWatch***

***- NAT Gateway for controlled outbound internet***



***\*\*Secrets Management:\*\****

***- Sensitive variables marked as sensitive in Terraform***

***- Environment-specific secrets in separate tfvars files***

***- Secrets excluded from Git via .gitignore***







## ***🔧 Technical Details***



### ***User Data Script***

***The `user-data.sh` script automatically:***

***1. Updates system packages***

***2. Installs Docker and Docker Compose***

***3. Creates docker-compose.yml with Strapi configuration***

***4. Starts Strapi container with environment variables***

***5. Configures health checks***



### ***Load Balancer Configuration***

***- Target Group: Port 1337, HTTP protocol***

***- Health Check: Root path, 60s interval***

***- Listener: HTTP on port 80, forwards to target group***

***- Target: EC2 instance automatically registered***



### ***High Availability***

***- ALB spans two availability zones***

***- Can easily extend to multi-instance setup***

***- Target group manages instance health***



***---***



## ***📝 Key Features***



***✅ \*\*Infrastructure as Code\*\*: Fully automated, version-controlled infrastructure***  

***✅ \*\*Multi-Environment\*\*: Single codebase for dev and prod***  

***✅ \*\*Security Best Practices\*\*: Private subnet, security groups, no SSH***  

***✅ \*\*Auto-Bootstrap\*\*: EC2 automatically installs and runs Strapi***  

***✅ \*\*Scalable Design\*\*: Easy to extend to multi-instance setup***  

***✅ \*\*Cost Efficient\*\*: Can be destroyed when not in use***  



***---***



## ***🔄 Workflow***



***1. \*\*Development\*\*: Test changes in dev environment***

***2. \*\*Validation\*\*: Verify functionality and costs***

***3. \*\*Production\*\*: Deploy to prod with production tfvars***

***4. \*\*Maintenance\*\*: Update variables or code as needed***

***5. \*\*Cleanup\*\*: Destroy resources when not needed***



***---***



## ***📌 Notes***



***- Default region: us-east-1 (configurable in provider.tf)***

***- Strapi runs on port 1337 inside container***

***- SQLite database used (suitable for development)***

***- For production, consider using RDS for database***

***- All resources tagged with environment and project name***



***---***



## **🤝 Contributing**



***This project demonstrates Terraform best practices for AWS deployments. Feel free to fork and adapt for your needs.***

