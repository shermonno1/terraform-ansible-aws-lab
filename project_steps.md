# Project Steps: AWS DevOps Infrastructure with Terraform & Ansible

This guide walks through the full setup process for deploying two EC2 web servers behind a Load Balancer using Terraform and Ansible — all from a custom AlmaLinux VM provisioned with Vagrant. Perfect for rebuilding, demonstrating, or extending this project.

## STEP 0: Launch Your Control Node (AlmaLinux VM)

If your VM is not already running, use the following from your host machine terminal:

```
cd ~/aws-automation-rhel
vagrant up
vagrant ssh
```

If you’re not using Vagrant, just ensure you're working inside a Linux system with Terraform, Ansible, and the AWS CLI installed.

## STEP 1: Export AWS Credentials

Inside your VM, source your environment variables:

```
source ~/aws-project-creds.sh
```

This loads:

* AWS\_ACCESS\_KEY\_ID
* AWS\_SECRET\_ACCESS\_KEY
* AWS\_DEFAULT\_REGION

## STEP 2: Navigate to Terraform Directory

```
cd /vagrant/terraform
```

## STEP 3: Run Terraform Apply

```
terraform apply
```

* Confirm with `yes` when prompted
* This will provision:

  * VPC
  * Two public subnets (across different AZs)
  * Security Groups
  * Two EC2 instances
  * An Application Load Balancer (ALB)

Example Output:

```
alb_dns_name = "project-alb-xxxxx.us-east-1.elb.amazonaws.com"
ec2_instance_a_public_ip = "3.95.xxx.xxx"
ec2_instance_b_public_ip = "34.227.xxx.xxx"
```

Copy these IPs and the ALB DNS name for use in the Ansible inventory and browser testing later.

## STEP 4: Update Ansible Static Inventory

Navigate to the Ansible directory:

```
cd /vagrant/ansible
```

Edit the `inventory_static.ini` file:

```
[webservers]
3.95.xxx.xxx ansible_user=ec2-user ansible_ssh_private_key_file=/home/vagrant/project_access/project-key.pem
34.227.xxx.xxx ansible_user=ec2-user ansible_ssh_private_key_file=/home/vagrant/project_access/project-key.pem
```

Adjust the IPs and key path based on your actual setup.

## STEP 5: (Optional) Test EC2 Connection with Ping

```
ansible -i inventory_static.ini webservers -m ping
```

You should see a successful "pong" response from both instances.

## STEP 6: Run the Ansible Playbook

```
ansible-playbook -i inventory_static.ini playbook.yml
```

This will:

* Install Apache on both instances
* Retrieve EC2 metadata from inside the instance (169.254.169.254)
* Generate a custom HTML page from metadata using a Jinja2 template

## STEP 7: View Web Pages (Browser Test)

From your local machine, open the EC2 public IPs in your browser:

```
http://3.95.xxx.xxx
http://34.227.xxx.xxx
```

Each should display:

* Instance ID
* Availability Zone
* Instance Type
* Region

## STEP 8: Test Load Balancer Traffic Distribution

Visit the ALB DNS Name (from Terraform output):

```
http://project-alb-xxxxx.us-east-1.elb.amazonaws.com
```

* Refresh the page several times.
* You should see metadata from both EC2 instances — proving traffic is being distributed.

## STEP 9: Destroy All Resources (CLEANUP)

Back in the Terraform directory:

```
cd /vagrant/terraform
terraform destroy
```

Confirm with `yes` when prompted.

This deletes:

* EC2 instances
* VPC and Subnets
* Security Groups
* Load Balancer

This step is critical to avoid AWS costs.

## Final Notes

* Full deploy time: \~8 minutes
* Metadata is accessed securely via AWS internal IP (169.254.169.254)
* Fully repeatable and version-controlled setup
* Uses static inventory for simplicity, but can be adapted to dynamic inventory for larger-scale setups

Ready to automate AWS infrastructure like a pro? Let's go!

