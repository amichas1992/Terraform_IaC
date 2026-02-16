AWS Infrastructure as Code Automation (Terraform & CI/CD)

This project demonstrates a modular Infrastructure as Code (IaC) setup on AWS. It provisions a secure, custom VPC and a web server using Terraform, with a fully automated CI/CD pipeline powered by GitHub Actions.
Designed with production-grade best practices, including remote state management,  and least-privilege security policies.

🏗️ Architecture

Designed a single free-tier architecture for this portfolio project to minimize AWS costs while demonstrating core networking concepts.

Network: Custom VPC with a Public Subnet, Internet Gateway, and custom Route Tables.

Compute: Amazon Linux 2 EC2 instance, bootstrapped with Nginx via User Data.

Security:
IAM Role: The instance uses an Instance Profile with the AmazonSSMManagedInstanceCore policy.
Access: Management is performed via AWS Systems Manager (Session Manager), removing the need to open SSH (Port 22) to the public internet.

CI/CD: GitHub Actions pipeline authenticates via OIDC (OpenID Connect), eliminating the need for long-lived AWS Access Keys.


🛠️ Technical Decisions & Trade-offs

Decision,Why I chose this?,Trade-off / Alternative
-Modular Structure,"Separating vpc, ec2, and IAM allows for code reuse and cleaner logic.","Slightly more file overhead than a ""monolithic"" main.tf."
-Remote State (S3),Prevents state file corruption and enables collaboration. DynamoDB is used for locking.,"Requires a ""Bootstrap"" phase to create the bucket first."
-OIDC Authentication,Uses short-lived tokens for GitHub Actions. Much safer than storing static AWS Keys in Secrets.,Setup requires creating a specific OIDC provider in IAM first.
-Single-Tier VPC,Keeps the project within the AWS Free Tier (avoids NAT Gateway costs).,"In a production app, I would add Private subnets for the database layer."


📂 Project Structure

    .
    ├── bootstrap/             # Run this FIRST to set up S3 Backend & DynamoDB
    ├── envs/
    │   └── dev/               # The "Dev" environment (Root Module)
    │       ├── main.tf        # Orchestrates the modules
    │       ├── terraform.tfvars # Configuration values
    │       └── backend.tf     # Remote state configuration
    └── modules/               # Reusable Logic
        ├── vpc/               # Networking (Subnets, IGW, Route Tables)
        ├── ec2/               # Compute & UserData scripts
        ├── security/          # Firewalls (Security Groups)
        └── iam/               # Identity & Permissions


🚀 How to Deploy
Prerequisites
    Terraform v1.6+ installed.
    AWS CLI configured.

Step 1: Bootstrap (One time setup)
-Create the remote state bucket and locking table.
Bash
cd bootstrap
terraform init && terraform apply

Step 2: Deploy infrastructure.
Bash
cd envs/dev
terraform init
terraform plan
terraform apply

Step 3: Verify
Web: Visit the website_url output in your browser to see the Nginx welcome page.
Management: Connect via AWS Systems Manager (SSM) or use the AWS CLI:
Bash: aws ssm start-session --target <instance_id>


🤖 CI/CD Pipeline
The project includes a GitHub Actions workflow (main.yml) that runs on every Push or Pull Request.
Format & Validate: Checks Terraform code style (fmt) and syntax validity.
Plan: Runs terraform plan to visualize changes before applying.
Apply: (Main branch only) Automatically applies the infrastructure changes using OIDC credentials.


🔒 Security Highlights
No Hardcoded Secrets: No AWS keys are committed to the repo.
State Encryption: The S3 Backend is encrypted at rest.
Least Privilege: SSH access is restricted via variables; the EC2 runs with a minimal IAM profile.

📝 Author
Thanos Michas - Cloud Engineer & Terraform Enthusiast.