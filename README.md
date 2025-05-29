# AWS DevOps Project: Automated Web Server Deployment on EC2 using Terraform & Ansible

## Project Summary

This project demonstrates real-world DevOps principles by automating the deployment and configuration of a scalable, fault-tolerant web application on AWS. Using **Terraform** for infrastructure provisioning and **Ansible** for server configuration, the project provisions two EC2 instances behind a Load Balancer and serves dynamically generated content based on instance metadata.

Designed with repeatability, clarity, and learning in mind, this lab can be adapted for real-world automation scenarios with minimal changes (e.g., dynamic inventory, remote backend).

## Who This Is For

* Students learning AWS and DevOps
* Sysadmins wanting to practice Infrastructure as Code (IaC)
* Anyone building repeatable AWS environments from scratch

## What You'll Learn

* Write and apply Infrastructure as Code with Terraform
* Configure **two EC2 instances** using Ansible
* Understand AWS architecture (VPC, Subnets, Security Groups, ELB)
* Automate instance metadata collection and templated web pages
* Practice safe deployment and teardown to control costs

## What You’ll Build

By the end of this project, you’ll have:

* Two EC2 instances (web servers) in separate subnets & availability zones
* A load balancer distributing traffic between them
* Automatically generated web pages showing dynamic instance metadata
* The ability to test failover and traffic distribution by refreshing the ELB DNS name

---

## Project Structure

```
.
├── Vagrantfile                         # Defines local VM setup for control node
├── ansible
│   ├── ansible.cfg                    # Ansible configuration file
│   ├── inventory_static.ini          # Static inventory file
│   ├── playbook.yml                  # Ansible playbook entry point
│   └── roles
│       └── webserver
│           ├── tasks
│           │   └── main.yml          # Tasks to install and configure webserver
│           └── templates
│               └── index.html.j2     # Jinja2 template for the webpage
├── project_access
│   └── project-key.pem               # PEM file for SSH access to EC2 (excluded from Git)
└── terraform
    ├── main.tf                       # Main Terraform config
    ├── outputs.tf                    # Output variables
    ├── terraform.tfstate             # Terraform state file
    ├── terraform.tfstate.backup      # Backup of state
    ├── terraform.tfvars              # Input variables
    └── variables.tf                  # Variable definitions
```

## Tools Used

* **Terraform** — Infrastructure as Code
* **Ansible** — Configuration Management
* **AWS EC2 & ELB** — Hosting and Load Balancing
* **Apache** — Web Server
* **Vagrant** + VirtualBox/Parallels — Local Dev Environment
* **AlmaLinux** — OS for control node

## Project Features

* Two EC2 instances behind a Load Balancer
* Metadata dynamically injected into Apache-hosted web pages
* Ansible-driven server setup (Apache install, HTML deployment)
* Manual/static and optional dynamic inventory options
* Fully scriptable setup and teardown
* Easily extensible to scale infrastructure (see below)

## Quick Start (TL;DR)

1. `git clone` the project
2. `vagrant up` → `vagrant ssh`
3. `cd terraform && terraform apply`
4. Copy EC2 IPs → update Ansible inventory
5. `cd ../ansible && ansible-playbook playbook.yml`
6. View web pages + test ELB
7. `terraform destroy` to clean up

---

## Prerequisites

This project was tested using a custom AlmaLinux control node managed by Vagrant, but you can also run it on any Linux system.

You’ll need:

* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [Ansible](https://docs.ansible.com/)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* [Vagrant](https://developer.hashicorp.com/vagrant/downloads) *(Optional but recommended)*
* [VirtualBox](https://www.virtualbox.org/) or [Parallels](https://www.parallels.com/)

#### New to Vagrant?

Check out Vagrant's official [getting started guide](https://developer.hashicorp.com/vagrant/tutorials/getting-started/) for setup instructions.

#### Not Using Vagrant?

Just clone the repo into your local Linux environment and make sure your SSH key and AWS credentials are configured properly.

> **Note**: If you're not using Parallels on macOS, ignore any shared folder mount issues related to Parallels Tools.

## How to Use This Project

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/aws-devops-project.git
cd aws-devops-project
```

### 2. Start the Local VM (Optional)

```bash
vagrant up
vagrant ssh
```

### 3. Run Terraform

```bash
cd terraform
terraform init
terraform apply
```

### 4. Configure Ansible Inventory

Update `inventory_static.ini` with your EC2 IPs.

### 5. Run Ansible Playbook

```bash
cd ../ansible
ansible-playbook -i inventory_static.ini playbook.yml
```

### 6. Visit Your Web Pages

Use the public IPs from Terraform output or test load balancer DNS.

### 7. Destroy to Save Cost

```bash
cd ../terraform
terraform destroy
```

---

## Troubleshooting

### SignatureDoesNotMatch / Signature Expired

Clock skew can break AWS auth:

```bash
sudo timedatectl set-ntp yes
```

### Folder Sync Issue

If Vagrant fails to mount `/vagrant`, ensure Parallels Tools or Guest Additions are installed, then:

```bash
vagrant reload
```

### .pem File Permissions

```bash
chmod 400 project-key.pem
```

## .gitignore Recommendation

```
project_access/
*.pem
*.tfstate*
```

## Scaling the Project (Bonus)

Want to deploy **100 web servers** instead of 2?

* Add a `count` attribute in `main.tf` to create multiple instances
* Use `for_each` for ALB target group attachment
* Switch to **dynamic inventory** with Ansible
* Confirm ALB target group capacity
* Use small instance types to save cost

* This project demonstrates why Infrastructure as Code matters. Scaling becomes a parameter change, not a rebuild.*

## Final Thoughts

This project wasn’t about adding complexity. It was about:

* Using the right tools (Terraform, Ansible, Vagrant)
* Understanding AWS deeper
* Building something **secure**, **repeatable**, and **team-ready**

That’s the real DevOps mindset.

---

## GitHub Badge

![Project Status](https://img.shields.io/badge/status-Complete-green)

---

## License

MIT License

---

## Author

Created by Shermon G as part of a real-world DevOps learning experience. Feel free to fork, reuse, and adapt!
