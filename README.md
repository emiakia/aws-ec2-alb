# AWS Infrastructure with Terraform

This Terraform project provisions an AWS infrastructure that includes EC2 instances, a security group, an Application Load Balancer (ALB), a target group, and necessary listener configurations. 
The project is fully modular, allowing you to reuse and customize the components as needed.

## Function
This Terraform project automates the setup of a scalable and secure web application infrastructure on AWS. It provisions EC2 instances, configures security groups, and sets up an Application Load Balancer (ALB) to distribute traffic across multiple servers. The ALB ensures high availability by routing requests to healthy instances, and you can view the DNS name of the ALB in the output.

Once deployed, you can access the application by opening the ALB's DNS URL in your browser. On each refresh, the page content may change as the ALB routes requests to different EC2 instances, demonstrating load balancing in action.

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
   
