# AWS Infrastructure with Terraform

This Terraform project provisions an AWS infrastructure that includes EC2 instances, a security group, an Application Load Balancer (ALB), a target group, and necessary listener configurations. 
The project is fully modular, allowing you to reuse and customize the components as needed.

## Function
  
## Project Structure

- **modules/**: Contains all the Terraform modules used in this project.
  - **security_group/**: Defines the security group configuration.
  - **ec2/**: Handles the provisioning of EC2 instances.
  - **alb/**: Sets up the Application Load Balancer (ALB).
  - **lb_target_group/**: Manages the creation of a target group for the ALB.
  - **lb_listener/**: Configures the ALB listener.
  - **lb_target_group_attachment/**: Attaches the EC2 instances to the target group.
- **main.tf**: The main entry point for the Terraform configuration, orchestrating the use of all modules.
- **variables.tf**: Contains the variable declarations used throughout the project.
- **terraform.tfvars**: Defines the values for the variables used in the project.

## Requirements

- **Terraform**: v1.0.0 or higher
- **AWS CLI**: Configured with appropriate credentials

## Usage

1. **Clone the Repository**

   ```bash
   mkdir terraform-aws-infrastructure
   cd terraform-aws-infrastructure
   git clone https://github.com/emiakia/terraform.git
   
