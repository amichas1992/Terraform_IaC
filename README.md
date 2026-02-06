AWS Infrastructure as Code (Terraform)

A modular, scalable Infrastructure as Code (IaC) project that provisions a secure web server architecture on AWS. Designed with production-grade best practices, including remote state management, strict network segmentation, and least-privilege security policies.
🏗️ Architecture

The project deploys a 3-tier-style network architecture:

    VPC: Custom VPC with DNS hostnames enabled.

    Networking: Public subnets with auto-assigned public IPs and Route Tables connected to an Internet Gateway.

    Compute: Amazon Linux 2 EC2 instance bootstrapped with Nginx via User Data.

    Security: * Security Groups locked down to specific source IPs (SSH) and open web traffic (HTTP).

        IAM Role: Instance attached to AmazonSSMManagedInstanceCore for secure, keyless management via AWS Systems Manager.

Decision	Why I chose this?	Trade-off / Alternative
Modular Structure	Separating vpc, ec2, and security promotes reusability and clean code (DRY).	Slightly more file overhead than a "monolithic" main.tf.
Remote State (S3)	Prevents state file corruption and enables team collaboration. DynamoDB used for state locking.	Requires a "Bootstrap" phase to create the bucket first.
Dynamic AMI	Using data sources ensures the instance always launches with the latest security patches.	Could introduce unexpected changes if AWS releases a major version update (mitigated via lifecycle block).
IAM Integration	Attaching an Instance Profile allows the server to interact with AWS services without hardcoded secrets.	Adds complexity to the module inputs.

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
    AWS CLI configured with credentials.
    An SSH Key Pair created in AWS (e.g., main-key-v2).

Step 1: Bootstrap (One time setup)
-Create the remote state bucket and locking table.
cd bootstrap
terraform init && terraform apply

Step 2: Deploy Environment
-Deploy the application infrastructure.
cd envs/dev
terraform init
terraform plan
terraform apply

Step 3: Verify
-Terraform will output the website_url. Open it in your browser to see the Nginx welcome page.

🔒 Security Highlights
    No Hardcoded Secrets: No AWS keys are committed to the repo.
    State Encryption: The S3 Backend is encrypted at rest.
    Least Privilege: SSH access is restricted via variables; the EC2 runs with a minimal IAM profile.

📝 Author
Thanos Michas - Cloud Engineer & Terraform Enthusiast.